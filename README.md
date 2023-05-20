# vim-writegood
Check your English prose in Vim.

<p align="center">
<img src="/WriteGoodDemo.gif" width="60%" height="60%">
</p>

## Introduction
Vim-writegood naively check your English prose.

It is nothing but a simple wrapper around
[write-good](https://github.com/btford/write-good) written in Vim9.

## Requirements
You must have [write-good](https://github.com/btford/write-good) installed and
you need Vim9.

## Usage
Vim-writegood has one command:

```
:WriteGoodToggle
```
messages are displayed in the command-line.
The diagnostic messages are not automatically updated.
You must run `:WriteGoodToggle` twice to refresh.

## Configuration
There are few parameters that you can tweak:
```
# Default values
g:writegood_options = "" # CLI parameters to pass to writegood
g:writegood_linehl = "CursorLine"
g:writegood_text = "--"
g:writegood_texthl = "IncSearch"
```
To figure out the meaning of the latter three parameters, check `:h
sign_define()` and to figure out possible values type `:highlight`.

## Contributing
The code can be heavily optimized and robustified, so feel free to send a PR
if have improvement ideas.

## License
Same as Vim.
