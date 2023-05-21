vim9script

# Sign definition
sign_define('writegood',
    \ {"text": g:writegood_text,
    \ "linehl": g:writegood_linehl,
    \ "textl": g:writegood_texthl })

var tmp = tempname()

def WriteGoodOn()
    # Call writegood
    writefile(getbufline('%', 1, line('$')), tmp)
    defer delete(tmp)
    var text_list = systemlist("write-good " .. g:writegood_options .. tmp)

    # Search error messages and lines
    var delimiter = "------------"
    b:line_numbers = []
    var error_message = ""
    b:error_messages = []
    # TODO The following search can be optimized and robustified
    for ii in range(0, len(text_list) - 1)
        # Check if the line starts with the delimiter
        if text_list[ii][0 : len(delimiter) - 1] ==# delimiter
            b:line_numbers -> add(str2nr(matchstr(text_list[ii - 1],
                        \ 'on line \zs\d\+')))
            error_message = "write-good: " .. matchstr(text_list[ii - 1],
                        \ '^\(.*\)on line \d\+')
                        \ -> substitute('on line \d\+', "", "g")
            b:error_messages -> add(error_message)
        endif
    endfor

    # Place signs.
    for line in b:line_numbers
        sign_place(0, 'writegood_grp', 'writegood', '%', {'lnum': line})
    endfor

    # Set autocmd
    # Existence of #WRITEGOOD_LINT#CursorMoved also imply that the linting is
    # ON.
    if !exists('#WRITEGOOD_LINT#CursorMoved')
        augroup WRITEGOOD_LINT
            autocmd!
            autocmd CursorMoved,CursorHold <buffer>
                \ if index(b:line_numbers, line('.')) != -1
                \ | echo b:error_messages[index(b:line_numbers, line('.'))]
                \ | else
                \ | echo ""
                \ | endif
        augroup END
    endif

    # If user wants to auto update the diagnostics
    if !exists('#WRITEGOOD_AUTOUPDATE#CursorHold') && g:writegood_autoupdate
        execute "setlocal updatetime=" .. g:writegood_updatetime
        augroup WRITEGOOD_AUTOUPDATE
            autocmd!
            autocmd CursorHold <buffer> WriteGoodRefresh()
        augroup END
    endif
enddef

def WriteGoodOff()
    # No need to check if there are any sign, the following works anyways
    # (In the worst case it returns -1).
    sign_unplace('writegood_grp', {'buffer': '%'})

    if exists('#WRITEGOOD_LINT#CursorMoved')
        augroup WRITEGOOD_LINT
            autocmd!
        augroup END
    endif
    if exists('#WRITEGOOD_AUTOUPDATE#CursorHold')
        augroup WRITEGOOD_AUTOUPDATE
            autocmd!
        augroup END
    endif
enddef

export def WriteGoodToggle()
    # Existence of #WRITEGOOD_LINT#CursorMoved also imply that the linting is
    # ON.
    if exists('#WRITEGOOD_LINT#CursorMoved')
        WriteGoodOff()
    else
        WriteGoodOn()
    endif
enddef

export def WriteGoodRefresh()
    WriteGoodOff()
    WriteGoodOn()
enddef
