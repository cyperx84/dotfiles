---
id: Dotfiles-README
tags: []
---

# 🏡 cyperx's Dotfiles

```
          ▄████▄  ▓██   ██▓ ██▓███  ▓█████  ██▀███  ▒██   ██▒
         ▒██▀ ▀█   ▒██  ██▒▓██░  ██▒▓█   ▀ ▓██ ▒ ██▒▒▒ █ █ ▒░
         ▒▓█    ▄   ▒██ ██░▓██░ ██▓▒▒███   ▓██ ░▄█ ▒░░  █   ░
         ▒▓▓▄ ▄██▒  ░ ▐██▓░▒██▄█▓▒ ▒▒▓█  ▄ ▒██▀▀█▄   ░ █ █ ▒ 
         ▒ ▓███▀ ░  ░ ██▒▓░▒██▒ ░  ░░▒████▒░██▓ ▒██▒▒██▒ ▒██▒
         ░ ░▒ ▒  ░   ██▒▒▒ ▒▓▒░ ░  ░░░ ▒░ ░░ ▒▓ ░▒▓░▒▒ ░ ░▓ ░
           ░  ▒    ▓██ ░▒░ ░▒ ░      ░ ░  ░  ░▒ ░ ▒░░░   ░▒ ░
         ░         ▒ ▒ ░░  ░░          ░     ░░   ░  ░    ░  
         ░ ░       ░ ░                 ░  ░   ░      ░    ░  
         ░         ░ ░                                       
```

A curated collection of configuration files for a complete macOS development environment. This setup creates a beautiful, efficient, and highly customized workflow centered around tiling window management, terminal productivity, and modern development tools.

## 🌟 Features

- **🪟 Tiling Window Management**: Yabai + SKHD for seamless window control
- **🎨 Beautiful Terminal**: Ghostty with custom shaders and Starship prompt
- **⌨️ Advanced Key Remapping**: Karabiner-Elements for ergonomic keyboard improvements
- **📊 System Monitoring**: SketchyBar for elegant macOS menu bar replacement
- **🚀 Terminal Multiplexing**: Tmux with Catppuccin theme and advanced plugins
- **⚡ Modern Shell**: Zsh with FZF, syntax highlighting, and intelligent completions
- **🛠️ Development Ready**: Neovim with extensive plugin ecosystem

## 📂 Project Structure

```
dotfiles/
├── ghostty/          # Modern terminal emulator configuration
├── karabiner/        # Keyboard remapping and shortcuts
├── nvim/            # Neovim editor configuration  
├── sketchybar/      # macOS menu bar replacement
├── skhd/            # Hotkey daemon for window management
├── starship/        # Cross-shell prompt themes
├── tmux/            # Terminal multiplexer configuration
├── yabai/           # Tiling window manager
└── zsh/             # Z shell configuration and plugins
```

## 🛠️ Components Overview

### 👻 **Ghostty** - A Modern, GPU-Accelerated Terminal Emulator

Ghostty is a cutting-edge terminal emulator for macOS, designed for speed, efficiency, and extensive visual customization. It leverages the GPU for rendering, ensuring smooth performance and responsiveness, even with complex visual effects.

- **Core Purpose**: Provides a fast, reliable, and highly customizable command-line interface experience.
- **Font**: Utilizes the MonaspiceNe Nerd Font family, offering excellent readability and a wide range of ligatures and stylistic sets. (Configurable with `font-family`, `font-size`, and `font-feature` settings).
- **Theme**: Comes themed with "Monokai Remastered" and supports transparency and blur effects for seamless desktop integration. (Theme is set by `theme = Monokai Remastered`).
- **Visual Customization**: Offers an extensive collection of over 30 custom GLSL shaders, allowing for unique visual effects like "Matrix," "CRT," "Starfield," and more. (Shaders can be enabled via `custom-shader` lines in the config).
- **Global Quick Access**: Features a convenient global quick terminal toggle using `cmd+/` for instant access. (Configured with `keybind = global:cmd+/=toggle_quick_terminal`).

**Key Standout Features:**

- **GPU Acceleration**: Delivers exceptional performance and fluid visuals by utilizing the graphics processor.
- **Extensive Shader Support**: Transform your terminal's appearance with a diverse library of GLSL shaders, offering dynamic backgrounds and visual effects.
- **Advanced Font Control**: Fine-grained control over font families (including bold/italic variants), size, and OpenType features like ligatures (`liga`) and stylistic sets (`ss01`, `ss02`, etc.).
- **macOS Native**: Optimized for macOS, including features like `macos-option-as-alt` for keyboard compatibility and configurable secure input handling (`macos-auto-secure-input`, `keybind = "cmd+shift+s=toggle_secure_input"`).
- **Customizable Cursor**: Offers various cursor styles (`cursor-style`) and blink options (`cursor-style-blink`).
- **Window & Mouse Behavior**: Supports hiding the mouse while typing (`mouse-hide-while-typing`) and borderless window decorations (`window-decoration = false`).

### ⛓️‍💥 **Karabiner-Elements** - Advanced Keyboard Customization

Karabiner-Elements is a powerful and flexible keyboard customizer for macOS. It allows users to extensively remap keys and create complex modification rules to tailor keyboard behavior to their specific needs, significantly enhancing ergonomic efficiency and productivity.

- **Core Purpose**: To provide in-depth control over keyboard input, enabling users to remap keys, modify event behaviors, and create personalized keyboard layouts and functionalities.
- **Simple Modifications**: Easily remap standard keys. For example, this configuration maps:
    - `Caps Lock` to `Left Control` (beneficial for Vim users and others who frequently use Control).
    - `Right Command` to `Backspace` for easier one-handed deletions.
    - `Right Shift` to `Backspace` as an alternative deletion key.
    (These are configured in `karabiner.json` under `simple_modifications`).
- **Function Key Customization**: Standard function keys (F1-F12) can be remapped to standard function keys, media controls (e.g., `Play/Pause`, `Mute`), or system functions like Spotlight. (Examples found in `karabiner.json` under `fn_function_keys`).

**Key Standout Features:**

- **Complex Modification Rules**: Go beyond simple remapping. Karabiner-Elements allows the creation of intricate rules that can change key behavior based on active applications, input devices, or even variable states that you can define. While not explicitly detailed in the current `karabiner.json`, the tool supports this.
- **Device-Specific Settings**: Apply different configurations for different keyboards. The `karabiner.json` shows device identifiers, hinting at this capability (`profiles[0].devices`).
- **Profiles**: Create and switch between multiple profiles, each with its own set of modifications. This is useful for different tasks or when using different physical keyboards. (The `karabiner.json` is structured around a "Default profile").
- **Virtual HID Keyboard Configuration**: Fine-tune aspects like `country_code` and `keyboard_type_v2` as seen in the `karabiner.json`.
- **Extensibility**: While the provided `karabiner.json` showcases basic mappings, Karabiner-Elements can be configured to:
    - Trigger shell commands with key presses.
    - Create custom macros for sequences of actions.
    - Implement hyper keys (a single key that acts as multiple modifiers).
    - Use conditions to change key behavior dynamically.

### 🎛️ **SKHD** - Global Hotkey Daemon for macOS

SKHD (Simple Key Hotkey Daemon) is a lightweight and highly versatile utility that allows you to define and manage global keyboard shortcuts for macOS. It's particularly popular for use with tiling window managers like Yabai, but its capabilities extend to controlling virtually any aspect of your macOS environment.

- **Core Purpose**: To provide a system-wide hotkey service, enabling users to bind custom keyboard shortcuts to execute shell commands, control applications, manage windows, and automate various tasks. All configurations are managed in the `skhdrc` file (located at `skhd/.config/skhd/skhdrc`).

**Key Standout Features:**

- **Simple & Flexible Configuration**: SKHD uses a straightforward configuration language (detailed in the header of `skhdrc`). This makes it easy to define hotkeys, from simple single-key presses to more complex combinations involving multiple modifiers.
- **Shell Command Execution**: The most powerful feature of SKHD is its ability to bind any key combination to any shell command. This means you can script interactions with Yabai, launch applications, control system settings, run custom scripts, and much more.
    - *Example from `skhdrc`*: `ctrl + cmd - r : yabai -m space --balance` binds `Ctrl+Cmd+R` to a Yabai command for balancing window sizes.
- **Modal Keybindings (Chords)**: SKHD supports modal keybindings, allowing you to define different sets of hotkeys that become active only after a specific "entry" key or sequence is pressed. This enables layered configurations, like Vim's modes, for a vastly expanded number of possible shortcuts without conflicts. (While not explicitly used for complex modes in this config, the `skhdrc` grammar section explains how to declare modes: `:: <name> : <command>`).
- **Lightweight & Efficient**: SKHD is designed to be unobtrusive and consume minimal system resources, running efficiently in the background.
- **Direct Window Manager Integration**: As seen in this configuration, SKHD is ideal for controlling tiling window managers.

**Common Use Cases & Examples (from this configuration):**

SKHD is used here primarily to interface with Yabai for window and workspace management:

**Window Management:**
- `ctrl+cmd+w`: Toggle fullscreen (`yabai -m window --toggle zoom-fullscreen`)
- `ctrl+cmd+q`: Float/unfloat window and center it (`yabai -m window --toggle float; yabai -m window --grid 4:4:1:1:2:2`)
- `shift+ctrl+alt+[h/j/k/l]`: Move (warp) focused window (`yabai -m window --warp [direction]`)
- `ctrl+alt+cmd+[h/j/k/l]`: Resize focused window (`yabai -m window --resize [edge]:[delta]:[delta]`)

**Workspace (Space) Navigation:**
- `ctrl+[1-5]`: Switch to a specific desktop/space (`yabai -m space --focus [index]`)
- `shift+alt+[1-7]`: Move focused window to a specific desktop/space (`yabai -m window --space [index]`)
- `shift+alt+p/n`: Move focused window to the previous/next space (`yabai -m window --space [prev/next]`)

**Service Management:**
- `shift + alt + cmd - r`: Restart SKHD and Yabai services (`skhd --restart-service && yabai --restart-service`)

### 🦞 **Yabai** - Tiling Window Manager for macOS

Yabai is a highly configurable tiling window manager for macOS that brings the efficiency and organization of tiled window layouts to the Mac environment. Instead of windows floating freely and often overlapping, Yabai automatically arranges them into a grid of non-overlapping tiles, maximizing screen real estate and streamlining window navigation. All its settings are managed through the `yabairc` file (located at `yabai/.config/yabai/yabairc`).

- **Core Purpose**: To provide a more structured and keyboard-driven approach to window management on macOS, enhancing productivity by automatically organizing windows and integrating deeply with native macOS features like Spaces.

**Key Standout Features & Configuration (`yabairc` examples):**

- **Layout Modes**:
    - **BSP (Binary Space Partitioning)**: The default in this configuration (`yabai -m config layout bsp`). Windows are arranged in a binary tree structure, splitting existing tiles to accommodate new windows.
    - **Float**: Individual windows can be set to float above the tiled layout, useful for dialogs or specific applications.
    - **Stacking**: Yabai also supports stacking layouts (though not explicitly the default here), where windows are layered on top of each other within a tile.
- **Advanced Space Management**: Yabai works seamlessly with macOS's native Spaces, allowing for per-space layout configurations and easy navigation between them.
- **Granular Window Control**: Offers precise control over window focus, movement, swapping, and resizing, typically managed via a hotkey daemon like SKHD.
    - **Window Placement**: New windows can be configured to appear as the `second_child` in a split, influencing where they are placed relative to the focused window (`yabai -m config window_placement second_child`).
- **Powerful Rule System**: Define custom behaviors for specific applications or windows.
    - *Example from `yabairc`*: Exclude certain applications from being managed by Yabai (e.g., `yabai -m rule --add app="^System Settings$" manage=off`, `yabai -m rule --add app="^Calculator$" manage=off`, `yabai -m rule --add app="^Karabiner-Elements$" manage=off`).
- **Signal System for Scripting & Integration**: Yabai emits signals for various events (e.g., window creation, focus change), enabling powerful scripting and integration with other tools. This is crucial for its synergy with:
    - **SKHD**: For binding Yabai commands to hotkeys.
    - **SketchyBar**: For displaying Yabai space information, window titles, etc. This configuration specifies an external bar setup: `yabai -m config external_bar all:30:0`.
- **Visual Customization**:
    - **Padding & Gaps**: Configure padding around the screen edges and gaps between windows for aesthetics and clarity.
        - *`yabairc` settings*: `top_padding 2`, `bottom_padding 2`, `left_padding 2`, `right_padding 2`, `window_gap 2`. This shows a minimal 2px padding/gap.
    - **Split Ratios**: Control how windows are split when new windows are created or existing ones are resized.
- **Mouse Integration**: While primarily keyboard-driven, Yabai offers mouse support:
    - **Mouse Follows Focus**: Can be enabled/disabled (`yabai -m config mouse_follows_focus off` in this config).
    - **Click-and-Drag Actions**: Configure mouse buttons with modifiers to move (`yabai -m config mouse_action1 move`) or resize (`yabai -m config mouse_action2 resize`) windows.
    - **Drop Actions**: Define what happens when a window is dragged and dropped onto another (e.g., `yabai -m mouse_drop_action swap`).

### 📊 **SketchyBar** - Highly Customizable macOS Status Bar Replacement

SketchyBar is a remarkably flexible and extensively customizable status bar replacement for macOS. It empowers users to move beyond the standard menu bar and create a personalized information and control center, tailored precisely to their workflow and aesthetic preferences. All configurations are managed within the `sketchybar/.config/sketchybar/` directory, with the main settings in `sketchybarrc` and individual components often defined in the `items/` and `plugins/` subdirectories.

- **Core Purpose**: To offer a dynamic, scriptable, and visually rich alternative to the native macOS menu bar, allowing for the display of system information, application statuses, custom widgets, and interactive controls.

**Key Standout Features & Configuration (`sketchybarrc` and directory structure examples):**

- **Extensive Scriptability**: This is SketchyBar's cornerstone. Most items and their updates are driven by shell scripts (or any executable). This provides immense flexibility to display virtually any information or react to any system state.
    - *Examples*: The `plugins/` directory is filled with scripts like `battery.sh`, `volume.sh`, `wifi.sh`, and `yabai.sh`, which fetch data and update the corresponding bar items. The `sketchybarrc` file itself is a shell script that sources these components.
- **Modular Design**: The bar is constructed from individual "items" (e.g., text elements, icons, interactive buttons, graphs). Each item can be independently configured, positioned, and updated.
    - *Configuration*: The `items/` directory contains scripts like `spaces.sh`, `front_app.sh`, `calendar.sh`, and `cpu.sh`, each defining a distinct module on the bar. These are sourced by `sketchybarrc`.
- **Event-Driven Architecture**: Items can subscribe to system events or custom notifications, allowing them to update dynamically.
    - *Examples*: Wi-Fi status changes, Yabai space switches (handled by `plugins/yabai.sh` and `items/yabai.sh`), music player status (e.g., `items/media.sh`, `items/spotify.sh`), or even custom events triggered by other scripts.
- **Rich Customization**: SketchyBar offers deep control over nearly every visual aspect:
    - **Appearance**: The main `sketchybarrc` defines global bar settings like `height` (36px in this config), `color` (`$BAR_COLOR`), `position` (top), `padding`, `blur_radius` for popups, and `shadows`.
    - **Fonts & Colors**: Global and per-item font settings (e.g., `FONT="MonaspiceRn Nerd Font Mono"` from `sketchybarrc`) and colors (defined in `colors.sh` and applied in `sketchybarrc` and item scripts).
    - **Icons**: Extensive use of icons (defined in `icons.sh` and used in item scripts like `apple.sh`, `mic.sh`).
    - **Backgrounds & Borders**: Customizable backgrounds, corner radii, and borders for items and popups (see `defaults` in `sketchybarrc`).
    - **Positioning & Spacing**: Control over item placement (left, center, right sections) and padding between elements.
    - **Animations**: SketchyBar supports animations for smoother transitions and visual feedback (though not explicitly detailed in `sketchybarrc`, it's a feature of the tool).
- **Interactive Components**: Items can be made clickable to trigger scripts, open applications, or execute any command.
    - *Examples*: The `apple.sh` item likely has click actions for system functions. Volume items (`volume.sh`) often allow clicking to mute or right-clicking to change audio sources (as hinted in `sketchybarrc` comments). The `calendar.sh` item is noted to run `zen.sh` on click.
- **Integration with Other Tools**:
    - **Yabai**: Seamlessly displays Yabai space indicators, often with click-to-focus functionality, via scripts in `items/yabai.sh` and `plugins/space.sh`. Yabai events trigger updates. The `sketchybarrc` explicitly sources `items/spaces.sh`.
    - **SKHD**: Used in conjunction to trigger SketchyBar updates or actions via command-line calls.

**Current Configuration Highlights:**

- **Arrangement**: Items are organized into left, center, and right sections of the bar.
- **Key Modules Displayed**:
    - *Left*: Apple logo (with actions), Yabai spaces, front application name/icon, microphone status.
    - *Center*: (Media/Spotify items are present but noted as potentially disabled or for specific conditions).
    - *Right*: Calendar/clock, Homebrew update status, Wi-Fi info, battery level, volume control, CPU usage, custom timer.
- **Styling**: Uses "MonaspiceRn Nerd Font," custom colors from `colors.sh`, and defined padding/icon settings for a cohesive look. It also features blur effects for popups.

### 🪟 **Tmux** - Advanced Terminal Multiplexer

Tmux (Terminal Multiplexer) is an indispensable tool that revolutionizes how you work with the command line. It enables users to manage multiple independent terminal sessions, windows (full-screen terminal instances), and panes (splits within a window) all from within a single terminal window or console. Crucially, Tmux allows these sessions to persist even after the main terminal window is closed or the user disconnects, meaning you can detach and reattach to your work environments at any time, picking up exactly where you left off. This configuration is managed in `~/.tmux.conf`.

- **Core Purpose**: To provide robust session management, allowing for persistent, organized, and efficient handling of multiple terminal-based tasks and workflows.

**Key Standout Features & Configuration (`.tmux.conf` examples):**

- **Persistent Session Management**:
    - **Detach & Reattach**: The hallmark of Tmux. Start a session, detach from it (leaving processes running), and reattach later from any terminal. This is invaluable for remote work or long-running tasks.
    - **Named Sessions**: Create and manage multiple named sessions for different projects or contexts.
- **Windows and Panes for Organization**:
    - **Windows**: Similar to tabs in a graphical terminal, allowing you to group related tasks. New windows conveniently open in the current path (`bind c new-window -c "#{pane_current_path}"`).
    - **Panes**: Split windows horizontally (`bind s split-window -c "#{pane_current_path}"`) or vertically (`bind v split-window -h -c "#{pane_current_path}"`) to view and work with multiple terminals side-by-side.
    - **Navigation**: This configuration uses Vim-style keys for pane navigation (`bind-key h select-pane -L`, `j` for down, `k` for up, `l` for right).
    - **Resizing**: Panes can be easily resized using `Ctrl+A` followed by `Ctrl + H/J/K/L`.
- **Extensive Customization & Scriptability**:
    - **Prefix Key**: The command prefix has been remapped from the default `Ctrl+B` to `Ctrl+A` for easier access (`unbind C-b; set-option -g prefix C-a`).
    - **Status Line**: Highly customizable. This setup uses `niksingh710/minimal-tmux-status` for a clean look, with configurable foreground/background colors, indicators, and arrow styles (e.g., `set -g @minimal-tmux-indicator-str " 󱓇TMUX󱓇 "`, `set -g @minimal-tmux-use-arrow true`). The old "Catppuccin Mocha" theme previously mentioned has been replaced by this more minimal theme.
    - **Key Bindings**: Beyond navigation, custom keybindings can be set for any Tmux command or shell script. The config includes a binding to quickly reload it: `bind r source-file ~/.tmux.conf \; display "🚀 Config reloaded."`.
    - **Appearance**: Fonts, colors, and terminal features (like `set -g default-terminal "xterm-ghostty"`, `set -ga terminal-features "xterm-ghostty:RGB"`) are configured for optimal visual integration.
    - **Indexing**: Windows and panes start at index 1 for more intuitive numbering (`set -g base-index 1; set -g pane-base-index 1`).
- **Powerful Plugin Ecosystem with TPM (Tmux Plugin Manager)**:
    - TPM (`tmux-plugins/tpm`) is used to manage plugins, which extend Tmux's functionality.
    - **Key Plugins in this Configuration**:
        - `tmux-plugins/tmux-yank`: For easy copying to the system clipboard.
        - `christoomey/vim-tmux-navigator`: Seamlessly navigate between Vim/Neovim splits and Tmux panes using the same directional keys. Custom mappings are set (e.g., `set -g @vim_navigator_mapping_left "C-Left C-h"`).
        - `tmux-plugins/tmux-resurrect`: Persists Tmux sessions across system reboots. Configured with `set -g @resurrect-strategy-nvim 'server'` for Neovim.
        - `sainnhe/tmux-fzf`: Integrates FZF for fuzzy finding sessions, windows, etc.
        - `wfxr/tmux-fzf-url`: Quickly open URLs from Tmux scrollback using FZF.
        - `joshmedeski/tmux-nerd-font-window-name`: Uses Nerd Fonts for window names.
        - `omerxx/tmux-floax`: Provides floating terminal window capabilities within Tmux, configurable for size and appearance (`set -g @floax-width '80%'`, `set -g @floax-border-color 'magenta'`). The trigger is `prefix + p`.
        - (The previously mentioned `tmux-sessionx` and `tmux-continuum` are not present in the current config, with `tmux-resurrect` handling persistence).

### 🚀 **Starship** - The Minimal, Blazing-Fast, Infinitely Customizable Cross-Shell Prompt

Starship is a cutting-edge prompt designed to provide a consistent, visually rich, and context-aware command-line experience across virtually any shell. It's engineered for speed and offers unparalleled customization, allowing you to tailor every aspect of your prompt to your exact needs. All configurations are managed through TOML files located in the `starship/.config/starship/` directory.

- **Core Purpose**: To deliver a minimal, blazing-fast, and infinitely customizable prompt that enhances productivity by displaying useful information dynamically, regardless of the shell being used.

**Key Standout Features & Configuration (`starship/*.toml` examples):**

- **Cross-Shell Compatibility**: Starship truly shines by providing a unified prompt experience whether you're using Bash, Zsh, Fish, PowerShell, Ion, Elvish, Tcsh, Nushell, or Cmder. Define your prompt once, and it works everywhere.
- **Context-Aware Modules**: The prompt intelligently displays relevant information based on your current context. This is achieved through a wide array of built-in modules:
    - **Version Control**: Comprehensive Git integration shows branch, status (ahead/behind, staged, modified, etc.), and even commit details if desired. (Configured via `[git_branch]` and `[git_status]` in `starship-gruvbox-dark-neon.toml`).
    - **Programming Environments**: Automatically detects and displays versions for numerous languages and tools like Node.js (`[nodejs]`), Python (`[python]`), Ruby, Go (`[golang]`), Rust (`[rust]`), C/C++ (`[c]`, `[cpp]`), Java (`[java]`), PHP (`[php]`), and many more. It also shows active virtual environments (e.g., Conda `[conda]`, Pixi `[pixi]`).
    - **Containerization & Cloud**: Displays Docker context (`[docker_context]`), Kubernetes context/namespace (`[kubernetes]`), and can show AWS (`[aws]`), Google Cloud (`[gcloud]`), and Azure (`[azure]`) information.
    - **System Info**: Shows current directory (`[directory]` with custom substitutions like `~` to `󱙝`), operating system (`[os]` with custom symbols per OS), hostname, command execution time (`[cmd_duration]`), and more.
- **Rich Customization via TOML**: Every aspect of the prompt is configurable through a single `starship.toml` file (or theme files like `starship-gruvbox-dark-neon.toml` which is the active theme).
    - **Modular Structure**: The prompt is built from "modules." Users can choose which modules to display, their order, and their conditions for appearing. The `format` string in the TOML file dictates the entire prompt layout.
        - *`starship-gruvbox-dark-neon.toml` example*: `format = """[](color_orange)$os[](bg:color_yellow fg:color_orange)$directory...$line_break$character"""` clearly defines a segmented, Powerline-style prompt.
    - **Visual Styling**: Customize symbols (many Nerd Font symbols are used in the active theme, e.g., `󰯈` for macOS, `` for Git branch), colors (using palettes like `gruvbox_dark_neon`), text formatting (bold, italic), and segment delimiters (e.g., ``, ``).
    - **Conditional Display**: Modules can be configured to only show when relevant (e.g., Git information only appears in a Git repository).
- **Performance**: Written in Rust, Starship is designed to be exceptionally fast and efficient, ensuring your prompt remains responsive and doesn't introduce lag, even with many modules enabled.
- **Extensibility & Presets**:
    - While Starship's strength lies in its extensive configuration options rather than a complex plugin API, its module system is quite comprehensive.
    - **Themes**: This dotfiles setup includes multiple pre-configured themes in `starship/.config/starship/` such as `starship-gruvbox-dark-neon.toml` (active), `starship-gruvbox-rainbow.toml`, `starship-jetpack.toml`, `starship-no-runtime.toml`, and `starship-tokyo-night.toml`, showcasing different visual styles and module arrangements. The `starship-theme.toml` file appears to be a more generic, feature-rich example.
- **Powerline-Inspired Style**: The active theme leverages Powerline-style segments with distinct background colors and special separator characters (``, ``) for a modern and visually appealing look.

### 🦪 **Zsh (Z Shell)** - The Extensible, Feature-Rich Command-Line Shell

Zsh is a powerful and highly extensible Unix shell, often favored over more traditional shells like Bash for its rich interactive features, advanced scripting capabilities, and extensive customization options. It provides a significant upgrade to the command-line experience, making it more efficient and user-friendly. This dotfiles setup leverages Zsh as the primary shell, configured through files in the `zsh/` directory, primarily `~/.zshrc` (for interactive sessions) and `~/.zprofile` (for login-time setup).

- **Core Purpose**: To offer a sophisticated and highly customizable command-line interface that enhances productivity through advanced features like intelligent tab completion, powerful globbing, a robust plugin architecture, and deep user-configurable settings.

**Key Standout Features & Configuration (examples from `zsh/.zshrc`):**

- **Advanced Tab Completion System**: Zsh's completion system is a significant step up from Bash. It's programmable and context-aware, offering suggestions for commands, options, arguments, and filenames.
    - This configuration supercharges it further with **`fzf-tab`** (sourced from `~/.zsh/fzf-tab/fzf-tab.plugin.zsh`), which integrates FZF directly into the tab completion menu, allowing for fuzzy searching of completion suggestions.
- **Plugin Architecture & Enhancements**: While not using a full framework like Oh My Zsh or Prezto in this setup, Zsh's functionality is extended by sourcing individual plugin-like scripts:
    - **`zsh-fast-syntax-highlighting`**: Provides real-time syntax highlighting for commands as you type, helping catch errors before execution. (Sourced from `$(brew --prefix zsh-fast-syntax-highlighting)/share/...`).
    - **`zsh-autosuggestions`**: Suggests commands as you type based on history and completions, with `ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8,bold'` for styling. (Sourced from `$(brew --prefix)/share/zsh-autosuggestions/...`).
- **Extensive Customization**: Zsh allows for deep customization of nearly every aspect of the shell environment:
    - **Prompt**: While Starship is used for the prompt itself (`eval "$(starship init zsh)"` in `.zshrc`), Zsh has its own powerful prompt customization capabilities.
    - **Key Bindings**: Custom keybindings are set, such as `bindkey jk vi-cmd-mode` for Vi-style command line editing and specific bindings for `zsh-autosuggestions` (`bindkey '^e' autosuggest-execute`).
    - **History**: Command history is configured with timestamps (`HIST_STAMPS="dd/mm/yy"`).
    - **Shell Options**: Various options like `unsetopt PROMPT_SP` and `ENABLE_CORRECTION="false"` fine-tune shell behavior.
- **FZF Integration**: Fuzzy Finger (FZF) is deeply integrated for enhanced navigation and command history searching.
    - *Configuration*: `FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'` sets `fd` as the default file finder. Custom preview options are defined for `Alt+C` and `Ctrl+T` bindings (`FZF_ALT_C_OPTS`, `FZF_CTRL_T_OPTS`).
    - *Custom Functions*: `fcd` (fuzzy change directory), `fv` (fuzzy open file in Neovim), and `f` (fuzzy find file and copy path) provide powerful FZF-based navigation workflows.
- **Aliases**: A comprehensive set of over 50 aliases streamlines common tasks for:
    - **Git**: `gc`, `gp`, `gs`, `glog`, `gdiff`, etc.
    - **Docker**: `dco`, `dps`, `dx`, etc.
    - **Kubernetes**: `k`, `ka`, `kg`, `kdel`, `kc`, `kns`, etc.
    - **Navigation & File Listing**: `..`, `...`, and `eza` aliases (`ls`, `lt`, `l`, `ll`).
- **Yazi File Manager Integration**: A custom function `y` seamlessly integrates the `yazi` terminal file manager, ensuring that Zsh changes to the directory Yazi was last in.
- **UV Python Environment Management**: Shell completions for `uv`, a fast Python package installer and resolver, are enabled (`eval "$(uv generate-shell-completion zsh)"`).
- **Zoxide Integration**: `zoxide`, a smarter `cd` command that learns your habits, is initialized (`eval "$(zoxide init zsh)"`).
- **Sketchybar Integration**: The `brew` command is wrapped in a custom Zsh function to trigger `sketchybar --trigger brew_update` after certain brew operations, keeping the status bar display in sync.
- **Environment Setup**: `.zprofile` handles architecture-specific Homebrew path setup and runs a custom Message of the Day script (`motd.sh`). `.zshrc` sets `TERM="xterm-ghostty"` and `COLORTERM="truecolor"` for optimal terminal emulator compatibility.
- **Powerful Globbing Qualifiers**: Zsh includes advanced file matching capabilities using glob operators (e.g., `**/*` for recursive matching, `*(.)` for regular files, `*(/)` for directories, and qualifiers like `[1,5]` for ranges). While not explicitly detailed as custom functions in the `.zshrc`, these are native Zsh features that enhance scripting and interactive file operations.
- **Shared Command History (Implicit)**: By default, Zsh configurations often enable options like `SHARE_HISTORY` or `INC_APPEND_HISTORY` to ensure command history is shared and appended across concurrent sessions, though these specific options are not explicitly set in the provided `.zshrc`. Standard history file usage still provides a good degree of shared history.
- **Spelling Correction**: Zsh has a built-in spelling correction feature for commands. It's not explicitly enabled with `setopt CORRECT` or `setopt CORRECT_ALL` in this `.zshrc`, but `ENABLE_CORRECTION="false"` is set, indicating awareness of the feature (and a choice to disable it).

This configuration demonstrates a Zsh environment that is heavily tailored for developer productivity, combining Zsh's native strengths with powerful external tools and custom scripting.

### 👾 **Neovim** - Text Editor
Comprehensive Neovim configuration based on kickstart.nvim:
- **Base**: Adapted from nvim-lua/kickstart.nvim
- **Plugins**: 30+ custom plugins for development
- **Features**: LSP, completion, debugging, AI assistance
- **Themes**: Multiple colorscheme options

## 🔧 Installation

### Prerequisites
Ensure you have the following installed:
```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install required tools
brew install --cask ghostty karabiner-elements
brew install yabai skhd sketchybar tmux starship zsh
```

### Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone https://github.com/cyperx/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Link configuration files:**
   ```bash
   # Ghostty
   ln -sf ~/dotfiles/ghostty/.config/ghostty ~/.config/

   # Karabiner
   ln -sf ~/dotfiles/karabiner/.config/karabiner ~/.config/

   # Neovim
   ln -sf ~/dotfiles/nvim/.config/nvim ~/.config/

   # SketchyBar
   ln -sf ~/dotfiles/sketchybar/.config/sketchybar ~/.config/

   # SKHD
   ln -sf ~/dotfiles/skhd/.config/skhd ~/.config/

   # Starship
   ln -sf ~/dotfiles/starship/.config/starship ~/.config/

   # Yabai
   ln -sf ~/dotfiles/yabai/.config/yabai ~/.config/

   # Tmux
   ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf

   # Zsh
   ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
   ln -sf ~/dotfiles/zsh/.zprofile ~/.zprofile
   ```

3. **Start services:**
   ```bash
   # Start yabai and skhd
   brew services start yabai
   brew services start skhd

   # Start SketchyBar
   brew services start sketchybar

   # Restart shell to load Zsh config
   exec zsh
   ```

4. **Configure permissions:**
   - Grant accessibility permissions to SKHD and Yabai in System Preferences
   - Allow Karabiner-Elements to modify keyboard input
   - Configure Ghostty as default terminal

## ⚙️ Customization

### Starship Themes
Switch between different prompt themes by modifying `~/.zshrc`:
```bash
export STARSHIP_CONFIG=~/.config/starship/starship-gruvbox-dark-neon.toml
# export STARSHIP_CONFIG=~/.config/starship/starship-gruvbox-rainbow.toml
# export STARSHIP_CONFIG=~/.config/starship/starship-jetpack.toml
```

### Ghostty Shaders
Enable visual effects by uncommenting shader lines in `ghostty/config`:
```bash
# Uncomment any of these for visual effects:
# custom-shader = shaders/matrix-hallway.glsl
# custom-shader = shaders/starfield.glsl
# custom-shader = shaders/crt.glsl
```

### Tmux Customization
Modify plugin settings in `.tmux.conf`:
```bash
# Float window settings
set -g @floax-width '80%'
set -g @floax-height '80%'
set -g @floax-bind 'p'
```

## 🎯 Key Bindings Reference

### Window Management (SKHD + Yabai)
| Binding | Action |
|---------|--------|
| `ctrl+cmd+w` | Toggle fullscreen |
| `ctrl+cmd+q` | Float/unfloat window |
| `ctrl+cmd+r` | Balance windows |
| `ctrl+cmd+e` | Toggle split type |
| `shift+ctrl+alt+hjkl` | Move windows |
| `ctrl+alt+cmd+hjkl` | Resize windows |

### Workspace Navigation
| Binding | Action |
|---------|--------|
| `ctrl+1-5` | Switch to desktop |
| `shift+alt+1-7` | Move window to desktop |
| `shift+alt+p/n` | Move to prev/next space |

### Tmux (Prefix: `Ctrl+A`)
| Binding | Action |
|---------|--------|
| `prefix+s` | Split horizontal |
| `prefix+v` | Split vertical |
| `prefix+hjkl` | Navigate panes |
| `prefix+o` | Session manager |
| `prefix+p` | Float terminal |

## 🔍 File Highlights

### Configuration Files
- `ghostty/config` - Terminal appearance and behavior
- `karabiner/karabiner.json` - Keyboard remapping rules
- `skhd/skhdrc` - Hotkey definitions
- `yabai/yabairc` - Window manager settings
- `tmux/.tmux.conf` - Terminal multiplexer setup
- `zsh/.zshrc` - Shell configuration and aliases

### Special Features
- **Ghostty Shaders**: 30+ visual effect shaders in `ghostty/shaders/`
- **SketchyBar Plugins**: Custom status bar modules in `sketchybar/plugins/`
- **Starship Themes**: 6 different prompt configurations
- **Tmux Plugins**: Auto-installing plugin manager with 10+ plugins

## 🤝 Contributing

Feel free to fork this repository and adapt it to your needs. If you have improvements or suggestions:

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) - Neovim configuration base
- [Catppuccin](https://github.com/catppuccin) - Beautiful color schemes
- The amazing macOS community for tool development

---

*This dotfiles setup represents years of refinement for optimal productivity and aesthetics on macOS.*
