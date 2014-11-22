" environemnt for task
" Version: 0.3.0
" Author:  yassu <mathyassu at gmail.com>
" License: GNU
" This file is forked of

    " Language:     Todo Files
    " Maintainer:   Tom Swartz  <tom@tswartz.net>
    " Last Change:  19 Aug 2014
    " Version:      0.1
    " URL:		http://github.com/tomswartz07/vim-todo

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

setlocal iskeyword+=:
syn case ignore

exec('syn match inProgress /\s*\V' . escape(g:todo_env_unfinished_str, '\') . '/')
exec('syn match itemComplete /\s*\V' . escape(g:todo_env_done_str, '\') . '/')
exec('syn match itemNotDo /\s*\V' . escape(g:todo_env_cancellation_str, '\') . '/')
syn match 	location 	"^[A-Z,a-z]\+\(\s\d\+\)\?,"

highlight def link inProgress Label
highlight def link itemComplete Type
highlight def link itemNotDo Comment
highlight def link location Number

let b:current_syntax = "todo"
