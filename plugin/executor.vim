" ===========================================================================
" Description:  Vim plugin that executes shell command with a buffer contents
"               or selection and redirects output to a new buffer
" Author:       Alexander Skachko <alexander.skachko@gmail.com>
" Homepage:     https://github.com/lucerion/vim-executor
" Version:      0.1
" Licence:      BSD-3-Clause
" ===========================================================================

if exists('g:loaded_executor') || &compatible || (v:version < 700)
  finish
endif

if !exists('g:executor_position')
  let g:executor_position = 'bottom'
endif

if !exists('g:executor_default_command')
  let g:executor_default_command = 'sh -e'
endif

if !exists('g:executor_buffer_name')
  let g:executor_buffer_name = '{command}'
endif

comm! -nargs=* -range=0 -complete=shellcmd Exec
  \ call executor#exec(<line1>, <line2>, <count>, <q-args>)

let g:loaded_executor = 1
