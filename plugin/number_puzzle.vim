vim9script

# Number Slide Puzzle plugin for Vim9.
# Provides :NumberPuzzleStart to open a puzzle buffer and play.

if exists('g:loaded_number_puzzle')
  finish
endif

import autoload '..\autoload\numberpuzzle.vim'

g:loaded_number_puzzle = 1

command! NumberPuzzleStart numberpuzzle.Start()
command! NumberPuzzleReset numberpuzzle.Reset()
