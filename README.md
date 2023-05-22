# vim-writegood
Check your English prose in Vim.

<p align="center">
<img src="/WriteGoodDemo.gif" width="70%" height="70%">
</p>


## Introduction
Vim-writegood check your English prose.<br>

It is nothing but a simple Vim9 wrapper around
[write-good](https://github.com/btford/write-good) and
[vale](https://vale.sh). You choose which one you want to use.


## Requirements
You must have [write-good](https://github.com/btford/write-good) and/or
[vale](https://vale.sh) installed.  Note that [vale](https://vale.sh)
need some configuration work. Check the docs for more info.

Oh, and you need Vim9 of course.


## Usage
First, you need to turn on the linter with following command:

```
:WriteGoodToggle
```
which represents the only command in vim-writegood.<br>

The diagnostic messages are displayed in the command-line and are stored in
the quickfix list.<br>
This means that you can use all the quickfix list features like jumping to the
next message, to the previous, etc.
See `:h quickfix` for more info.<br>

The quickfix list is updated automatically "on save", i.e.  you must save your
file to refresh the linting.

>**Warning**
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
Same as Vim.
