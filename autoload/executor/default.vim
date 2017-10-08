" ===========================================================================
" Description:  Vim plugin that execute shell command and redirect output
"               to a new buffer
" Author:       Alexander Skachko <alexander.skachko@gmail.com>
" Homepage:     https://github.com/lucerion/vim-executor
" Version:      0.2.0 (2016-12-20)
" Licence:      BSD-3-Clause
" ===========================================================================

func! executor#default#exec(command, selection, open_result) abort
  let l:result = s:execute(a:command, a:selection)
  if a:open_result
    call executor#open_result(split(l:result, "\n"), a:command)
  endif
endfunc

func! s:execute(command, selection) abort
  if !len(a:selection) || (len(a:selection) == 1 && empty(a:selection[0]))
    return system(a:command)
  endif

  if len(a:selection) == 1
    let l:command = a:command . ' ' . a:selection[0]
    return system(l:command)
  endif

  let l:selection = join(a:selection, "\n") . "\n"
  return system(a:command, l:selection)
endfunc
