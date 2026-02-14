# Number Slide Puzzle for Vim9

A classic 15-puzzle sliding tile game implemented as a Vim9 plugin, displayed in a popup window.

## Overview

The Number Slide Puzzle plugin provides an interactive sliding puzzle game directly in Vim. The puzzle appears in a centered popup window with a 4×4 grid containing numbered tiles from 1-15 and one empty space. The goal is to arrange the tiles in numerical order by sliding them into the empty space.

### Features

- **Modern Vim9 Implementation**: Built with Vim9 script features including classes, interfaces, enums, and type annotations
- **Popup Window Interface**: Non-intrusive gameplay in a centered popup window
- **Unicode Box Drawing**: Clear visual separation between tiles using Unicode characters
- **Guaranteed Solvable**: Every generated puzzle is verified to be solvable using mathematical validation
- **Keyboard Controls**: Intuitive arrow key navigation plus quick reset and help

## Requirements

- **Vim 9.0 or later** with Vim9 script support
- This plugin is **Vim-only** and does not support Neovim

## Installation

### Manual Installation

1. Create the plugin directory structure:

   **Unix/Linux/macOS:**
   ```bash
   mkdir -p ~/.vim/pack/plugins/start/number-puzzle
   ```

   **Windows:**
   ```cmd
   mkdir %USERPROFILE%\vimfiles\pack\plugins\start\number-puzzle
   ```

2. Clone or copy the plugin files into the directory:

   ```bash
   cd ~/.vim/pack/plugins/start/
   git clone https://github.com/yourusername/number-puzzle.git
   ```

   Your directory structure should look like:
   ```
   number-puzzle/
   ├── plugin/
   │   └── number_puzzle.vim
   ├── autoload/
   │   └── numberpuzzle.vim
   ├── doc/
   │   └── number_puzzle.txt
   └── README.md
   ```

3. Generate help tags from within Vim:

   ```vim
   :helptags ~/.vim/pack/plugins/start/number-puzzle/doc
   ```

   Or on Windows:
   ```vim
   :helptags ~/vimfiles/pack/plugins/start/number-puzzle/doc
   ```

### Plugin Manager Installation

#### vim-plug

Add to your `.vimrc` or `init.vim`:

```vim
Plug 'yourusername/number-puzzle'
```

Then run:
```vim
:PlugInstall
:helptags ALL
```

#### Other Plugin Managers

For Vundle, Pathogen, or other plugin managers, follow their standard installation procedures.

## Usage

### Commands

| Command | Description |
|---------|-------------|
| `:NumberPuzzleStart` | Start a new game or reset if already open |
| `:NumberPuzzleReset` | Reset the current puzzle with a new configuration |

### Keyboard Controls

When the puzzle popup is active:

| Key | Action |
|-----|--------|
| `↑` | Move tile below empty space upward |
| `↓` | Move tile above empty space downward |
| `←` | Move tile right of empty space leftward |
| `→` | Move tile left of empty space rightward |
| `r` | Reset puzzle with new scrambled configuration |
| `q` | Quit and close the puzzle |
| `?` | Show help message |

**Note:** Arrow keys move tiles *into* the empty space, not the empty space itself.

## How to Play

1. **Start the game:**
   ```vim
   :NumberPuzzleStart
   ```

2. **Objective:**
   Arrange the numbered tiles in order from 1 to 15, reading left to right, top to bottom, with the empty space in the bottom-right corner:

   ```
    1 │  2 │  3 │  4
   ───┼────┼────┼────
    5 │  6 │  7 │  8
   ───┼────┼────┼────
    9 │ 10 │ 11 │ 12
   ───┼────┼────┼────
   13 │ 14 │ 15 │
   ```

3. **Move tiles:**
   - Use arrow keys to slide tiles adjacent to the empty space
   - Only tiles directly next to the empty space (horizontally or vertically) can be moved
   - Press the arrow key pointing from the empty space toward the tile you want to move

4. **Strategy tips:**
   - Plan multiple moves ahead to avoid getting stuck
   - Try solving row by row, starting from the top
   - The last two tiles in each row often require special techniques
   - All generated puzzles are guaranteed to be solvable!

5. **Win:**
   When you solve the puzzle, you'll see: "Solved! Press r to reset or q to quit."

## Documentation

Full documentation is available within Vim after installation:

```vim
:help number-puzzle
```

Browse available help topics:
- `:help number-puzzle-introduction`
- `:help number-puzzle-installation`
- `:help number-puzzle-commands`
- `:help number-puzzle-keys`
- `:help number-puzzle-how-to-play`

## Technical Details

This plugin showcases modern Vim9 script features:

- **Classes & Interfaces**: Object-oriented design with `Puzzle` and `PopupView` classes
- **Enums**: Type-safe direction handling with `Dir` enum
- **Type Annotations**: Full type safety with `Board`, `Pos`, and other custom types
- **Export System**: Clean separation between plugin and autoload with explicit exports
- **Popup Windows**: Modern UI using Vim's popup window API

The puzzle generation algorithm ensures solvability by checking the inversion count and empty tile position according to the mathematical properties of the 15-puzzle.


## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

## Credits

The Number Slide Puzzle (also known as the 15-puzzle) is a classic sliding puzzle invented in the 1870s.
All the files in this repository were generated by GitHub Copilot.

This Vim9 implementation demonstrates modern Vimscript capabilities while providing an enjoyable puzzle experience.
