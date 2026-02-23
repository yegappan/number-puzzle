# Number Slide Puzzle in Vim9script

A classic 15-puzzle sliding tile game where you arrange numbered tiles in order by sliding them into an empty space. Written in Vim9script to showcase classes, interfaces, type aliases, and guaranteed solvable puzzle generation.

## Features

- **Guaranteed Solvable**: Every puzzle is verified solvable using mathematical validation
- **Multiple Grid Sizes**: 3×3, 4×4 (default), and 5×5 puzzles
- **Vim-style Controls**: Arrow keys or hjkl for tile movement
- **Popup Window UI**: Non-intrusive gameplay in a centered window
- **Puzzle Reset**: Generate new scrambled configurations
- **Modern Vim9script**: Demonstrates OOP principles and modular design

## Requirements

- Vim 9.0 or later with Vim9script support
- **NOT compatible with Neovim** (requires Vim9-specific features)

## Installation

### Using Git

**Unix/Linux/macOS:**
```bash
git clone https://github.com/yegappan/number-puzzle.git ~/.vim/pack/downloads/opt/number-puzzle
```

**Windows (cmd.exe):**
```cmd
git clone https://github.com/yegappan/number-puzzle.git %USERPROFILE%\vimfiles\pack\downloads\opt\number-puzzle
```

### Using a ZIP file

**Unix/Linux/macOS:**
```bash
mkdir -p ~/.vim/pack/downloads/opt/
```
Download the ZIP file from GitHub and extract it into the directory above. Rename the extracted folder (usually number-puzzle-main) to `number-puzzle` so the final path matches:

```plaintext
~/.vim/pack/downloads/opt/number-puzzle/
├── plugin/
├── autoload/
└── doc/
```

**Windows (cmd.exe):**
```cmd
if not exist "%USERPROFILE%\vimfiles\pack\downloads\opt" mkdir "%USERPROFILE%\vimfiles\pack\downloads\opt"
```
Download the ZIP file from GitHub and extract it into the directory above. Rename the extracted folder (usually number-puzzle-main) to `number-puzzle` so the final path matches:

```plaintext
%USERPROFILE%\vimfiles\pack\downloads\opt\number-puzzle\
├── plugin/
├── autoload/
└── doc/
```

### Finalizing Setup

Since the plugin is in the `opt` directory, add this to your `.vimrc` (Unix) or `_vimrc` (Windows):
```viml
packadd number-puzzle
```

Then restart Vim and run:
```viml
:helptags ALL
```

### Plugin Manager Installation

If using vim-plug, add to your config:
```viml
Plug 'path/to/number-puzzle'
```
Then run `:PlugInstall` and `:helptags ALL`.

For other plugin managers, follow their standard procedure for local plugins.

## Usage

### Starting the Game

Start a 4×4 puzzle (default):
```vim
:NumberPuzzle
```

Start a 3×3 puzzle:
```vim
:NumberPuzzle 3
```

Start a 5×5 puzzle:
```vim
:NumberPuzzle 5
```

### Controls

| Key | Action |
|-----|--------|
| `↑` or `k` | Move tile below empty space upward |
| `↓` or `j` | Move tile above empty space downward |
| `←` or `h` | Move tile right of empty space leftward |
| `→` or `l` | Move tile left of empty space rightward |
| `r` | Reset with new scrambled configuration |
| `q` | Quit and close puzzle |
| `?` | Show help message |

### How to Play

**Objective**: Arrange tiles in order (1-15) with the empty space in the bottom-right corner:

```
 1 │  2 │  3 │  4
───┼────┼────┼────
 5 │  6 │  7 │  8
───┼────┼────┼────
 9 │ 10 │ 11 │ 12
───┼────┼────┼────
13 │ 14 │ 15 │
```

**Strategy Tips**:
- Plan multiple moves ahead
- Try solving row by row from the top
- The last two tiles in each row often require special techniques
- Every puzzle is guaranteed solvable!

### Game Rules

- Only tiles adjacent to the empty space (horizontally or vertically) can move
- Tiles slide into the empty space
- Press arrow keys pointing from the empty space toward the tile to move it
- Win when all tiles are in numerical order

## Vim9 Language Features Demonstrated

- **Classes**: `Board` class for state management, `Puzzle` class for game logic, `PopupView` for UI
- **Interfaces**: `IPuzzleView` interface for abstract view layer
- **Enums**: `Dir` for movement directions, `GameState` for game states
- **Type Aliases**: `Board`, `Pos`, `Index`, `CellValue` for semantic clarity
- **Type Checking**: Full type annotations on all parameters and returns
- **Modular Architecture**: Separation of concerns across specialized modules
- **Popup Windows**: Modern UI using Vim's popup window API
- **Algorithm**: Fisher-Yates shuffle with solvability checking using inversion count

## License

This plugin is licensed under the MIT License. See the LICENSE file in the repository for details.

