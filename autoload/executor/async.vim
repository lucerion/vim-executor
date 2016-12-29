" ===========================================================================
" Description:  Vim plugin that executes shell command and redirects output
"               to a new buffer
" Author:       Alexander Skachko <alexander.skachko@gmail.com>
" Homepage:     https://github.com/lucerion/vim-executor
" Version:      0.2
" Licence:      BSD-3-Clause
" ===========================================================================

func! executor#async#exec(command, selection)
  let s:command = a:command
  let s:result = []
  call s:execute(a:command, a:selection)
endfunc

func! s:execute(command, selection)
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

func! s:out_callback(channel, data)
  call add(s:result, a:data)
endfunc

func! s:exit_callback(job, status)
  call executor#open_result(s:result, s:command)
endfunc
