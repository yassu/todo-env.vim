" environemnt for task
" Version: 0.6.0
" Author:  yassu <mathyassu at gmail.com>
" License: GNU


if !exists('g:todo_env_date_format')
    let g:todo_env_date_format = "%Y/%m/%d (%a) %H:%M"
endif
if !exists('g:todo_env_input_date')
    let g:todo_env_input_date = 1
endif
if !exists('g:todo_env_unfinished_str')
    let g:todo_env_unfinished_str = '- [ ] '
endif
if !exists('g:todo_env_done_str')
    let g:todo_env_done_str = '- [x] '
endif
if !exists('g:todo_env_cancellation_str')
    let g:todo_env_cancellation_str = '- [-] '
endif
if !exists('g:todo_env_use_comment')
  let g:todo_env_use_comment = 1
endif
if g:todo_env_use_comment && !exists('g:todo_env_comment_char')
    let g:todo_env_comment_char = '#'
endif

let s:save_cpo = &cpo
set cpo&vim

" mappings
if !exists('g:todo_env_default_keymaps') ||
            \(exists('g:todo_env_default_keymaps') && g:todo_env_default_keymaps)
    imap <buffer><c-l> <c-R>=g:todo_env_unfinished_str<cr>
    nnoremap <silent><buffer>tt :call todo_env#ToggleCheckbox()<cr>
    nnoremap <silent><buffer>cc :call todo_env#ToggleCancellation()<cr>
    nnoremap <silent><buffer>tk :call todo_env#Jump_to_previous_task()<cr>
    nnoremap <silent><buffer>tj :call todo_env#Jump_to_next_task()<cr>
endif

let &cpo = s:save_cpo
unlet s:save_cpo
