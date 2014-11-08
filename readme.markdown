# todo-env.vim
Version: 0.3

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

This plugin will automatically apply the syntax highlighting to files named `*.todo`.

## functions
* `ToggleCheckbox()`: changing status of Todo.
    e.g. change from `[ ]` to `[x]` and for `[x]` to `[ ]`.
* `ToggleCancellation`: changing status of Todo: empty -> cancel

## Key mapping
* `<c-l>` in insert mode: input `- [ ]`.
* `tt`: call `ToggleCheckbox` function
* `<c-d>` call `ToggleDeleteLine()` function

## Customizing

* `todo_env_input_date`: whether input date or not when done task
* `todo_env_date_format`: date-format for using when done task

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
