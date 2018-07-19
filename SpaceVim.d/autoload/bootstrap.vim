" bootstrap#before {{{
function! bootstrap#before() abort

endfunction
" }}}

" bootstrap#after {{{
function! bootstrap#after() abort

if s:SYSTEM.isWindows
  let g:python3_host_prog = "C:\Python37\python.exe"
else
  let g:python3_host_prog = "/usr/bin/python3"
endif

endfunction
" }}}
