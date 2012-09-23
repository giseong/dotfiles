command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set shiftwidth=')

  if l:tabstop > 0
    " do we want expandtab as well?
    let l:expandtab = confirm('set expandtab?', "&Yes\n&No\n&Cancel")
    if l:expandtab == 3
      " abort?
      return
    endif

    let &l:sts = l:tabstop
    let &l:ts  = l:tabstop
    let &l:sw  = l:tabstop

    if l:expandtab == 1
      setlocal expandtab
    else
      setlocal noexpandtab
    endif
  endif

  " show the selected options
  try
    echohl ModeMsg
    echon 'set tabstop='
    echohl Question
    echon &l:ts
    echohl ModeMsg
    echon ' shiftwidth='
    echohl Question
    echon &l:sw
    echohl ModeMsg
    echon ' sts='
    echohl Question
    echon &l:sts . ' ' . (&l:et ? '  ' : 'no')
    echohl ModeMsg
    echon 'expandtab'
  finally
    echohl None
  endtry
endfunction

function! WrapStyle_nowrap()
  set nowrap
  set formatoptions=cqrn1
  set colorcolumn=+1 "highlight column after 'textwidth'
  set list
endfunction

function! WrapStyle_wrap()
  set wrap
  set formatoptions=1
  set colorcolumn=""
  set nolist
endfunction

function! WrapStyle_toggle()
  if (&wrap)
    call WrapStyle_nowrap()
  else
    call WrapStyle_wrap()
  endif
endfunction

augroup wrap_style
  au!
  autocmd FileType *                                call WrapStyle_nowrap()
  autocmd FileType qf,pandoc,tex,man,markdown       call WrapStyle_wrap()
augroup END
