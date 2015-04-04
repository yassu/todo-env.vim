# todo-env.vim
Version: 0.6

to-do lists environment

## Syntax
This syntax highlighting depends on very simple markdown-like checklists.

```
Location 1, Person 1
- [ ] Item 1
- [ ] Item 2
- [x] Completed Item
Location 2, Person 2
- [x] Completed Item
- [ ] Item 1
- [x] Completed Item
```

![todo-env-01](http://gyazo.com/b6cf2e883ed94f3ff833842b3f9e5103.png)

This plugin will automatically apply the syntax highlighting to files named `*.todo`.

## functions
* `todo_env#Todo_ToggleCheckbox()`: changing status of Todo.
    e.g. change from `[ ]` to `[x]` and for `[x]` to `[ ]`, when default setting.
* `todo_env#ToggleCancellation`: changing status of Todo: empty -> cancel
* `todo_env#Jump_to_next_task()`: move to next task, not finished
* `todo_env#Jump_to_previous_task`: move to previous task, not finished

## Key mapping
Following keymaps will not be used if `todo_env_default_keymaps` is equal to 0.
* `<c-l>` in insert mode: input `- [ ]`.
* `tt`: call `todo_env#ToggleCheckbox` function
* `<c-c>` call `todo_env#ToggleDeleteLine()` function
* `tj`: call `todo_env#Jump_to_next_task()` function
* `tk`: call `todo_env#Jump_to_previous_task` function

## Customizing

* `todo_env_unfinished_str`: string for not done task
* `todo_env_done_str`:    string for done task
* `todo_env_cancellation_str`: string for cancelled task
* `todo_env_input_date`: whether input date or not when done task
* `todo_env_date_format`: date-format for using when done task
* `todo_env_default_keymaps`: whether use default keymaps or not
* `todo_env_use_comment`: If this variable is 0, we cannot use comment.
                          Else, we can use comment.
                          Expression of comment is `^\s*#`, where `#` is
                          `todo_env_comment_char`
* `todo_env_comment_char`: This string is used for preffix of comment syntax.

For Example,
```
let todo_env_unfinished_str = "\U2602  "
let todo_env_done_str = "\U2600  "
let todo_env_cancellation_str = "\Us601  "
let todo_env_input_date = 1
```
then you obtain following syntax:

![todo-env-02](http://gyazo.com/09baefb87ad59a262f55ff9c84f62b9e.png)

## Installation
Copy the included folders to your $VIM folder.

For per-user basis, this is typically `~/.vim/`

For system-wide, this is typically `/usr/share/vim/vimfiles/`

## License

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
    or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
    for more details.
