vim9script

var highlight_is_on = false

def WriteGoodOn()
    # Call writegood
    var out = systemlist("write-good " .. g:writegood_options .. expand('%'))

    # Search error messages and lines
    var delimiter = "------------"
    var line_numbers = []
    var error_message = ""
    var error_messages = []
    # TODO The following search can be optimized and robustified
    for ii in range(0, len(out) - 1)
        # Check if the line starts with the delimiter
        if out[ii][0 : len(delimiter) - 1] ==# delimiter
            line_numbers -> add(str2nr(matchstr(out[ii - 1],
                        \ 'on line \zs\d\+')))
            error_message = "write-good: " .. matchstr(out[ii - 1],
                        \ '^\(.*\)on line \d\+')
                        \ -> substitute('on line \d\+', "", "g")
            error_messages -> add(error_message)
        endif
    endfor

    # Set autocmd
    setbufvar('%', 'line_numbers', line_numbers)
    setbufvar('%', 'error_messages', error_messages)
    if !exists('#WRITE_GOOD_LINT#CursorMoved')
        augroup WRITE_GOOD_LINT
            autocmd!
            autocmd CursorMoved <buffer>
                \ if index(b:line_numbers, line('.')) != -1
                \ | echo b:error_messages[index(b:line_numbers, line('.'))]
                \ | else
                \ | echo ""
                \ | endif
        augroup END
    endif

    # Set sign. TODO Can that be moved out?
    sign_define('writegood',
        \ {"text": g:writegood_text,
        \ "linehl": g:writegood_linehl,
        \ "textl": g:writegood_texthl })
    for line in line_numbers
        sign_place(0, 'writegood_grp', 'writegood', '%', {'lnum': line})
    endfor
    highlight_is_on = true
enddef

def WriteGoodOff()
    # No need to check, it works anyways.
    sign_unplace('writegood_grp', {'buffer': '%'})

    if exists('#WRITE_GOOD_LINT#CursorMoved')
        augroup WRITE_GOOD_LINT
            autocmd!
        augroup END
    endif
    highlight_is_on = false
enddef

def WriteGoodToggle()
    if highlight_is_on
        WriteGoodOff()
    else
        WriteGoodOn()
    endif
enddef
