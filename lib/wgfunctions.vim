vim9script

# Sign definition
sign_define('writegood',
    \ {"text": g:writegood_text,
    \ "linehl": g:writegood_linehl,
    \ "textl": g:writegood_texthl })

export def Refresh()
    if g:writegood_compiler ==# "writegood"
        compiler writegood
    else
        compiler vale
    endif

    # Generate QuickFixList
    # writefile(getbufline('%', 1, line('$')), tmp)
    # defer delete(tmp)
    # silent exe $"make {tmp}"
    silent make
enddef

# This is triggered by the event QuickFixCmdPost
export def HighlightOn()
    var qflist = getqflist()

    for entry in qflist
        add(b:line_numbers, entry.lnum)
        add(b:error_messages, entry.text)
        sign_place(0, 'writegood_grp', 'writegood', '%', {'lnum': entry.lnum})
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
enddef

# This is triggered by the event QuickFixCmdPre
# OR by toggle when you want to shutoff everything
export def ClearAll()
    # This is always the first from a user perspective.
    # No need to check if there are any sign, the following works anyways
    # (In the worst case it returns -1).
    sign_unplace('writegood_grp', {'buffer': '%'})
    setqflist([])
    b:line_numbers = []
    b:error_messages = []

    if exists('#WRITEGOOD_LINT#CursorMoved')
        augroup WRITEGOOD_LINT
            autocmd!
        augroup END
    endif
enddef

export def Toggle()
    # Existence of #WRITEGOOD_LINT#CursorMoved also imply that the linting is
    # ON.
    if exists('#WRITEGOOD_LINT#CursorMoved')
        ClearAll()
    else
        Refresh()
    endif
enddef
