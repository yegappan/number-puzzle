# Number Slide Puzzle for Vim9

A classic 15-puzzle sliding tile game implemented as a Vim9 plugin, displayed in a popup window.

## Overview

The Number Slide Puzzle plugin provides an interactive sliding puzzle game directly in Vim. The puzzle appears in a centered popup window with a 4×4 grid containing numbered tiles from 1-15 and one empty space. The goal is to arrange the tiles in numerical order by sliding them into the empty space.

### Features

- **Modern Vim9 Implementation**: Built with Vim9 script features including classes, interfaces, enums, and type annotations
- **Highly Modular Architecture**: Clean separation of concerns across multiple specialized modules
- **Popup Window Interface**: Non-intrusive gameplay in a centered popup window
- **Unicode Box Drawing**: Clear visual separation between tiles using Unicode characters
- **Guaranteed Solvable**: Every generated puzzle is verified to be solvable using mathematical validation
- **Keyboard Controls**: Intuitive arrow key navigation plus quick reset and help

## Requirements

- **Vim 9.0 or later** with Vim9 script support
- This plugin is **Vim-only** and does not support Neovim

## Installation

### Using Git
If you have git installed, run the following command in your terminal:

**Unix/Linux/macOS:**

```bash
git clone https://github.com/yegappan/number-puzzle.git ~/.vim/pack/downloads/opt/number-puzzle
```
**Windows (cmd.exe):**

```cmd
git clone https://github.com/yegappan/number-puzzle.git %USERPROFILE%\vimfiles\pack\downloads\opt\number-puzzle
```

### Using a ZIP file
If you prefer not to use Git:

**Unix/Linux/macOS:**

Create the destination directory:

```bash
mkdir -p ~/.vim/pack/downloads/opt/
```

Download the plugin ZIP file from GitHub and extract its contents into the directory created above.

*Note:* GitHub usually names the extracted folder number-puzzle-main. Rename it to number-puzzle so the final path looks like this:

```plaintext
~/.vim/pack/downloads/opt/number-puzzle/
├── plugin/
├── autoload/
└── doc/
```

**Windows (cmd.exe):**

Create the destination directory:

```cmd
if not exist "%USERPROFILE%\vimfiles\pack\downloads\opt" mkdir "%USERPROFILE%\vimfiles\pack\downloads\opt"
```

Download the plugin ZIP file from GitHub and extract its contents into that directory.

*Note:* Rename the extracted folder (usually number-puzzle-main) to number-puzzle so the path matches:

```plaintext
%USERPROFILE%\vimfiles\pack\downloads\opt\number-puzzle\
├── plugin/
├── autoload/
└── doc/
```

**Finalizing Setup**
Since this plugin is installed in the opt (optional) directory, it will not load automatically. Add the following line to your .vimrc (Unix) or _vimrc (Windows):

```viml
packadd number-puzzle
```

After adding the line, restart Vim and run the following command to enable the help documentation:

```viml
:helptags ALL
```

### Plugin Manager Installation

If using a plugin manager like vim-plug, add to your .vimrc or init.vim:

   ```viml
   Plug 'path/to/number-puzzle'
   ```

Then run `:PlugInstall` and `:helptags ALL`

For other plugin managers (Vundle, Pathogen, etc.), follow their standard
installation procedures for local plugins.

## Usage

### Commands

| Command | Description |
|---------|-------------|
| `:NumberPuzzle` | Start a new game or reset if already open |

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
   :NumberPuzzle
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

### Architecture

The plugin is organized into highly modular components:

- **constants.vim**: Centralized constant definitions (EMPTY, drawing characters, defaults)
- **types.vim**: Type aliases (`Board`, `Pos`, `Index`, `CellValue`) and enums (`Dir`, `GameState`)
- **position.vim**: Position and index calculations, adjacency checks, movement logic
- **renderer.vim**: Board-to-display conversion and rendering logic
- **board.vim**: `Board` class encapsulating board state, generation, and validation
- **game.vim**: `Puzzle` class managing game state and move logic
- **view.vim**: `IPuzzleView` interface and `PopupView` class for UI rendering
- **numberpuzzle.vim**: Main coordinator for game initialization and key handling

### Vim9 Script Features

This plugin showcases modern Vim9 script features:

- **Classes**: Object-oriented design with `Board`, `Puzzle`, and `PopupView` classes
- **Interfaces**: `IPuzzleView` interface for view abstraction
- **Enums**: Type-safe enums for `Dir` (movement directions) and `GameState`
- **Type Aliases**: Custom types like `Board`, `Pos`, `Index`, and `CellValue` for clarity
- **Type Annotations**: Full type safety throughout with explicit type declarations
- **Export System**: Clean module separation with explicit imports and exports
- **Popup Windows**: Modern UI using Vim's popup window API
- **Constants**: Centralized constant definitions for maintainability

### Algorithm

The puzzle generation algorithm ensures solvability by checking the inversion count and empty tile position according to the mathematical properties of the 15-puzzle. The Fisher-Yates shuffle algorithm provides fair randomization while maintaining solvability guarantees.


## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

## Credits

The Number Slide Puzzle (also known as the 15-puzzle) is a classic sliding puzzle invented in the 1870s.
All the files in this repository were generated by GitHub Copilot.

This Vim9 implementation demonstrates modern Vimscript capabilities while providing an enjoyable puzzle experience.
