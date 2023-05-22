vim9script noclear

# Naively check your English prose.
# Maintainer:	Ubaldo Tiberi
# GetLatestVimScripts: 6073 1 :AutoInstall: writegood.vim
# License: Vim license

if !has('vim9script') ||  v:version < 900
  # Needs Vim version 9.0 and above
  echo "You need at least Vim 9.0"
  finish
endif

if exists('g:writegood_loaded')
    finish
endif
g:writegood_loaded = true

# --------------------------
# User settings
# --------------------------
if !exists('g:writegood_options')
    g:writegood_options = ""
endif

if !exists('g:writegood_compiler')
    g:writegood_compiler = "vale"
endif

if !exists('g:writegood_linehl')
     g:writegood_linehl = "CursorLine"
endif

if !exists('g:writegood_text')
     g:writegood_text = "--"
endif

if !exists('g:writegood_texthl')
     g:writegood_texthl = ""
endif

# --------------------------
# Commands
# --------------------------

import autoload "../lib/wgfunctions.vim"

if !exists(":WritegoodToggle")
  command WritegoodToggle call <SID>wgfunctions.Toggle()
endif

if !exists(":WritegoodRefresh")
  command WritegoodRefresh call <SID>wgfunctions.Refresh()
endif

augroup WRITEGOOD_UPDATE
    autocmd!
    autocmd QuickFixCmdPre [^l]* wgfunctions.ClearAll()
    autocmd QuickFixCmdPost [^l]* wgfunctions.HighlightOn()
augroup END
