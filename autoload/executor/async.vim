" ===========================================================================
" Description:  Vim plugin that execute shell command and redirect output
"               to a new buffer
" Author:       Alexander Skachko <alexander.skachko@gmail.com>
" Homepage:     https://github.com/lucerion/vim-executor
" Version:      1.0.0 (2017-10-08)
" Licence:      BSD-3-Clause
" ===========================================================================

func! executor#async#exec(command, selection, open_result, mods) abort
  let s:command = a:command
  let s:result = []
  let s:open_result = a:open_result
  let s:mods = a:mods
  call s:execute(a:command, a:selection, a:mods)
endfunc

func! s:execute(command, selection, mods) abort
  let l:command = a:command

  if len(a:selection) == 1 && !empty(a:selection[0])
    let l:command .= ' '
    let l:command .= a:selection[0]
  endif

  if len(a:selection) > 1
    let l:command = 'echo "' . join(a:selection, "\n") . '" | ' . l:command
  endif

  call job_start([&shell, &shellcmdflag, l:command], {
    \ 'out_cb': function('s:out_callback'),
    \ 'exit_cb': function('s:exit_callback')
    \ })
endfunc

func! s:out_callback(channel, data) abort
  call add(s:result, a:data)
endfunc

func! s:exit_callback(job, status) abort
  if s:open_result
    call executor#open_result(s:result, s:command, s:mods)
  endif
endfunc
