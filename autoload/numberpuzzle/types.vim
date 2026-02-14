vim9script

# Type definitions for the number puzzle.
# Centralizes all type aliases and enums.

# Type for the puzzle board - a flat list of cell values
export type Board = list<number>

# Type for a 2D position (row, column)
export type Pos = tuple<number, number>

# Type for a cell index (0-based flat index)
export type Index = number

# Type for a cell value (number or EMPTY)
export type CellValue = number

# Enum for movement directions
export enum Dir
  Up,
  Down,
  Left,
  Right
endenum

# Enum for game state
export enum GameState
  Playing,
  Solved
endenum
