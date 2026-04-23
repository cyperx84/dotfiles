---
description: Use when the user wants to write, format, convert, or direct a script for Google's Gemini 3.1 Flash TTS (model id gemini-3.1-flash-tts-preview). Triggers on requests like "write a TTS script", "format this for Gemini TTS", "turn this into a podcast script", "add audio tags", "multi-speaker dialogue for TTS", or any mention of gemini-3.1-flash-tts-preview / Google AI Studio Audio Playground.
---

# Gemini 3.1 Flash TTS Scriptwriter

Write production-ready scripts for `gemini-3.1-flash-tts-preview` across any genre: ads, podcasts, audiobooks, explainers, drama, meditation, IVR, game VO, news, characters, etc.

## Model constraints (hard limits)

- Model id: `gemini-3.1-flash-tts-preview`
- Input: ≤ 8,192 tokens. Output: ≤ 16,384 tokens (audio only, no streaming).
- Max **2 speakers** per generation. For >2 voices, split into multiple calls and stitch.
- Speaker names in the transcript **must exactly match** the `speaker_voice_configs` names passed in the API.
- 70+ languages; ~30 prebuilt voices (Kore, Puck, Charon, Leda, Orus, Zephyr, Fenrir, Aoede, Callirhoe, Autonoe, Enceladus, Iapetus, Umbriel, Algieba, Despina, Erinome, Algenib, Rasalgethi, Laomedeia, Achernar, Alnilam, Schedar, Gacrux, Pulcherrima, Achird, Zubenelgenubi, Vindemiatrix, Sadachbia, Sadaltager, Sulafat).

## The template

Everything above `TRANSCRIPT:` steers delivery; only `TRANSCRIPT:` is required. Scale sections up or down to the job — a 10-second ad doesn't need a scene study.

```
AUDIO PROFILE: <name> — <one-line role/archetype>
SCENE: <location, time, mood, stakes>
DIRECTOR'S NOTES:
  Style: <tone, warmth, vocal smile, brightness>
  Dynamics: <projection, consonant crispness, emphasis>
  Pace: <tempo, cadence, where to breathe>
  Accent: <region/dialect or "neutral">
SAMPLE CONTEXT: <one-line archetype + use case>
TRANSCRIPT:
<lines with [inline tags]>
```

For multi-speaker, prefix every line with `Name:` — the name must match what's registered in the API call.

```
Joe: [curious] Did you actually read the whole thing?
Jane: [laughs] Every page. [sigh] Regretting it now.
```

## Audio tags reference

Tags are square-bracketed and sit inline at the point they should fire. They work mid-sentence. Freeform descriptors are allowed — if it reads like a stage direction, it'll usually work.

| Category | Tags |
|---|---|
| Non-speech | `[sigh]` `[laughs]` `[laughing]` `[giggles]` `[uhm]` `[clears throat]` `[gasp]` `[yawn]` |
| Emotion | `[excited]` `[bored]` `[curious]` `[scared]` `[sarcastic]` `[sincere]` `[melancholy]` `[angry]` `[warm]` `[playful]` |
| Delivery | `[whispering]` `[shouting]` `[robotic]` `[vocal smile]` `[deadpan]` `[breathy]` `[confidential]` |
| Pace | `[short pause]` `[medium pause]` `[long pause]` `[slow]` `[extremely fast]` |
| Creative | `[like a cartoon dog]` `[radio announcer voice]` `[noir detective]` `[reading a bedtime story]` |

Rules of thumb:
- One emotion tag per beat — stacking (`[excited][whispering]`) reads as jitter.
- Put the tag immediately before the phrase it modifies, not at the start of the line.
- Prefer a single `[medium pause]` over three commas. Commas ≠ timing.
- Punctuation still matters: `?`, `!`, and `—` shape prosody.

## Genre playbook

Pick the closest match and adapt. Each one is a known-good shape.

### 30-second ad / promo

```
AUDIO PROFILE: Warm Retail Host — upbeat brand narrator
DIRECTOR'S NOTES:
  Style: vocal smile, confident, inviting
  Dynamics: projected, crisp, clear CTAs
  Pace: brisk; land the offer, linger on the brand
  Accent: general American
TRANSCRIPT:
[warm] Tired of Mondays that feel like Wednesdays? [short pause] Meet Brew&Co — [vocal smile] the coffee that actually shows up for you. [excited] This week only, twenty percent off your first bag. [confidential] Use code WAKE. [medium pause] Brew&Co. [slow] Taste the difference.
```

### Two-host podcast cold open

```
AUDIO PROFILE A: Sam — curious, warm co-host
AUDIO PROFILE B: Rae — dry, deadpan co-host
SCENE: Studio, mid-morning, casual rapport.
DIRECTOR'S NOTES:
  Style: conversational, unpolished on purpose
  Pace: overlap-adjacent; let beats breathe
TRANSCRIPT:
Sam: [excited] Okay, so — I finally tried the thing.
Rae: [deadpan] The thing.
Sam: [laughs] The cold plunge.
Rae: [sarcastic] And you're alive. Incredible reporting.
Sam: [warm] I mean, barely.
```

### Audiobook narration

```
AUDIO PROFILE: Omniscient Narrator — literary, unhurried
DIRECTOR'S NOTES:
  Style: cinematic, grounded, no vocal smile
  Dynamics: intimate, close-mic feel
  Pace: slow, with room to breathe at paragraph ends
  Accent: mid-Atlantic
TRANSCRIPT:
[slow] The house remembered things the family had chosen to forget. [medium pause] In the hallway, the light shifted — [breathy] as if someone had just walked through it. [long pause] Nora set down her coffee.
```

### Explainer / product demo

```
AUDIO PROFILE: Friendly Explainer — clear, teacherly
DIRECTOR'S NOTES:
  Style: bright, patient, confident without being perky
  Pace: measured; pause after each concept
TRANSCRIPT:
[warm] Here's how it works. [short pause] You drop in a file — any format — [medium pause] and we handle the rest. [curious] Want to see what that actually looks like? [vocal smile] Let's try one.
```

### Guided meditation

```
AUDIO PROFILE: Meditation Guide — hushed, anchored
DIRECTOR'S NOTES:
  Style: breathy, low, unhurried
  Dynamics: very soft projection
  Pace: extremely slow; long rests between phrases
TRANSCRIPT:
[breathy] Settle in. [long pause] Feel the weight of your body. [long pause] [whispering] Inhale. [medium pause] And release. [long pause] There is nothing to do right now. [long pause] Only this breath.
```

### Character / game VO

```
AUDIO PROFILE: Kael — world-weary rogue, early 40s
DIRECTOR'S NOTES:
  Style: gravel, smirk under the words, noir detective
  Accent: low-register English
TRANSCRIPT:
[sarcastic] Oh, a quest. [laughs] Haven't heard that one before. [medium pause] [sincere] Fine. But if we die in there, [deadpan] I'm haunting you first.
```

### IVR / phone system

```
AUDIO PROFILE: IVR Voice — neutral, trustworthy utility
DIRECTOR'S NOTES:
  Style: clear, unemotional, no vocal smile
  Pace: deliberate; every digit distinct
TRANSCRIPT:
[slow] Thank you for calling Meridian Bank. [medium pause] For account balances, press one. [medium pause] For card services, press two. [medium pause] To speak with an agent, [short pause] press zero.
```

### News read

```
AUDIO PROFILE: News Anchor — authoritative, neutral
DIRECTOR'S NOTES:
  Style: even, credible, zero vocal smile
  Dynamics: forward, crisp consonants
  Pace: standard broadcast cadence
TRANSCRIPT:
[sincere] Good evening. [short pause] Markets closed lower today after the central bank signaled a slower path on rate cuts. [medium pause] Our economics desk has the details.
```

## Workflow when the user asks for a script

1. **Nail the brief in one pass.** If unclear, ask — in a single question — for: genre, speaker count, length/duration target, voice character(s), language/accent, and any must-hit lines or CTAs. Don't ping-pong.
2. **Pick the closest genre template** above and adapt — don't reinvent the shape.
3. **Write the transcript first, tags second.** Sketch the words, then mark the delivery. Avoid tag-soup drafts.
4. **Budget the length.** Rough rule: ~150 words ≈ 60 seconds at normal pace. Count words; trim before adding flourish.
5. **Name speakers consistently.** If multi-speaker, remind the user the names must match the API `speaker_voice_configs`.
6. **Default to fenced code blocks** for the final script so it's copy-pasteable into AI Studio or a Python `contents=` string.

## Minimal API stub (for reference, not required output)

```python
from google import genai
from google.genai import types

client = genai.Client()

response = client.models.generate_content(
    model="gemini-3.1-flash-tts-preview",
    contents=prompt,  # the script text from this skill
    config=types.GenerateContentConfig(
        response_modalities=["AUDIO"],
        speech_config=types.SpeechConfig(
            multi_speaker_voice_config=types.MultiSpeakerVoiceConfig(
                speaker_voice_configs=[
                    types.SpeakerVoiceConfig(
                        speaker="Joe",
                        voice_config=types.VoiceConfig(
                            prebuilt_voice_config=types.PrebuiltVoiceConfig(voice_name="Kore"))),
                    types.SpeakerVoiceConfig(
                        speaker="Jane",
                        voice_config=types.VoiceConfig(
                            prebuilt_voice_config=types.PrebuiltVoiceConfig(voice_name="Puck"))),
                ]
            )
        ),
    ),
)
# response.candidates[0].content.parts[0].inline_data.data  -> WAV bytes
```

## Anti-patterns

- Stuffing every line with tags — the model reads over-direction as noise.
- Using `[pause]` alone (not a valid tag) — use `[short pause]` / `[medium pause]` / `[long pause]`.
- More than 2 named speakers in one transcript — the model will collapse or mis-assign voices.
- Embedding SSML — this model uses bracketed tags, not SSML.
- Writing stage directions as prose ("she said sadly") — use a tag: `[melancholy]`.
