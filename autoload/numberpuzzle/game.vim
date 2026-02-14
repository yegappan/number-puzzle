vim9script

# Game logic module.
# Contains the Puzzle class that manages game state and moves.

import './board.vim'
import './types.vim'
import './constants.vim'
import './position.vim'
import './renderer.vim'
import './view.vim'

export class Puzzle
  var board: board.Board
  var cell_width: number
  var view: view.IPuzzleView
  var state: types.GameState

  def new(size: number, puzzle_view: view.IPuzzleView)
    this.view = puzzle_view
    this.board = board.Board.new(size)
    this.cell_width = renderer.CalculateCellWidth(size)
    this.state = types.GameState.Playing
  enddef

  # Get the current board size.
  def GetSize(): number
    return this.board.GetSize()
  enddef

  # Get the current game state.
  def GetState(): types.GameState
    return this.state
  enddef

  # Reset the puzzle with a new scrambled board.
  def Reset()
    this.board.Reset()
    this.state = types.GameState.Playing
  enddef

  # Render the current board state.
  def Render()
    var cells = this.board.GetCells()
    var size = this.board.GetSize()
    var lines = renderer.BuildLines(cells, size, this.cell_width)
    this.view.Render(lines)
  enddef

  # Move a tile in the specified direction.
  def Move(dir: types.Dir)
    if this.state == types.GameState.Solved
      return
    endif

    var empty_index = this.board.FindEmpty()
    var size = this.board.GetSize()
    var target = position.NextIndex(empty_index, size, dir)

    if target >= 0
      this.board.Swap(empty_index, target)
      this.Render()
      this.CheckSolved()
    endif
  enddef

  # Check if the puzzle is solved and update state.
  def CheckSolved()
    if this.board.IsSolved()
      this.state = types.GameState.Solved
      echo "Solved! Press r to reset or q to quit."
    endif
  enddef
endclass
