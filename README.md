# vim-writegood
Check your English prose in Vim.

<p align="center">
<img src="/WriteGoodDemo.gif" width="60%" height="60%">
</p>


## Introduction
Vim-writegood naively check your English prose.
It is nothing but a simple Vim9 wrapper around
[write-good](https://github.com/btford/write-good).


## Requirements
You must have [write-good](https://github.com/btford/write-good) installed and
you need Vim9.


## Usage
Vim-writegood has two commands:

```
:WriteGoodToggle
:WriteGoodRefresh
```
diagnostic messages are displayed in the command-line.<br>
You can let the diagnostics to automatically update by setting the variables
`g:writegood_autoupdate` and `g:writegood_updatetime`.

However, if Vim becomes slow, you may want to set `g:writegood_autoupdate` to
`false` and refresh the diagnostics manually through `:WriteGoodRefresh`.

## Configuration
There are few parameters that you can tweak:
```
# Default values
g:writegood_options = "" # CLI parameters to pass to write-good
g:writegood_autoupdate = true
g:writegood_updatetime = 1000 # [ms]
g:writegood_linehl = "CursorLine"
g:writegood_text = "--"
g:writegood_texthl = ""
```
To figure out the meaning of the latter three parameters, check `:h
sign_define()` and to figure out possible values type `:highlight`.

## Contributing
There is room for optimization and robustification, feel free to send a PR
if have any improvement ideas.

## License
Same as Vim.
