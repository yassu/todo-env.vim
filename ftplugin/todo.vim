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
if !exists('g:todo_env_not_done_str')
    let g:todo_env_not_done_str = '- [ ] '
endif
if !exists('g:todo_env_done_str')
    let g:todo_env_done_str = '- [x] '
endif
if !exists('g:todo_env_cancellation_str')
    let g:todo_env_cancellation_str = '- [-] '
endif
if !exists('g:todo_env_fold_child')
    let g:todo_env_fold_child = 1
endif

let s:save_cpo = &cpo
set cpo&vim

" mappings
if !exists('g:todo_env_default_keymaps') ||
            \(exists('g:todo_env_default_keymaps') && g:todo_env_default_keymaps)
    imap <buffer><c-l> <c-R>=g:todo_env_not_done_str<cr>
    nnoremap <silent><buffer>tt :call todo_env#ToggleCheckbox()<cr>
    nnoremap <silent><buffer>cc :call todo_env#ToggleCancellation()<cr>
endif

let &cpo = s:save_cpo
unlet s:save_cpo
