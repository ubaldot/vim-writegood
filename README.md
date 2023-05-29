# vim-writegood
Check your English prose in Vim.

<p align="center">
<img src="/WriteGoodDemo.gif" width="70%" height="70%">
</p>


## Introduction
Vim-writegood check your English prose.<br>

It is nothing but a simple Vim9 wrapper around prose linters.

## Requirements
You must have a prose linter installed. Currently supported linters are
[write-good](https://github.com/btford/write-good) and
[vale](https://vale.sh).  Check their docs for installation and configuration
guidelines.

Oh, and you need Vim9 of course.


## Usage
Vim-writegood has only one command:

```
:WriteGoodToggle
```
which is used to turn on and off the linter.

The diagnostic messages are stored in the quickfix list and displayed in the
command-line.<cr>
You can use all the quickfix list features such as `:cnext,
:cprev, :copen`, etc. to conveniently move around.
See `:h quickfix` for more info.<br>

The quickfix list automatically updates  "on save", i.e.  you must save your
file to refresh the linting otherwise you won't see your problems to
disappear.

>**Warning**
>
> When you change (or come back to a previous) buffer, you have to manually
> re-enable the linting. Don't be fooled if the highlight is still on!
> To fix it, run `:WriteGoodToggle` once or twice, that's all.


## Configuration
There are few parameters that you can tweak:
```
# Default values
g:writegood_compiler = "writegood" # Can be "writegood" or "vale".
g:writegood_options = "" # CLI options to append to write-good call
g:writegood_linehl = "CursorLine"
g:writegood_text = "--"
g:writegood_texthl = ""
```
To figure out the meaning of the latter three parameters, check `:h
sign_define()` and to figure out possible values type `:highlight`.

## Contributing
Feel free to send a PR if have any improvement ideas.

## License
BSD3-Clause.
