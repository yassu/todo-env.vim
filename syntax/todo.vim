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
syntax case ignore

exec('syntax match inProgress /\s*\V' . escape(g:todo_env_unfinished_str, '\') . '/')
exec('syntax match itemComplete /\s*\V' . escape(g:todo_env_done_str, '\') . '/')
exec('syntax match itemNotDone /\s*\V' . escape(g:todo_env_cancellation_str, '\') . '/')
syntax match 	location 	"^[A-Z,a-z]\+\(\s\d\+\)\?,"

highlight def link inProgress Label
highlight def link itemComplete Type
highlight def link itemNotDone Comment
highlight def link location Number

if g:todo_env_use_comment
  " syntax match itemComment /^\s*#.*/
  exec('syntax match itemComment /^\s*\V' . escape(g:todo_env_comment_char, '\'). '/')
  highlight def link itemComment Comment
endif

let b:current_syntax = "todo"
