" ===========================================================================
" Description:  Vim plugin that execute shell command and redirects output
"               to a new buffer
" Author:       Alexander Skachko <alexander.skachko@gmail.com>
" Homepage:     https://github.com/lucerion/vim-executor
" Version:      1.0.0 (2017-10-08)
" Licence:      BSD-3-Clause
" ===========================================================================

if exists('g:loaded_executor') || &compatible || v:version < 700
  finish
endif
let g:loaded_executor = 1

if !exists('g:executor_buffer_name')
  let g:executor_buffer_name = '{command}'
endif

if !exists('g:executor_reuse_buffer')
  let g:executor_reuse_buffer = 0
endif

comm! -nargs=+ -bang -range=0 -complete=shellcmd Exec
  \ call executor#exec(<line1>, <line2>, empty('<bang>'), <q-mods>, <q-args>)
