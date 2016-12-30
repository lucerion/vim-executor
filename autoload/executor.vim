" ===========================================================================
" Description:  Vim plugin that execute shell command and redirect output
"               to a new buffer
" Author:       Alexander Skachko <alexander.skachko@gmail.com>
" Homepage:     https://github.com/lucerion/vim-executor
" Version:      0.2.0 (2016-12-20)
" Licence:      BSD-3-Clause
" ===========================================================================

let s:previous_buffer = ''
let s:positions = ['top', 'bottom', 'left', 'right', 'tab']
let s:default_position = 'bottom'

func! executor#exec(start_line, end_line, ...)
  if !exists('g:loaded_buffr')
    call s:show_error('Please, install vim-buffr plugin first') | return
  endif

  let l:command = join(a:000)
  let l:selection = getline(a:start_line, a:end_line)

  if g:executor_exec_async && (v:version >= 800)
    call executor#async#exec(l:command, l:selection)
  else
    call executor#default#exec(l:command, l:selection)
  end
endfunc

func! executor#open_result(result, command)
  let l:buffer_name = s:buffer_name(a:command)
  call s:open_buffer(l:buffer_name)
  call append(0, a:result)
  silent normal! Gddgg
endfunc

func! s:open_buffer(buffer_name)
  let l:buffer_name = a:buffer_name

  if g:executor_reuse_buffer
    if len(s:previous_buffer)
      let l:buffer_name = s:previous_buffer
    end
    let s:previous_buffer = a:buffer_name
  endif

  call buffr#open_or_create_buffer({
    \ 'position': s:buffer_position(),
    \ 'name': l:buffer_name
    \ })
  call s:set_buffer_defaults()

  if g:executor_reuse_buffer
    silent exec 'edit ' . escape(s:previous_buffer, ' ')
  endif
endfunc

func! s:buffer_name(command)
  let l:name = g:executor_buffer_name
  let l:name = substitute(l:name, '{command}', a:command, 'g')
  let l:name = substitute(l:name, '{filename}', expand('%:t'), 'g')
  let l:name = escape(l:name, '|')

  return l:name
endfunc

func! s:buffer_position()
  if index(s:positions, g:executor_position) < 0
    return s:default_position
  else
    return g:executor_position
  endif
endfunc

func! s:set_buffer_defaults()
  setlocal buftype=nofile
  setlocal bufhidden=wipe
  setlocal nobuflisted
  setlocal noswapfile
endfunc

func! s:show_error(message)
  echohl ErrorMsg | echomsg a:message | echohl None
endfunc
