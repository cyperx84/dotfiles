# Kanata Keyboard Configuration Documentation

> **Version:** 1.1  
> **Last Updated:** December 2024  
> **Target System:** macOS (Apple Silicon)  
> **Keyboards:** Apple Internal Keyboard, MX Mechanical

---

## Table of Contents

1. [Overview](#overview)
2. [Architecture](#architecture)
3. [Layer Reference](#layer-reference)
   - [Base Layer](#base-layer)
   - [Symbols Layer](#symbols-layer-space-hold)
   - [Numbers Layer](#numbers-layer-apostrophe-hold)
   - [Function Layer](#function-layer-fn-hold)
   - [Vanilla Layer](#vanilla-layer-no-home-row-mods)
4. [Visual Layer Maps](#visual-layer-maps)
5. [Quick Reference Card](#quick-reference-card)
6. [Installation](#installation)
7. [Usage Guide](#usage-guide)
8. [Customization](#customization)
9. [Troubleshooting](#troubleshooting)
10. [Design Rationale](#design-rationale)

---

## Overview

This kanata configuration transforms a standard keyboard into an ergonomic, layer-based input system optimized for **Python development** and **terminal/Neovim workflows**.

### Key Features

| Feature | Implementation |
|---------|----------------|
| Home Row Mods | ASDF/JKL; become modifiers when held |
| Symbol Layer | Space-hold activates programming symbols |
| Number Layer | Apostrophe-hold activates numpad |
| Vim-friendly Caps | Escape on tap, Control on hold |
| Hyper Key | Tab-hold becomes Cmd+Alt+Shift+Ctrl |
| Layer Toggle | Switch between HRM and vanilla modes |

### Goals

1. **Reduce finger travel** - Keep hands on home row
2. **Future-proof for smaller keyboards** - All symbols accessible without number row
3. **Python-optimized** - Prioritize `()`, `[]`, `{}`, `_`, `:` placement
4. **Shell-friendly** - Easy access to `|`, `\`, `` ` ``, `~`

---

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        LAYER STACK                          │
├─────────────────────────────────────────────────────────────┤
│  fn / fnvanilla    ← Fn key hold                            │
├─────────────────────────────────────────────────────────────┤
│  nums              ← Apostrophe (') hold                    │
├─────────────────────────────────────────────────────────────┤
│  sym               ← Space hold                             │
├─────────────────────────────────────────────────────────────┤
│  base / vanilla    ← Default (toggle via Fn+F1)             │
└─────────────────────────────────────────────────────────────┘
```

### Layer Activation

| Activator | Layer | Behavior |
|-----------|-------|----------|
| `Space` (hold) | `sym` | Symbols while held |
| `'` (hold) | `nums` | Numpad while held |
| `Fn` (hold) | `fn` | Function keys while held |
| `Fn + F1` | Toggle | Switch base ↔ vanilla |

### Timing Configuration

```lisp
(defvar
  tap-time 200    ;; Max ms for a tap
  hold-time 230   ;; Min ms to trigger hold
)
```

- **tap-time (200ms):** Maximum duration for a keypress to register as a tap
- **hold-time (230ms):** Minimum duration to activate hold behavior

### No Conflicts Between Layers

**Important:** The `'` (apostrophe) key has dual functionality without conflicts:

- Tap `'` outputs a single quote character
- Hold `'` activates the numbers layer
- These use kanata's tap-hold mechanism with configurable timing

---

## Layer Reference

### Base Layer

The default layer with home row modifiers active.

#### Home Row Modifiers

| Key | Tap | Hold |
|-----|-----|------|
| `A` | a | Left GUI (⌘) |
| `S` | s | Left Alt (⌥) |
| `D` | d | Left Shift (⇧) |
| `F` | f | Left Control (⌃) |
| `J` | j | Right Control (⌃) |
| `K` | k | Right Shift (⇧) |
| `L` | l | Right Alt (⌥) |
| `;` | ; | Right GUI (⌘) |

#### Special Keys

| Key | Tap | Hold |
|-----|-----|------|
| `Caps Lock` | Escape | Left Control |
| `Tab` | Tab | Hyper (⌘⌥⇧⌃) |
| `Space` | Space | Symbols Layer |
| `'` | ' (apostrophe) | Numbers Layer |
| `Right Shift` | Backspace | — |
| `Fn` | Fn | Function Layer |

---

### Symbols Layer (Space Hold)

Activated by holding the spacebar. Optimized for Python/Neovim/CLI with high-frequency symbols on home row.

#### Layout Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                    SYMBOLS LAYER (Space Hold)                   │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  LEFT HAND                         RIGHT HAND                   │
│                                                                 │
│  ┌─────┬─────┬─────┬─────┬─────┐  ┌─────┬─────┬─────┬─────┬─────┐│
│  │  !  │  @  │  #  │  $  │  %  │  │  ^  │  &  │  *  │  (  │  )  ││
│  │  q  │  w  │  e  │  r  │  t  │  │  y  │  u  │  i  │  o  │  p  ││
│  ├─────┼─────┼─────┼─────┼─────┤  ├─────┼─────┼─────┼─────┼─────┤│
│  │  {  │  }  │  [  │  ]  │  .  │  │  :  │  =  │  _  │  -  │  |  ││
│  │  a  │  s  │  d  │  f  │  g  │  │  h  │  j  │  k  │  l  │  ;  ││
│  ├─────┼─────┼─────┼─────┼─────┤  ├─────┼─────┼─────┼─────┼─────┤│
│  │  <  │  >  │  "  │  '  │  `  │  │  ~  │  \  │  +  │  ?  │     ││
│  │  z  │  x  │  c  │  v  │  b  │  │  n  │  m  │  ,  │  .  │  /  ││
│  └─────┴─────┴─────┴─────┴─────┘  └─────┴─────┴─────┴─────┴─────┘│
│                                                                 │
│  Top row = number row shift symbols    Home row = most common  │
└─────────────────────────────────────────────────────────────────┘
```

#### Symbol Mapping Reference

| Key | Symbol | Description | Python Use Case |
|-----|--------|-------------|-----------------|
| **Top Row (Number Row Symbols)** ||||
| `q` | `!` | Exclamation | Not operator, shell commands |
| `w` | `@` | At sign | Decorators, email addresses |
| `e` | `#` | Hash | Comments, dict keys |
| `r` | `$` | Dollar | Shell variables, regex |
| `t` | `%` | Percent | Modulo, string formatting |
| `y` | `^` | Caret | XOR, regex anchors |
| `u` | `&` | Ampersand | Bitwise AND, references |
| `i` | `*` | Asterisk | Multiplication, unpacking |
| `o` | `(` | Left paren | Function calls, tuples |
| `p` | `)` | Right paren | Function calls, tuples |
| **Home Row (High Frequency)** ||||
| `a` | `{` | Left brace | Dicts, sets, f-strings |
| `s` | `}` | Right brace | Dicts, sets, f-strings |
| `d` | `[` | Left bracket | Lists, indexing, slicing |
| `f` | `]` | Right bracket | Lists, indexing, slicing |
| `g` | `.` | Period | Method calls, attributes, imports |
| `h` | `:` | Colon | Slices, dicts, function defs, type hints |
| `j` | `=` | Equals | Assignment, comparisons |
| `k` | `_` | Underscore | Variable names (snake_case) |
| `l` | `-` | Minus | Subtraction, CLI flags, ranges |
| `;` | `\|` | Pipe | Shell pipes, union types |
| **Bottom Row (Paired Symbols)** ||||
| `z` | `<` | Less than | Comparisons, redirects |
| `x` | `>` | Greater than | Comparisons, redirects |
| `c` | `"` | Double quote | Strings (docstrings) |
| `v` | `'` | Single quote | Strings, char literals |
| `b` | `` ` `` | Backtick | Shell substitution, markdown |
| `n` | `~` | Tilde | Home directory, bitwise NOT |
| `m` | `\` | Backslash | Line continuation, escapes, paths |
| `,` | `+` | Plus | Addition, concatenation |
| `.` | `?` | Question | Ternary, regex quantifier |

---

### Numbers Layer (Apostrophe ' Hold)

Activated by holding the apostrophe key. Provides numpad-style number entry with 1-6 on qwerty top row. **Left hand is transparent** - passes through to base layer so letters and home row mods still work.

#### Layout Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                   NUMBERS LAYER (Apostrophe ' Hold)             │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  LEFT HAND (transparent)           RIGHT HAND (numpad)          │
│                                                                 │
│  ┌─────┬─────┬─────┬─────┬─────┐  ┌─────┬─────┬─────┬─────┬─────┐│
│  │  1  │  2  │  3  │  4  │  5  │  │  6  │  7  │  8  │  9  │  +  ││
│  │  q  │  w  │  e  │  r  │  t  │  │  y  │  u  │  i  │  o  │  p  ││
│  ├─────┼─────┼─────┼─────┼─────┤  ├─────┼─────┼─────┼─────┼─────┤│
│  │ (a) │ (s) │ (d) │ (f) │ (g) │  │  0  │  4  │  5  │  6  │  -  ││
│  │pass │thru │base │layer│     │  │  h  │  j  │  k  │  l  │  ;  ││
│  ├─────┼─────┼─────┼─────┼─────┤  ├─────┼─────┼─────┼─────┼─────┤│
│  │     │     │  .  │  +  │     │  │  ,  │  1  │  2  │  3  │  /  ││
│  │  z  │  x  │  c  │  v  │  b  │  │  n  │  m  │  ,  │  .  │  /  ││
│  └─────┴─────┴─────┴─────┴─────┘  └─────┴─────┴─────┴─────┴─────┘│
│                                                                 │
│  Top row: 1-6 on qwerty          Numpad: 0 on home row         │
└─────────────────────────────────────────────────────────────────┘
```

#### Number Mapping Reference

| Key | Output | Description |
|-----|--------|-------------|
| **Top Row (Quick Access 1-9)** |||
| `q` | `1` | One |
| `w` | `2` | Two |
| `e` | `3` | Three |
| `r` | `4` | Four |
| `t` | `5` | Five |
| `y` | `6` | Six |
| `u` | `7` | Seven |
| `i` | `8` | Eight |
| `o` | `9` | Nine |
| `p` | `+` | Plus |
| **Home Row (Numpad Center)** |||
| `h` | `0` | Zero (most common digit, home row) |
| `j` | `4` | Four |
| `k` | `5` | Five |
| `l` | `6` | Six |
| `;` | `-` | Minus |
| **Bottom Row (Low Numbers)** |||
| `n` | `,` | Comma (thousand separator) |
| `m` | `1` | One |
| `,` | `2` | Two |
| `.` | `3` | Three |
| `/` | `/` | Divide |
| **Left Hand Math Operators** |||
| `c` | `.` | Decimal point |
| `v` | `+` | Plus |

#### Left Hand Behavior

The left hand passes through to the base layer:
- **Letters work normally** - type `a`, `s`, `d`, `f`, `g`, etc.
- **Home row mods work** - hold `a` for Cmd, `s` for Alt, `d` for Shift, `f` for Ctrl
- **Math operators available** - `c=.`, `v=+` for one-handed calculations

---

### Function Layer (Fn Hold)

Activated by holding the Fn key.

#### Features

- **F1-F12** function keys on number row
- **Fn + F1** toggles between base and vanilla layers
- Media keys preserved on top row

---

### Vanilla Layer (No Home Row Mods)

A "stock" layer without home row modifiers for:
- Gaming
- Situations where HRM causes issues
- Handing keyboard to others

**Toggle:** `Fn + F1`

---

## Visual Layer Maps

### Base Layer (QWERTY Reference)

```
┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
│ F1  │ F2  │ F3  │ F4  │ F5  │ F6  │ F7  │ F8  │ F9  │ F10 │ F11 │ F12 │
│BrDn │BrUp │     │     │     │     │Prev │Play │Next │Mute │VolD│VolU │
├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
│  `  │  1  │  2  │  3  │  4  │  5  │  6  │  7  │  8  │  9  │  0  │ ... │
├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
│ TAB │  Q  │  W  │  E  │  R  │  T  │  Y  │  U  │  I  │  O  │  P  │ ... │
│Hyper│     │     │     │     │     │     │     │     │     │     │     │
├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
│CAPS │  A  │  S  │  D  │  F  │  G  │  H  │  J  │  K  │  L  │  ;  │  '  │
│Esc/ │ ⌘   │ ⌥   │ ⇧   │ ⌃   │     │     │ ⌃   │ ⇧   │ ⌥   │ ⌘   │ Nums│
│Ctrl │     │     │     │     │     │     │     │     │     │     │     │
├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
│Shift│  Z  │  X  │  C  │  V  │  B  │  N  │  M  │  ,  │  .  │  /  │Bksp │
├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
│ Fn  │Ctrl │ Alt │ Cmd │█████ SPACE █████│ Cmd │ Alt │     │     │     │
│Layer│     │     │     │█████ Sym   █████│     │     │     │     │     │
└─────┴─────┴─────┴─────┴─────────────────┴─────┴─────┴─────┴─────┴─────┘
```

---

## Quick Reference Card

Print this out and keep it by your keyboard until you've memorized the layers.

### Symbols (Space + Key)

```
┌──────────────────────────────────────────────┐
│              LEFT HAND                       │
├───────┬───────┬───────┬───────┬───────┬──────┤
│ q = ! │ w = @ │ e = # │ r = $ │ t = % │      │
├───────┼───────┼───────┼───────┼───────┼──────┤
│ a = { │ s = } │ d = [ │ f = ] │ g = . │      │  ← HOME ROW
├───────┼───────┼───────┼───────┼───────┼──────┤
│ z = < │ x = > │ c = " │ v = ' │ b = ` │      │
└───────┴───────┴───────┴───────┴───────┴──────┘

┌──────────────────────────────────────────────┐
│              RIGHT HAND                      │
├───────┬───────┬───────┬───────┬───────┬──────┤
│ y = ^ │ u = & │ i = * │ o = ( │ p = ) │      │
├───────┼───────┼───────┼───────┼───────┼──────┤
│ h = : │ j = = │ k = _ │ l = - │ ; = | │      │  ← HOME ROW
├───────┼───────┼───────┼───────┼───────┼──────┤
│ n = ~ │ m = \ │ , = + │ . = ? │       │      │
└───────┴───────┴───────┴───────┴───────┴──────┘
```

### Numbers (Apostrophe ' + Key)

```
┌──────────────────────────────────────────────┐
│      LEFT HAND (transparent)                 │
├───────┬───────┬───────┬───────┬───────┬──────┤
│ q = 1 │ w = 2 │ e = 3 │ r = 4 │ t = 5 │      │
├───────┼───────┼───────┼───────┼───────┼──────┤
│  (a)  │  (s)  │  (d)  │  (f)  │  (g)  │      │  ← PASS THROUGH
├───────┼───────┼───────┼───────┼───────┼──────┤
│       │       │ c = . │ v = + │       │      │
└───────┴───────┴───────┴───────┴───────┴──────┘

┌──────────────────────────────────────────────┐
│              RIGHT HAND                      │
├───────┬───────┬───────┬───────┬───────┬──────┤
│ y = 6 │ u = 7 │ i = 8 │ o = 9 │ p = + │      │
├───────┼───────┼───────┼───────┼───────┼──────┤
│ h = 0 │ j = 4 │ k = 5 │ l = 6 │ ; = - │      │  ← NUMPAD
├───────┼───────┼───────┼───────┼───────┼──────┤
│ n = , │ m = 1 │ , = 2 │ . = 3 │ / = / │      │
└───────┴───────┴───────┴───────┴───────┴──────┘
```

### Special Keys

| Key Combo | Result |
|-----------|--------|
| `Caps` tap | Escape |
| `Caps` hold | Control |
| `Tab` hold | Hyper (⌘⌥⇧⌃) |
| `Right Shift` | Backspace |
| `Fn + F1` | Toggle HRM on/off |

---

## Installation

### Prerequisites

1. **Install kanata** (via Homebrew):
   ```bash
   brew install kanata
   ```

2. **Grant permissions** (macOS):
   - System Preferences → Privacy & Security → Input Monitoring
   - Add kanata (or Terminal if running from there)
   - System Preferences → Privacy & Security → Accessibility
   - Add kanata

### Configuration File

1. Save the configuration to `~/.config/kanata/kanata.kbd`

2. Create the directory if needed:
   ```bash
   mkdir -p ~/.config/kanata
   ```

### Running Kanata

#### Manual Start
```bash
sudo kanata -c ~/.config/kanata/kanata.kbd
```

#### LaunchAgent (Auto-start)

Create `~/Library/LaunchAgents/com.kanata.plist`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.kanata</string>
    <key>ProgramArguments</key>
    <array>
        <string>/opt/homebrew/bin/kanata</string>
        <string>-c</string>
        <string>/Users/YOUR_USERNAME/.config/kanata/kanata.kbd</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
</dict>
</plist>
```

Load with:
```bash
launchctl load ~/Library/LaunchAgents/com.kanata.plist
```

---

## Usage Guide

### Learning Path

#### Week 1: Core Movements
1. Practice `Space + a/s` for `{}` - dicts
2. Practice `Space + d/f` for `[]` - lists
3. Practice `Space + o/p` for `()` - function calls

#### Week 2: Operators
1. Add `Space + j` for `=` - assignment
2. Add `Space + l` for `-` and `Space + g` for `.`
3. Practice `Space + k` for `_` - variable names

#### Week 3: Shell Symbols
1. `Space + ;` for `|` - pipes
2. `Space + h` for `:` - function defs
3. `Space + m` for `\` - line continuation

#### Week 4: Numbers
1. Practice qwerty numbers with `'` hold: `'q`=1, `'w`=2, etc.
2. Focus on numpad home row: `0` on `h`, `456` on `jkl`
3. Add math operators: `.` on `c`, `+` on `v`

### Common Patterns

#### Python Function Definition
```python
def my_function():
```
Keystrokes: `d-e-f Space Space+k m-y Space+k f-u-n-c-t-i-o-n Space+o Space+p Space+h`

#### Dictionary Literal
```python
{"key": "value"}
```
Keystrokes: `Space+a Space+c k-e-y Space+c Space+h Space Space+c v-a-l-u-e Space+c Space+s`

#### List Comprehension
```python
[x for x in items]
```
Keystrokes: `Space+d x Space f-o-r Space x Space i-n Space i-t-e-m-s Space+f`

#### Shell Pipeline
```bash
cat file | grep pattern
```
Keystrokes: `c-a-t Space f-i-l-e Space Space+; Space g-r-e-p Space p-a-t-t-e-r-n`

#### F-string
```python
f"{variable}"
```
Keystrokes: `f Space+c Space+a v-a-r-i-a-b-l-e Space+s Space+c`

### Tips

1. **Don't fight muscle memory** - Use number row normally at first, gradually shift to layers
2. **Practice in isolation** - Use typing practice sites with symbols
3. **Keep a cheat sheet** - Print the quick reference until memorized
4. **Toggle vanilla for gaming** - `Fn + F1` disables HRM

---

## Customization

### Adjusting Timing

If experiencing misfires, adjust in `defvar`:

```lisp
(defvar
  tap-time 200    ;; Increase if taps register as holds
  hold-time 230   ;; Increase if holds register as taps
)
```

**Recommended ranges:**
- `tap-time`: 150-250ms
- `hold-time`: 200-300ms
- Keep `hold-time` > `tap-time`

### Adding New Keyboards

Add to `macos-dev-names-include`:

```lisp
(defcfg
  macos-dev-names-include (
    "Apple Internal Keyboard / Trackpad"
    "MX MCHNCL M"
    "Your New Keyboard Name"
  )
)
```

Find keyboard names with:
```bash
kanata --list
```

### Adding Combos

For instant symbol access without layers:

```lisp
(defcfg
  process-unmapped-keys yes
  concurrent-tap-hold yes
  chords-v2-min-idle 50
)

(defchords base 50
  (d f) (macro S-9 S-0 left)    ;; d+f = () with cursor inside
  (j k) S-\                      ;; j+k = |
  (c v) (macro [ ] left)         ;; c+v = [] with cursor inside
)
```

### Changing Symbol Positions

Edit `deflayer sym`. Key codes reference:

| Code | Symbol |
|------|--------|
| `S-1` | ! |
| `S-2` | @ |
| `S-3` | # |
| `S-4` | $ |
| `S-5` | % |
| `S-6` | ^ |
| `S-7` | & |
| `S-8` | * |
| `S-9` | ( |
| `S-0` | ) |
| `S-[` | { |
| `S-]` | } |
| `S-\` | \| |
| `S-;` | : |
| `S-'` | " |
| `S--` | _ |
| `S-=` | + |
| `S-grv` | ~ |
| `grv` | ` |

---

## Troubleshooting

### Common Issues

#### Keys not responding
1. Check kanata is running: `ps aux | grep kanata`
2. Verify permissions in System Preferences
3. Check config syntax: `kanata -c ~/.config/kanata/kanata.kbd --check`

#### Home row mods misfiring
1. Increase `tap-time` and `hold-time`
2. Practice deliberate taps vs holds
3. Consider `tap-hold-release` instead of `tap-hold`

#### Wrong keyboard detected
1. Run `kanata --list` to see device names
2. Update `macos-dev-names-include` with exact names

#### Symbols not working
1. Verify US keyboard layout in macOS
2. Check layer is activating (try simple test like `Space + j` for `=`)

### Debug Mode

Run with verbose logging:
```bash
sudo kanata -c ~/.config/kanata/kanata.kbd --debug
```

### Reset to Vanilla

If stuck, press `Fn + F1` to toggle to vanilla layer (no HRM).

---

## Design Rationale

### Why These Symbol Positions?

**Brackets on home row:**
- `()` are the most frequent brackets in Python
- Index fingers are strongest and most accurate
- `{}` and `[]` follow in frequency

**`\ |` on top row:**
- Not available without reaching on standard keyboard
- Essential for shell/Python
- Top row is easy reach from home position

**Numbers as numpad:**
- Calculator-style layout is familiar
- `0` on home row (Benford's law - most common digit)
- Math operators on left hand for one-handed calculation

### Why Transparent Left Hand on Numbers Layer?

1. **Simplicity** - No need to remember what left hand does
2. **Flexibility** - Can still type letters while entering numbers
3. **Mods available** - Home row mods pass through for shortcuts
4. **Less cognitive load** - Only focus on right hand for numbers

### Why Two Separate Layers?

1. **Cognitive separation** - Symbols vs numbers are different mental modes
2. **Optimization** - Each layer can be tuned for its purpose
3. **No conflicts** - Physical Right Cmd triggers numbers, `;` hold gives modifier

### Why Home Row Mods?

- Eliminates pinky strain from corner modifiers
- Keeps hands centered on keyboard
- Enables complex shortcuts without contortion

### References

- [Pascal Getreuer - Designing a Symbol Layer](https://getreuer.info/posts/keyboards/symbol-layer/)
- [Miryoku Layout](https://github.com/manna-harbour/miryoku)
- [Kanata Documentation](https://github.com/jtroo/kanata)

---

## Full Configuration File

The complete kanata configuration is provided separately as `kanata.kbd`.

See the companion file for the full implementation of all layers and aliases described in this documentation.

---

## Changelog

### v1.1 (December 2024)
- Simplified numbers layer: left hand is now transparent
- Removed redundant modifiers from numbers layer
- Added clarification about home row mod / layer conflict

### v1.0 (December 2024)
- Initial configuration
- Base layer with home row mods
- Symbol layer (Space hold)
- Numbers layer (Right Cmd hold)
- Function layer
- Vanilla toggle layer
