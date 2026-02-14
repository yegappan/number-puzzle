vim9script

# Renderer module for the number puzzle.
# Handles conversion of board state to display lines.

import './types.vim'
import './constants.vim'

# Build display lines for the board.
# Returns a list of strings ready for rendering in the popup.
export def BuildLines(board: types.Board, size: number, cell_width: number): list<string>
  var total = size * size
  var lines: list<string> = []
  var row: list<string> = []
  var row_sep_parts: list<string> = []

  # Build the row separator line
  for _ in range(0, size - 1)
    row_sep_parts->add(repeat(constants.HSEP, cell_width))
  endfor
  var row_sep = join(row_sep_parts, constants.HSEP .. constants.CROSS .. constants.HSEP)

  # Build each row
  for i in range(0, total - 1)
    var val = board[i]
    if val == constants.EMPTY
      row->add(repeat(' ', cell_width))
    else
      row->add(printf('%*d', cell_width, val))
    endif

    # End of row - add to lines
    if (i + 1) % size == 0
      lines->add(join(row, ' ' .. constants.VSEP .. ' '))
      if i + 1 < total
        lines->add(row_sep)
      endif
      row = []
    endif
  endfor

  return lines
enddef

# Calculate the required cell width for a given board size.
export def CalculateCellWidth(size: number): number
  return len(string(size * size - 1))
enddef
