" environemnt for task
" Version: 0.3.0
" Author:  yassu <mathyassu at gmail.com>
" License: GNU


if !exists('g:todo_env_date_format')
    let g:todo_env_date_format = "%Y/%m/%d (%a) %H:%M"
endif
if !exists('g:todo_env_input_date')
    let g:todo_env_input_date = 1
endif
if !exists('g:todo_env_fold_child')
    let g:todo_env_fold_child = 1
endif

let s:save_cpo = &cpo
set cpo&vim

" fold method
if g:todo_env_fold_child
    setlocal foldmethod=expr foldexpr=s:MkdCheckboxFold(v:lnum) foldtext=s:MkdCheckboxFoldText()
else
    setlocal foldmethod=expr
endif

function! s:MkdCheckboxFold(lnum)
    let line = getline(a:lnum)
    let next = getline(a:lnum + 1)
    if s:MkdIsNoIndentCheckboxLine(line) && s:MkdHasIndentLine(next)
        return 1
    elseif (s:MkdIsNoIndentCheckboxLine(next) || next =~ '^$') && !s:MkdHasIndentLine(next)
        return '<1'
    endif
    return '='
endfunction
function! s:MkdIsNoIndentCheckboxLine(line)
    return a:line =~ '^- \[[ x]\] '
endfunction
function! s:MkdHasIndentLine(line)
    return a:line =~ '^[[:blank:]]\+'
endfunction
function! s:MkdCheckboxFoldText()
    return getline(v:foldstart) . ' (' . (v:foldend - v:foldstart) . ' lines) '
endfunction


" toggle todo whethere done or not done
function! Todoenv_ToggleCheckbox()
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
  end
endfunction

function! Todoenv_ToggleCancellation()
    let l:line = getline('.')
    if l:line =~ '\-\s\[\s\]'
        let l:result = substitute(l:line, '-\s\[\s\]', '- [-]', '')
    elseif l:line =~ '\-\s\[\-\]'
        let l:result = substitute(l:line, '-\s\[\-\]', '- [ ]', '')
    endif
    let l:lnum = line('.')
    call setline(l:lnum, l:result)
endfunction

" mappings
if !exists('g:todo_env_default_keymaps')|| (exists('g:todo_env_default_keymaps') && g:todo_env_default_keymaps)
    imap <buffer><c-l> - [ ]
    nnoremap <silent><buffer>tt :call Todoenv_ToggleCheckbox()<cr>
    nnoremap <silent><buffer>cc :call Todoenv_ToggleCancellation()<cr>
endif

let &cpo = s:save_cpo
unlet s:save_cpo
