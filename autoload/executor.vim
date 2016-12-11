" ===========================================================================
" Description:  Vim plugin that executes shell command with a buffer contents
"               or selection and redirects output to a new buffer
" Author:       Alexander Skachko <alexander.skachko@gmail.com>
" Homepage:     https://github.com/lucerion/vim-executor
" Version:      0.1
" Licence:      BSD-3-Clause
" ===========================================================================

let s:previous_buffer = ''

func! executor#exec(start_line, end_line, count, ...)
  if !exists('g:loaded_buffr')
    call s:show_error('Please, install vim-buffr plugin first') | return
  endif

  call s:execute(a:start_line, a:end_line, a:count, a:000)
endfunc

func! s:execute(start_line, end_line, count, command)
  let l:selection = s:selection(a:start_line, a:end_line)
  let l:command = s:command(a:command)
  let l:result = s:result(l:command, l:selection, a:count)
  let l:buffer_name = s:buffer_name(l:command)

  call s:open_result(l:result, l:buffer_name)
endfunc

func! s:selection(start_line, end_line)
  return getline(a:start_line, a:end_line)
endfunc

func! s:command(command)
  let l:command = join(a:command)
  if len(substitute(l:command, ' ', '', 'g'))
    return l:command
  end

  return g:executor_default_command
endfunc

func! s:result(command, selection, count)
  if len(a:selection) == 1
    let l:command = a:command . ' ' . a:selection[0]
    return system(l:command)
  endif

  if a:count
    let l:selection = join(a:selection, "\n") . "\n"
    return system(a:command, l:selection)
  endif

  return system(a:command)
endfunc

func! s:open_result(result, buffer_name)
  let l:buffer_name = a:buffer_name

  if g:executor_reuse_buffer
    if len(s:previous_buffer)
      let l:buffer_name = s:previous_buffer
    end
    let s:previous_buffer = a:buffer_name
  endif

  call buffr#open_or_create_buffer({
    \ 'position': g:executor_position,
    \ 'name': l:buffer_name
    \ })
  call s:set_buffer_defaults()

  if g:executor_reuse_buffer
    silent exec 'edit ' . escape(s:previous_buffer, ' ')
  endif

  call append(0, split(a:result, "\n"))
  silent exec 'normal! Gdd'
endfunc

func! s:buffer_name(command)
  let l:buffer_name = g:executor_buffer_name
  let l:buffer_name = substitute(l:buffer_name, '{command}', a:command, 'g')
  let l:buffer_name = substitute(l:buffer_name, '{filename}', expand('%:t'), 'g')

  return escape(l:buffer_name, '|')
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
