vim9script

# Number Puzzle autoload implementation for Vim9.

const BOARD_SIZE = 4
const EMPTY = 0
const VSEP = '│'
const HSEP = '─'
const CROSS = '┼'

export type Board = list<number>
type Pos = tuple<number, number>

export enum Dir
  Up,
  Down,
  Left,
  Right
endenum

interface IPuzzleView
  def Render(lines: list<string>)
endinterface

class PopupView implements IPuzzleView
  var id: number

  def new()
    this.id = 0
  enddef

  def Render(lines: list<string>)
    if this.id == 0 || empty(popup_getpos(this.id))
      var width = 0
      for line in lines
        if strdisplaywidth(line) > width
          width = strdisplaywidth(line)
        endif
      endfor
      var height = len(lines)
      this.id = popup_create(lines, {
        pos: 'center',
        minwidth: width,
        maxwidth: width,
        minheight: height,
        maxheight: height,
        title: 'Puzzle',
        wrap: 0,
        padding: [0, 0, 0, 0],
        border: [],
        mapping: 0,
        filter: PopupFilter,
        callback: PopupClosed,
      })
      popup_id = this.id
    else
      popup_settext(this.id, lines)
      var width = 0
      for line in lines
        if strdisplaywidth(line) > width
          width = strdisplaywidth(line)
        endif
      endfor
      var height = len(lines)
      popup_setoptions(this.id, {
        minwidth: width,
        maxwidth: width,
        minheight: height,
        maxheight: height,
        title: 'Puzzle',
      })
    endif
  enddef
endclass

class Puzzle
  var size: number
  var board: Board
  var empty_index: number
  var cell_width: number
  var view: IPuzzleView

  def new(size: number, view: IPuzzleView)
    this.size = size
    this.view = view
    this.cell_width = len(string(size * size - 1))
    this.Reset()
  enddef

  def Reset()
    this.board = GenerateSolvableBoard(this.size)
    this.empty_index = index(this.board, EMPTY)
  enddef

  def Render()
    this.view.Render(BuildLines(this.board, this.size, this.cell_width))
  enddef

  def Move(dir: Dir)
    var target = NextIndex(this.empty_index, this.size, dir)
    if target >= 0
      this.Swap(target)
    endif
  enddef

  def Swap(tile_index: number)
    var tmp = this.board[tile_index]
    this.board[tile_index] = this.board[this.empty_index]
    this.board[this.empty_index] = tmp
    this.empty_index = tile_index

    this.Render()

    if IsSolved(this.board, this.size)
      echo "Solved! Press r to reset or q to quit."
    endif
  enddef
endclass

var popup_id = 0
var current_game: any = null_object
var current_view: any = null_object


export def Start()
  # Reuse current popup if it is already open.
  if popup_id != 0 && !empty(popup_getpos(popup_id))
    Reset()
    return
  endif

  current_view = PopupView.new()
  current_game = Puzzle.new(BOARD_SIZE, current_view)
  RenderGame()
enddef


def RenderGame()
  if popup_id == 0 && current_game == null_object
    return
  endif
  var game: Puzzle = current_game
  game.Render()
enddef


export def Reset()
  if popup_id == 0 && current_game == null_object
    return
  endif
  var game: Puzzle = current_game
  game.Reset()
  game.Render()
enddef


export def Help()
  echo "Number Puzzle: use arrow keys to move tiles; press r to reset or q to close."
enddef


def Move(dir: Dir)
  if popup_id == 0 || current_game == null_object
    return
  endif
  var game: Puzzle = current_game
  game.Move(dir)
enddef


def ClosePopup()
  if popup_id == 0
    return
  endif
  popup_close(popup_id)
  popup_id = 0
  current_game = null_object
  current_view = null_object
enddef


def PopupFilter(id: number, key: string): number
  if id != popup_id
    return 0
  endif

  if key ==# "\<Up>"
    Move(Dir.Up)
  elseif key ==# "\<Down>"
    Move(Dir.Down)
  elseif key ==# "\<Left>"
    Move(Dir.Left)
  elseif key ==# "\<Right>"
    Move(Dir.Right)
  elseif key ==# 'r' || key ==# 'R'
    Reset()
  elseif key ==# 'q' || key ==# 'Q'
    ClosePopup()
  elseif key ==# '?'
    Help()
  else
    return 0
  endif

  return 1
enddef


def PopupClosed(id: number, result: number)
  if id != popup_id
    return
  endif
  popup_id = 0
  current_game = null_object
  current_view = null_object
enddef


def GenerateSolvedBoard(size: number): Board
  var total = size * size
  var board: Board = []
  for i in range(1, total - 1)
    board->add(i)
  endfor
  board->add(EMPTY)
  return board
enddef


def GenerateSolvableBoard(size: number): Board
  var board = GenerateSolvedBoard(size)

  # Shuffle until solvable and not already solved.
  var max_tries = 5000
  for _ in range(0, max_tries)
    board = Shuffle(board)
    if IsSolvable(board, size) && !IsSolved(board, size)
      return board
    endif
  endfor

  # Fallback: return solved board if no shuffle matched.
  return GenerateSolvedBoard(size)
enddef


def Shuffle(input: Board): Board
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


def IsSolved(board: Board, size: number): bool
  var solved = GenerateSolvedBoard(size)
  return board ==# solved
enddef


def IsSolvable(board: Board, size: number): bool
  var inversions = 0
  var total = size * size
  for i in range(0, total - 1)
    if board[i] == EMPTY
      continue
    endif
    for j in range(i + 1, total - 1)
      if board[j] == EMPTY
        continue
      endif
      if board[i] > board[j]
        inversions += 1
      endif
    endfor
  endfor

  if size % 2 == 1
    return inversions % 2 == 0
  endif

  # For even width, blank row from bottom matters.
  var empty_idx = index(board, EMPTY)
  var empty_row_from_bottom = size - (empty_idx / size)
  if empty_row_from_bottom % 2 == 0
    return inversions % 2 == 1
  endif

  return inversions % 2 == 0
enddef


def IndexToPos(index: number, size: number): Pos
  return (index / size, index % size)
enddef


def IsAdjacent(a: number, b: number, size: number): bool
  if a == b
    return false
  endif
  var a_pos = IndexToPos(a, size)
  var b_pos = IndexToPos(b, size)
  return (a_pos[0] == b_pos[0] && (a_pos[1] - b_pos[1])->abs() == 1)
    || (a_pos[1] == b_pos[1] && (a_pos[0] - b_pos[0])->abs() == 1)
enddef


def NextIndex(empty: number, size: number, dir: Dir): number
  var row = empty / size
  var col = empty % size

  if dir == Dir.Up
    if row < size - 1
      return empty + size
    endif
  elseif dir == Dir.Down
    if row > 0
      return empty - size
    endif
  elseif dir == Dir.Left
    if col < size - 1
      return empty + 1
    endif
  elseif dir == Dir.Right
    if col > 0
      return empty - 1
    endif
  endif

  return -1
enddef


def BuildLines(board: Board, size: number, cell_width: number): list<string>
  var total = size * size
  var lines: list<string> = []
  var row: list<string> = []
  var row_sep_parts: list<string> = []
  for _ in range(0, size - 1)
    row_sep_parts->add(repeat(HSEP, cell_width))
  endfor
  var row_sep = join(row_sep_parts, HSEP .. CROSS .. HSEP)

  for i in range(0, total - 1)
    var val = board[i]
    if val == EMPTY
      row->add(repeat(' ', cell_width))
    else
      row->add(printf('%*d', cell_width, val))
    endif

    if (i + 1) % size == 0
      lines->add(join(row, ' ' .. VSEP .. ' '))
      if i + 1 < total
        lines->add(row_sep)
      endif
      row = []
    endif
  endfor

  return lines
enddef
