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

if !exists('g:writegood_linehl')
     g:writegood_linehl = "CursorLine"
endif

if !exists('g:writegood_text')
     g:writegood_text = "--"
endif

if !exists('g:writegood_texthl')
     g:writegood_texthl = ""
endif

if !exists('g:writegood_updatetime')
    g:writegood_updatetime = 1000 # [ms]
endif

if !exists('g:writegood_autoupdate')
    g:writegood_autoupdate = true
endif

# --------------------------
# Commands
# --------------------------

import autoload "../lib/wgfunctions.vim"

if !exists(":WritegoodToggle")
  command WritegoodToggle <SID>wgfunctions.WriteGoodToggle()
endif

if !exists(":WritegoodRefresh")
  command WritegoodRefresh <SID>wgfunctions.WriteGoodRefresh()
endif
