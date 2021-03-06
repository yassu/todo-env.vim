" environemnt for task
" Version: 0.6.0
" Author:  yassu <mathyassu at gmail.com>
" License: GNU


let s:save_cpo = &cpo "{{{
set cpo&vim
" }}}

" util functions {{{
function! s:delete_head_spaces(lstr) "{{{
    " return [content, spaces]
    let l:M = matchlist(a:lstr, '^\(\s*\)\(\S.*\)$')
    if len(l:M)
        return [l:M[2], l:M[1]]
    else
        return []
    endif
endfunction
" }}}

function! s:startswith(text, start_s) "{{{
    return len(a:text) >= len(a:start_s) && a:text[:len(a:start_s) - 1] == a:start_s
endfunction
" }}}

function! s:endswith(text, end_s) "{{{
    return a:text[-len(a:end_s):] == a:end_s
endfunction
" }}}

function! s:replace_head(text, _from, _to) "{{{
    if !s:startswith(a:text, a:_from)
        return text
    endif
    return a:_to . a:text[len(a:_from):]
endfunction
" }}}

function! s:delete_date_part(line) "{{{
    return substitute(a:line, '\s*\[[^]]\+]$', '', '')
endfunction
" }}}
" }}}

" functios about status of task {{{
function! s:is_unfinished_task(lstr) "{{{
    if s:delete_head_spaces(a:lstr) == []
        return 0
    endif

    return s:startswith(s:delete_head_spaces(a:lstr)[0], g:todo_env_unfinished_str)
endfunction
" }}}
" }}}

" jump to next/previous task {{{
function! s:get_next_lines() "{{{
    let l:lnum = line('.')
    return getbufline('%', l:lnum, 100000000)
endfunction
" }}}

function! s:get_previous_lines() "{{{
    let l:lnum = line('.')
    return getbufline('%', 1, l:lnum - 1)
endfunction
" }}}

function! s:jump_line(lnum) "{{{
    let l:lstr = getline(a:lnum)
    let l:col = len(s:delete_head_spaces(l:lstr)[1]) + 1
    call cursor(a:lnum, l:col)
endfunction
" }}}

function! todo_env#Jump_to_next_task() "{{{
    let l:lines = s:get_next_lines()[1:]
    let l:lnum  = line('.') + 1

    while l:lines != []
        if s:is_unfinished_task(l:lines[0])
            call s:jump_line(l:lnum)
            return 1
        endif
        let l:lines = l:lines[1:]
        let l:lnum += 1
    endwhile

    return 0
endfunction
" }}}

function! todo_env#Jump_to_previous_task() "{{{
    let l:lnum  = line('.') - 1
    for i in reverse(range(1, l:lnum))
        let l:line = getline(i)
        if s:is_unfinished_task(l:line)
            call s:jump_line(i)
            return 1
        endif
    endfor

    return 0
endfunction
" }}}
" }}}

" toggle functions {{{
function! todo_env#ToggleCheckbox() "{{{
    let l:line = getline('.')
    if s:delete_head_spaces(l:line) == []
        echomsg "This line doesn't mean a task."
        return
    endif
    let [l:line_without_spaces, l:spaces] = s:delete_head_spaces(l:line)
    if s:startswith(l:line_without_spaces, g:todo_env_unfinished_str)
        " insert finished time
        let l:result = s:replace_head(
            \ l:line_without_spaces, g:todo_env_unfinished_str, g:todo_env_done_str)
        if g:todo_env_input_date
            let l:result .= ' [' . strftime(g:todo_env_date_format) . ']'
        endif
    elseif s:startswith(l:line_without_spaces, g:todo_env_done_str)
        let l:result = s:replace_head(
                    \ l:line_without_spaces, g:todo_env_done_str, g:todo_env_unfinished_str)
        let l:result = s:delete_date_part(l:result)
    else
        echomsg "This line doesn't mean a task."
        return
    endif
    call setline('.', l:spaces . l:result)
endfunction
" }}}

function! todo_env#ToggleCancellation() "{{{
    let l:line = getline('.')
    if s:delete_head_spaces(l:line) == []
        echomsg "This line doesn't mean task."
        return
    endif

    let [l:line_without_spaces, l:spaces] = s:delete_head_spaces(l:line)
    if s:startswith(l:line_without_spaces, g:todo_env_unfinished_str)
        let l:result = s:replace_head(
                    \ l:line_without_spaces, g:todo_env_unfinished_str, g:todo_env_cancellation_str)
    elseif s:startswith(l:line_without_spaces, g:todo_env_cancellation_str)
        let l:result = s:replace_head(
                    \ l:line_without_spaces, g:todo_env_cancellation_str, g:todo_env_unfinished_str)
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
