" bootstrap_before {{{
function! myspacevim#before() abort

    " let base16colorspace=256

endfunction
" }}}

" bootstrap_after {{{
function! myspacevim#after() abort

    let s:SYSTEM = SpaceVim#api#import('system')
    if s:SYSTEM.isWindows
        let g:python3_host_prog = "C:\Python37\python.exe"
    else
        let g:python3_host_prog = "/usr/bin/python3"
    endif

endfunction
" }}}
