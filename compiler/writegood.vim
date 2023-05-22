vim9script

if exists("g:current_compiler")
  finish
endif
g:current_compiler = "writegood"


CompilerSet makeprg=write\-good\ --parse\ %
# CompilerSet makeprg=write\-good\ --parse
CompilerSet errorformat=%f:%l:%c:%m
