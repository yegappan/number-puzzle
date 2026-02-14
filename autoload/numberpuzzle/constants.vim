vim9script

# Constants module for the number puzzle.
# Centralizes all constant values used across the plugin.

# Cell value representing the empty space
export const EMPTY: number = 0

# Unicode box drawing characters for rendering
export const VSEP: string = '│'
export const HSEP: string = '─'
export const CROSS: string = '┼'

# Default board size
export const DEFAULT_SIZE: number = 4
