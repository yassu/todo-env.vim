" environemnt for task
" Version: 0.3.0
" Author:  yassu <mathyassu at gmail.com>
" License: GNU


let s:save_cpo = &cpo
set cpo&vim

function! todo_env#s:is_dummy_line(lstr)
    return a:lstr =~ '^\s*$'
endfunction

function! todo_env#s:is_task_line(lstr)
    " until
endfunction

function! todo_env#s:get_task_lines()    " in same project
    " until
endfunction

" toggle todo whethere done or not done
function! todo_env#ToggleCheckbox()
    let l:line = getline('.')
    if l:line =~ '\-\s\[\s\]'
        " insert finished time
        let l:result = substitute(l:line, '-\s\[\s\]', '- [x]', '')
        if g:todo_env_input_date
            let l:result .= ' [' . strftime(g:todo_env_date_format) . ']'
        endif
        call setline('.', l:result)
    elseif l:line =~ '\-\s\[x\]'
        let l:result = substitute(substitute(l:line, '-\s\[x\]', '- [ ]', ''), '\s\[\d\{4}.\+]$', '', '')
        call setline('.', l:result)
    endif
endfunction

function! todo_env#ToggleCancellation()
    let l:line = getline('.')
    if l:line =~ '\-\s\[\s\]'
        let l:result = substitute(l:line, '-\s\[\s\]', '- [-]', '')
    elseif l:line =~ '\-\s\[\-\]'
        let l:result = substitute(l:line, '-\s\[\-\]', '- [ ]', '')
    endif
    let l:lnum = line('.')
    call setline(l:lnum, l:result)
endfunction



let &cpo = s:save_cpo
unlet s:save_cpo
