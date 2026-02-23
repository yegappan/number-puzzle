vim9script
# Number Puzzle (15-Puzzle) Game Plugin for Vim9
# Sliding puzzle - arrange numbered tiles in correct order
# Requires: Vim 9.0+

if exists('g:loaded_number_puzzle')
  finish
endif
g:loaded_number_puzzle = 1

import autoload '../autoload/numberpuzzle.vim' as NumberPuzzle

# Command to start the game with optional size parameter (3, 4, or 5)
# Usage: :NumberPuzzle [3|4|5]
command! -nargs=? NumberPuzzle call NumberPuzzle.StartGame(<f-args>)
