# 🤖 Local MLX Gemma 4 — Setup & Optimization

Local **Gemma 4 12B** (multimodal) running on **MLX** on a 32 GB base **M4**, serving an OpenAI-compatible endpoint for the **OpenClaw** and **Hermes** agent harnesses, plus a `gemma` terminal CLI. Migrated off Ollama (GGUF) to MLX for better Apple-Silicon performance.

> **TL;DR**: One `mlx_vlm.server` on `:8081` serving `gemma-4-12B-it-qat-4bit`, managed by launchd, with **MTP speculative decoding (~2× faster)**, vision, and a permanent GPU memory bump. OpenClaw + Hermes default to cloud **gpt-5.5**; local Gemma is a fallback + the `gemma` CLI.

---

## 🧱 Architecture

```
                        ┌─────────────────────────────────────────┐
  openclaw  ───────────▶│  mlx_vlm.server  :8081/v1                │
  hermes    ───────────▶│  (OpenAI-compatible: chat + vision +     │──▶ Gemma 4 12B QAT 4-bit (~11 GB)
  gemma CLI ───────────▶│   tool_calls + MTP speculative decoding) │     + MTP drafter (238 MB)
                        └─────────────────────────────────────────┘
                              managed by launchd (auto-start)
```

- **Model**: `mlx-community/gemma-4-12B-it-qat-4bit` — Google QAT 4-bit, the one 4-bit build that keeps the full multimodal stack. ~11 GB.
- **Server**: **`mlx_vlm.server`** — *not* `mlx_lm.server` (that one is text-only; it skips Gemma 4's vision weights). mlx-vlm gives text **+ vision + `--enable-thinking` toggle + `--draft-model` speculative decoding**.
- **Port `8081`** — deliberately not `8080`, which OpenClaw reserves for its searxng web-search engine.

---

## ⚙️ Install (reproducible)

```bash
# 1. mlx-vlm from git main (PyPI lacks the new gemma4_unified loader)
uv tool install --force "mlx-vlm @ git+https://github.com/Blaizzy/mlx-vlm.git"

# 2. Remove hf_xet — its parallel-connection downloader DEADLOCKS on slow links.
#    Plain single-stream HTTPS is reliable.
uv pip uninstall hf-xet --python ~/.local/share/uv/tools/mlx-vlm/bin/python

# 3. Pull the model + the MTP speculative-decoding drafter (HF token recommended)
export HF_TOKEN=...        # from gopass: gopass show -o apis/HUGGING_FACE_API_KEY
huggingface-cli download mlx-community/gemma-4-12B-it-qat-4bit
huggingface-cli download mlx-community/gemma-4-12B-it-qat-assistant-4bit   # 238 MB drafter
```

> ⚠️ **Gotcha**: PyPI `mlx-lm`/`mlx-vlm` releases predate Gemma 4 and fail with `Model type gemma4_unified not supported`. You **must** install from git main. Don't `uv tool upgrade` to a PyPI release until it catches up.

---

## 🚀 The server (launchd, auto-start)

`~/Library/LaunchAgents/com.user.mlx-gemma4.plist` runs:

```
mlx_vlm.server \
  --model mlx-community/gemma-4-12B-it-qat-4bit \
  --host 127.0.0.1 --port 8081 \
  --max-tokens 8192 \
  --draft-model mlx-community/gemma-4-12B-it-qat-assistant-4bit \
  --draft-kind mtp
```
with `HF_HUB_OFFLINE=1` (instant cache load), `RunAtLoad` + `KeepAlive`. Logs → `/tmp/mlx_server.log`.

```bash
# control
launchctl bootout   gui/$(id -u)/com.user.mlx-gemma4              # stop
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.user.mlx-gemma4.plist   # start
tail -f /tmp/mlx_server.log

# run manually in a terminal instead (stop the service first — only one copy fits 32 GB)
HF_HUB_OFFLINE=1 mlx_vlm.server --model mlx-community/gemma-4-12B-it-qat-4bit \
  --host 127.0.0.1 --port 8081 --max-tokens 8192 \
  --draft-model mlx-community/gemma-4-12B-it-qat-assistant-4bit --draft-kind mtp
```

---

## ⚡ Optimizations

| Lever | What | Result |
|---|---|---|
| **MTP speculative decoding** | drafter `gemma-4-12B-it-qat-assistant-4bit` (238 MB) + `--draft-kind mtp` | **8.4 → ~16–17 tok/s (~2×)**, byte-identical greedy output, negligible memory |
| **Thinking off** | mlx-vlm default (no `--enable-thinking`) | no hidden reasoning block before answers → snappier agent turns |
| **Prompt caching** | mlx-vlm built-in (`apc`/`vision_cache`) | reuses the system-prompt prefix; e.g. Hermes' 16 K prompt: 2.5 min cold → ~10 s cached |
| **GPU wired memory** | LaunchDaemon → `sysctl iogpu.wired_limit_mb=24576` at boot | GPU gets 24 GB of 32 GB (leaves 8 for macOS); permanent across reboots |

**Speedup is workload-dependent** (speculative decoding accepts more drafted tokens on predictable text):
reasoning ~2.0× · code ~1.9× · vision ~2× · factual ~1.5× · creative ~1×. Agent work (code/reasoning/tool-calls) sits in the ~2× zone.

### Sampling (per-request — mlx-vlm has no server-side flags)
- **General chat** (`gemma` CLI): Gemma 4's recommended `temperature 1.0, top_p 0.95, top_k 64`.
- **Agent / tool-calling**: lower to `temperature ~0.3` for reliable tool selection & valid arguments.

### Permanent GPU memory bump
`~/.local/bin/install-wired-limit.sh` (run once with `sudo`) installs
`/Library/LaunchDaemons/com.user.iogpu-wired-limit.plist` which applies `iogpu.wired_limit_mb=24576` at every boot.

---

## 🔌 Client wiring

### `gemma` CLI — `~/.local/bin/gemma`
Quick terminal chat against the running server (no extra memory):
```bash
gemma "your question"            # one-shot
gemma                            # interactive chat
gemma -i image.png "what's this?" # vision
```

### Hermes — `~/.hermes/config.yaml`
Default is cloud **gpt-5.5** (local Gemma was too slow for its heavy 16 K-prompt loops):
```yaml
model:
  default: gpt-5.5
  provider: openai-codex
  base_url: ''
```
To point Hermes back at local Gemma: `default: mlx-community/gemma-4-12B-it-qat-4bit`, `provider: custom`, `base_url: http://localhost:8081/v1`.

### OpenClaw — `~/.openclaw/openclaw.json`
- Custom provider `mlx`: `api: openai-completions`, `baseUrl: http://localhost:8081/v1`.
- All four agents (main/builder/researcher/ops) primary = **`openai/gpt-5.5`**; local Gemma is the **last-resort fallback** (`mlx/mlx-community/gemma-4-12B-it-qat-4bit`).
- **Per-agent auth**: each isolated agent has its own auth store; the `openai:` oauth profile had to be copied from `main` to the sub-agents for them to run gpt-5.x.
- The working model ref is **`openai/gpt-5.5`** (codex harness via oauth), **not** `openai-codex/gpt-5.5`. Note: `openclaw infer model run` validates against the catalog only and can't see codex passthrough — test via the real agent (`openclaw agent --agent <id> --message "..." --json`).

### Ollama
Kept **only for embeddings** (`nomic-embed-text` → OpenClaw memory search). The old Gemma 4 GGUF chat models (`gemma4-12b-256k`, `gemma4:12b`) were removed.

---

## 🩺 Quick reference

```bash
# health / smoke test
curl -s localhost:8081/v1/models
gemma "say hi"

# benchmark generation speed (reads mlx-vlm's own timings)
curl -s localhost:8081/v1/chat/completions -H 'Content-Type: application/json' \
  -d '{"model":"mlx-community/gemma-4-12B-it-qat-4bit","messages":[{"role":"user","content":"Write an LRU cache in Python."}],"max_tokens":200,"temperature":0}' \
  | python3 -c "import sys,json;t=json.load(sys.stdin)['timings'];print(t['predicted_per_second'],'tok/s')"

# verify openclaw end-to-end on local Gemma
openclaw infer model run --model mlx/mlx-community/gemma-4-12B-it-qat-4bit --prompt "hello"
```

## ⚠️ Gotchas recap
- **git main only** for mlx-vlm/mlx-lm (gemma4_unified) — PyPI breaks.
- **Remove `hf_xet`** or downloads stall on slow connections.
- **Port 8081**, not 8080 (searxng).
- **`mlx_vlm.server`**, not `mlx_lm.server` (vision).
- **`openai/gpt-5.5`** ref for OpenClaw, with the `openai:` oauth profile present in each agent's auth store.
- Only **one ~11 GB model fits 32 GB** — stop the service before running a second loader.
