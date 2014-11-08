" environemnt for task
" Version: 0.3.0
" Author:  yassu <mathyassu at gmail.com>
" License: GNU

if exists('g:loaded_todo_env')
    finish
endif
let g:loaded_todo_env = 1


if !exists('g:todo_env_date_format')
    let g:todo_env_date_format = "%Y/%m/%d (%a) %H:%M"
endif

let s:save_cpo = &cpo
set cpo&vim

" fold method
setlocal foldmethod=expr foldexpr=MkdCheckboxFold(v:lnum) foldtext=MkdCheckboxFoldText()

function! MkdCheckboxFold(lnum)
    let line = getline(a:lnum)
    let next = getline(a:lnum + 1)
    if MkdIsNoIndentCheckboxLine(line) && MkdHasIndentLine(next)
        return 1
    elseif (MkdIsNoIndentCheckboxLine(next) || next =~ '^$') && !MkdHasIndentLine(next)
        return '<1'
    endif
    return '='
endfunction
function! MkdIsNoIndentCheckboxLine(line)
    return a:line =~ '^- \[[ x]\] '
endfunction
function! MkdHasIndentLine(line)
    return a:line =~ '^[[:blank:]]\+'
endfunction
function! MkdCheckboxFoldText()
    return getline(v:foldstart) . ' (' . (v:foldend - v:foldstart) . ' lines) '
endfunction



set foldmethod=marker

" toggle todo whethere done or not done
function! ToggleCheckbox()
  let l:line = getline('.')
  if l:line =~ '\-\s\[\s\]'
    " insert finished time
    let l:result = substitute(l:line, '-\s\[\s\]', '- [x]', '') . ' [' . strftime(g:todo_env_date_format) . ']'
    call setline('.', l:result)
  elseif l:line =~ '\-\s\[x\]'
    let l:result = substitute(substitute(l:line, '-\s\[x\]', '- [ ]', ''), '\s\[\d\{4}.\+]$', '', '')
    call setline('.', l:result)
  end
endfunction

" mappings
imap <c-l> - [ ]
nnoremap <buffer> tt :call ToggleCheckbox()<cr>

let &cpo = s:save_cpo
unlet s:save_cpo
