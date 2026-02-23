vim9script

# Number Puzzle autoload implementation for Vim9.
# Main entry point that coordinates the game modules.

import './numberpuzzle/game.vim'
import './numberpuzzle/types.vim'
import './numberpuzzle/constants.vim'
import './numberpuzzle/view.vim'

var popup_id: number = 0
var current_game: any = null_object
var current_view: any = null_object
var current_size: number = constants.DEFAULT_SIZE


# Start a new puzzle game or reset if already running.
export def Start(size: number = constants.DEFAULT_SIZE)
  # Validate puzzle size
  if size < 3 || size > 5
    echohl ErrorMsg
    echo 'Error: Puzzle size must be 3, 4, or 5'
    echohl None
    return
  endif

  current_size = size

  # Reuse current popup if it is already open.
  if current_view != null_object && current_view.IsOpen()
    Reset()
    return
  endif

  current_view = view.PopupView.new()
  current_game = game.Puzzle.new(size, current_view)

  # Set up popup with filter and callback
  SetupPopup()

  RenderGame()
enddef


# Wrapper function to handle command-line arguments.
export def StartGame(...args: list<any>)
  var size = constants.DEFAULT_SIZE
  if len(args) > 0
    var size_arg = args[0]
    if !empty(size_arg)
      size = str2nr(size_arg)
    endif
  endif
  Start(size)
enddef


# Setup the popup window with filter and callback.
def SetupPopup()
  if current_view == null_object
    return
  endif

  # First render to create the popup
  var puzzle: game.Puzzle = current_game
  puzzle.Render()

  # Get the popup ID and configure it
  popup_id = current_view.GetId()
  if popup_id != 0
    popup_setoptions(popup_id, {
      filter: PopupFilter,
      callback: PopupClosed,
    })
  endif
enddef


# Render the current game state.
def RenderGame()
  if current_game == null_object
    return
  endif
  var puzzle: game.Puzzle = current_game
  puzzle.Render()
enddef


# Reset the current puzzle with a new scrambled board.
export def Reset()
  if current_game == null_object
    return
  endif
  var puzzle: game.Puzzle = current_game
  puzzle.Reset()
  puzzle.Render()
enddef


# Display help message.
export def Help()
  var size_str = 'Current size: ' .. current_size .. 'x' .. current_size
  echo "Number Puzzle (" .. size_str .. "): arrow keys/hjkl to move, r to reset, q to close"
enddef


# Move a tile in the specified direction.
def Move(dir: types.Dir)
  if popup_id == 0 || current_game == null_object
    return
  endif
  var puzzle: game.Puzzle = current_game
  puzzle.Move(dir)
enddef


# Close the popup and cleanup.
def ClosePopup()
  if current_view != null_object
    current_view.Close()
  endif
  popup_id = 0
  current_game = null_object
  current_view = null_object
enddef


# Popup filter function for handling key presses.
def PopupFilter(id: number, key: string): number
  if id != popup_id
    return 0
  endif

  if key ==# "\<Up>" || key ==# 'k'
    Move(types.Dir.Up)
  elseif key ==# "\<Down>" || key ==# 'j'
    Move(types.Dir.Down)
  elseif key ==# "\<Left>" || key ==# 'h'
    Move(types.Dir.Left)
  elseif key ==# "\<Right>" || key ==# 'l'
    Move(types.Dir.Right)
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


# Popup callback function for cleanup when closed.
def PopupClosed(id: number, result: number)
  if id != popup_id
    return
  endif
  popup_id = 0
  current_game = null_object
  current_view = null_object
enddef
