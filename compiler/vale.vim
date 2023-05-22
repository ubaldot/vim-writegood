vim9script

if exists("g:current_compiler")
  finish
endif
g:current_compiler = "vale"


CompilerSet makeprg=vale\ --output\ line\ %
# CompilerSet makeprg=vale\ --output\ line
CompilerSet errorformat=%f:%l:%c:%m
