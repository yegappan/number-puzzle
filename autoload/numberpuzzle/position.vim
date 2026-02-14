vim9script

# Position calculation module for the number puzzle.
# Handles conversion between linear indices and 2D positions,
# and calculates adjacency and movement.

import './types.vim'

# Convert linear index to 2D position (row, col).
export def IndexToPos(index: types.Index, size: number): types.Pos
  return (index / size, index % size)
enddef

# Convert 2D position to linear index.
export def PosToIndex(pos: types.Pos, size: number): types.Index
  return pos[0] * size + pos[1]
enddef

# Check if two indices are adjacent on the board.
export def IsAdjacent(a: types.Index, b: types.Index, size: number): bool
  if a == b
    return false
  endif
  var a_pos = IndexToPos(a, size)
  var b_pos = IndexToPos(b, size)
  return (a_pos[0] == b_pos[0] && (a_pos[1] - b_pos[1])->abs() == 1)
    || (a_pos[1] == b_pos[1] && (a_pos[0] - b_pos[0])->abs() == 1)
enddef

# Calculate the target index when moving in a direction.
# Returns -1 if the move is invalid (would go out of bounds).
export def NextIndex(empty: types.Index, size: number, dir: types.Dir): types.Index
  var row = empty / size
  var col = empty % size

  if dir == types.Dir.Up
    if row < size - 1
      return empty + size
    endif
  elseif dir == types.Dir.Down
    if row > 0
      return empty - size
    endif
  elseif dir == types.Dir.Left
    if col < size - 1
      return empty + 1
    endif
  elseif dir == types.Dir.Right
    if col > 0
      return empty - 1
    endif
  endif

  return -1
enddef
