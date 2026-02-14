vim9script

# Board module for the number puzzle.
# Provides a Board class that encapsulates puzzle board state,
# generation, validation, and manipulation logic.

import './types.vim'
import './constants.vim'

# Board class encapsulating board state and operations.
export class Board
  var cells: types.Board
  var size: number

  # Create a new board with a solvable scrambled configuration.
  def new(board_size: number)
    this.size = board_size
    this.cells = this.GenerateSolvable()
  enddef

  # Get the board cells.
  def GetCells(): types.Board
    return this.cells
  enddef

  # Get the size of the board.
  def GetSize(): number
    return this.size
  enddef

  # Find the index of the empty cell.
  def FindEmpty(): types.Index
    return index(this.cells, constants.EMPTY)
  enddef

  # Swap two cells by their indices.
  def Swap(index_a: types.Index, index_b: types.Index)
    var tmp = this.cells[index_a]
    this.cells[index_a] = this.cells[index_b]
    this.cells[index_b] = tmp
  enddef

  # Check if the board is in solved state.
  def IsSolved(): bool
    var solved = this.GenerateSolvedState()
    return this.cells ==# solved
  enddef

  # Reset the board with a new solvable scrambled configuration.
  def Reset()
    this.cells = this.GenerateSolvable()
  enddef

  # Generate a solved board for the current size.
  def GenerateSolvedState(): types.Board
    var total = this.size * this.size
    var board: types.Board = []
    for i in range(1, total - 1)
      board->add(i)
    endfor
    board->add(constants.EMPTY)
    return board
  enddef

  # Generate a solvable scrambled board.
  def GenerateSolvable(): types.Board
    var board = this.GenerateSolvedState()

    # Shuffle until solvable and not already solved.
    const MAX_TRIES = 5000
    for _ in range(0, MAX_TRIES)
      board = this.Shuffle(board)
      if this.IsSolvableState(board) && !this.IsSolvedState(board)
        return board
      endif
    endfor

    # Fallback: return solved board if no shuffle matched.
    return this.GenerateSolvedState()
  enddef

  # Shuffle a board using Fisher-Yates algorithm.
  def Shuffle(input: types.Board): types.Board
    var board = deepcopy(input)
    var n = len(board)
    for i in range(n - 1, 1, -1)
      var j = rand() % (i + 1)
      var tmp = board[i]
      board[i] = board[j]
      board[j] = tmp
    endfor
    return board
  enddef

  # Check if a given board state is solved.
  def IsSolvedState(board: types.Board): bool
    var solved = this.GenerateSolvedState()
    return board ==# solved
  enddef

  # Check if a board configuration is solvable.
  # Uses inversion count and empty tile position.
  def IsSolvableState(board: types.Board): bool
    var inversions = 0
    var total = this.size * this.size
    for i in range(0, total - 1)
      if board[i] == constants.EMPTY
        continue
      endif
      for j in range(i + 1, total - 1)
        if board[j] == constants.EMPTY
          continue
        endif
        if board[i] > board[j]
          inversions += 1
        endif
      endfor
    endfor

    if this.size % 2 == 1
      return inversions % 2 == 0
    endif

    # For even width, blank row from bottom matters.
    var empty_idx = index(board, constants.EMPTY)
    var empty_row_from_bottom = this.size - (empty_idx / this.size)
    if empty_row_from_bottom % 2 == 0
      return inversions % 2 == 1
    endif

    return inversions % 2 == 0
  enddef
endclass
