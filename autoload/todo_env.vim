" environemnt for task
" Version: 0.5.0
" Author:  yassu <mathyassu at gmail.com>
" License: GNU


let s:save_cpo = &cpo "{{{
set cpo&vim
" }}}

" util functions {{{
function! todo_env#s:delete_head_spaces(lstr)
    " return [content, spaces]
    let l:M = matchlist(a:lstr, '^\(\s*\)\(\S.*\)$')
    if len(l:M)
        return [l:M[2], l:M[1]]
    else
        return []
    endif
endfunction

function! todo_env#s:startswith(text, start_s)
    return a:text[:len(a:start_s) - 1] == a:start_s
endfunction

function! todo_env#s:endswith(text, end_s)
    return a:text[-len(a:end_s):] == a:end_s
endfunction

function! todo_env#s:replace_head(text, _from, _to)
    if !todo_env#s:startswith(a:text, a:_from)
        return text
    endif
    return a:_to . a:text[len(a:_from):]
endfunction

function! todo_env#s:delete_date_part(line)
    return substitute(a:line, '\s*\[[^]]\+]$', '', '')
endfunction
" }}}
"
" functios about status of task {{{
function! todo_env#s:is_not_done_task(lstr)
    return todo_env#s:startswith(todo_env#s:delete_head_spaces(a:lstr)[0], g:todo_env_not_done_str)
endfunction
" }}}

" jump to next/previous task {{{
function! todo_env#s:get_next_lines()
    let l:lnum = line('.')
    return getbufline('%', l:lnum, 1000000000)
endfunction

function! todo_env#s:jump_line(lnum)
    let l:lstr = getline(a:lnum)
    let l:col = len(todo_env#s:delete_head_spaces(l:lstr)[1]) + 1
    call cursor(a:lnum, l:col)
endfunction

function! todo_env#Jump_to_next_task()
    let l:lines = todo_env#s:get_next_lines()[1:]
    let l:lnum  = line('.') + 1

    while l:lines != []
        if todo_env#s:is_not_done_task(l:lines[0])
            call todo_env#s:jump_line(lnum)
            echo l:lnum
            return 1
        endif
        let l:lines = l:lines[1:]
        let l:lnum += 1
    endwhile
    return 0
endfunction
" }}}

" toggle functions {{{
function! todo_env#ToggleCheckbox() "{{{
    let l:line = getline('.')
    if todo_env#s:delete_head_spaces(l:line) == []
        echomsg "This line doesn't mean a task."
        return
    endif
    let [l:line_without_spaces, l:spaces] = todo_env#s:delete_head_spaces(l:line)
    if todo_env#s:startswith(l:line_without_spaces, g:todo_env_not_done_str)
        " insert finished time
        let l:result = todo_env#s:replace_head(
            \ l:line_without_spaces, g:todo_env_not_done_str, g:todo_env_done_str)
        if g:todo_env_input_date
            let l:result .= ' [' . strftime(g:todo_env_date_format) . ']'
        endif
    elseif todo_env#s:startswith(l:line_without_spaces, g:todo_env_done_str)
        let l:result = todo_env#s:replace_head(
                    \ l:line_without_spaces, g:todo_env_done_str, g:todo_env_not_done_str)
        let l:result = todo_env#s:delete_date_part(l:result)
    else
        echomsg "This line doesn't mean a task."
        return
    endif
    call setline('.', l:spaces . l:result)
endfunction
" }}}

function! todo_env#ToggleCancellation() "{{{
    let l:line = getline('.')
    if todo_env#s:delete_head_spaces(l:line) == []
        echomsg "This line doesn't mean task."
        return
    endif

    let [l:line_without_spaces, l:spaces] = todo_env#s:delete_head_spaces(l:line)
    if todo_env#s:startswith(l:line_without_spaces, g:todo_env_not_done_str)
        let l:result = todo_env#s:replace_head(
                    \ l:line_without_spaces, g:todo_env_not_done_str, g:todo_env_cancellation_str)
    elseif todo_env#s:startswith(l:line_without_spaces, g:todo_env_cancellation_str)
        let l:result = todo_env#s:replace_head(
                    \ l:line_without_spaces, g:todo_env_cancellation_str, g:todo_env_not_done_str)
    else
        echomsg "This line doesn't mean empty or cancelled task."
        return
    endif
    let l:lnum = line('.')
    call setline(l:lnum, l:spaces . l:result)
endfunction
" }}}
" }}}

let &cpo = s:save_cpo "{{{
unlet s:save_cpo
" }}}
