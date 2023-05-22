vim9script

# Sign definition
sign_define('writegood',
    \ {"text": g:writegood_text,
    \ "linehl": g:writegood_linehl,
    \ "textl": g:writegood_texthl })


def TurnOn()
    if g:writegood_compiler ==# "writegood"
        compiler writegood
    else
        compiler vale
    endif

    # Generate QuickFixList
    # ------------------------------------
    # TODO Is there any mechanism to work "live" with the buffer?
    # This could be an idea but it won't work:
    # var tmp = tempname()
    # writefile(getbufline('%', 1, line('$')), tmp)
    # defer delete(tmp)
    # silent exe $"make! {g:writegood_options} {tmp}"
    # The problems are:
    #   1) The file in the quickfixlist becomes tmp
    #   2) tmp is opened and % is now tmp.
    #
    # A solution could be:
    #   1) var buf_name = expand('%:t') # before make on tmp
    #   2) setqflist filename = buf_name # after make
    #   3) bwipeout bunfnr('%') # The tmp is displayed
    #
    #   But this sucks. I think that updating after you save (as you do when
    #   you compile: save-make iteration and the number of problems -
    #   hopefully - decreases) is not a bad idea.
    # ------------------------------------
    #
    silent exe $"make! {g:writegood_options}"


    b:line_numbers = []
    b:error_messages = []
    var qflist = getqflist()
    for entry in qflist
        # entry.file = buf_name, in connection to the TODO discussion above
        add(b:line_numbers, entry.lnum)
        add(b:error_messages, entry.text)
        sign_place(0, 'writegood_grp', 'writegood', '%', {'lnum': entry.lnum})
    endfor

    b:writegood_is_on = true

    # Set autocmd for showing the error message
    # Existence of #WRITEGOOD_LINT#CursorMoved also imply that the linting is
    # ON.
    augroup WRITEGOOD_LINT
        autocmd!
        autocmd CursorMoved,CursorHold <buffer> DisplayMessage()
    augroup END

    # Save for updating the QuickFixList.
    augroup WRITEGOOD_REFRESH_ON_SAVE
        autocmd!
        autocmd BufWritePost <buffer> TurnOff() | TurnOn()
    augroup END
enddef

def DisplayMessage()
    var idx = index(b:line_numbers, line('.'))

    if idx != -1
        echo b:error_messages[idx]
    else
        echo ""
    endif
enddef

# This is triggered by the event QuickFixCmdPre
# OR by toggle when you want to shutoff everything
def TurnOff()
    # No need to check if there are any sign, the following works anyways
    # (In the worst case it returns -1).
    sign_unplace('writegood_grp', {'buffer': '%'})
    setqflist([])

    b:line_numbers = []
    b:error_messages = []
    b:writegood_is_on = false

    augroup WRITEGOOD_LINT
        autocmd!
    augroup END

    augroup WRITEGOOD_REFRESH_ON_SAVE
        autocmd!
    augroup END
enddef

export def Toggle()
    # Init
    if !exists("b:writegood_is_on")
        b:writegood_is_on = false
    endif

    # Execution
    if b:writegood_is_on
        TurnOff()
    else
        TurnOn()
    endif
enddef
