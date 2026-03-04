# Necrogoru Dotfiles

Personal configuration files for macOS development environment.

## Overview

This repository contains dotfiles and configuration for:

- **Neovim** - Modern text editor configuration with LSP, plugins, and custom themes
- **SketchyBar** - macOS status bar customization
- **skhd** - Simple hotkey daemon for keyboard shortcuts
- **yabai** - Tiling window manager for macOS

## Installation

Using GNU Stow:

```bash
cd ~/dotfiles
stow .
```

## Components

### Neovim

Highly customized Neovim setup with LazyVim and extensive plugin configuration.

**Features:**
- LSP configuration with Mason
- Code completion with nvim-cmp and Copilot
- Git integration (Gitsigns)
- File explorer (nvim-tree)
- Fuzzy finder (Telescope)
- Syntax highlighting (Treesitter)
- Multiple themes available
- Custom snippets for various languages (CSS, Dart, JavaScript, TypeScript, Vue, PostCSS)

**Key Plugins:**
- copilot.lua, copilot-chat.lua
- codecompanion
- flash, multicursor
- noice, lualine, bufferline
- render-markdown
- trouble, tiny-inline-diagnostic
- vim-illuminate, which-key

**Themes:**
- Shades of Purple (custom)
- Bamboo, Catppuccin, Dracula, Everforest
- Kanagawa, Material, Monokai Pro
- Rose Pine, Tokyo Night, and more

**Terminal:**
I usually runs Neovim inside of Neovide for motions and GUI enhancements.

### SketchyBar

Custom macOS status bar with modules for:
- Battery status
- CPU usage
- Network status
- Clock & calendar
- Volume control
- Spotify integration
- Front app display
- Workspace spaces

### skhd

Keyboard shortcut daemon for window management and application control.

### yabai

Tiling window manager configuration for efficient workspace organization on macOS.

## File Structure

```
.config/
├── nvim/           # Neovim configuration
│   ├── init.lua
│   ├── lua/
│   │   ├── config/
│   │   ├── plugins/
│   │   ├── themes/
│   │   └── custom/
│   └── colors/
├── sketchybar/     # Status bar config
│   ├── sketchybarrc
│   ├── items/
│   └── plugins/
├── skhd/           # Hotkey daemon
│   └── skhdrc
└── yabai/          # Window manager
    └── yabairc
```

## Requirements

- macOS
- Neovim >= 0.9
- GNU Stow
- Nerd Font (for icons)
- yabai
- skhd
- sketchybar
