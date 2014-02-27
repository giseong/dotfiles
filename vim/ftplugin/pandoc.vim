set com=s1:/*,mb:*,ex:*/,://,b:#.,:%,:XCOMM,n:>,b:-
setlocal equalprg=pandoc\ -t\ markdown\ --standalone\ --normalize\ --atx-headers\ --no-wrap
"setlocal equalprg=""
nnoremap <buffer> <Right> :VoomToggle<CR>

if has("mac")
  nnoremap <buffer> <Leader>pf :!pandoc
        \ --latex-engine=xelatex
        \ --number-sections
        \ --no-tex-ligatures
        \ --smart
        \ --include-in-header ~/.pandoc/header-includes.latex
        \ --bibliography ~/.pandoc/default.bib
        \ --highlight-style=pygments
        \ --variable=papersize:a4
        \ --variable=geometry:margin=1in
        \ --variable=fontsize:11pt
        \ --variable=mainfont:Georgia
        \ --variable=sansfont:Verdana
        \ --variable=monofont:Consolas
        \ -o "%:p:r.pdf" "%:p"<CR>
  nnoremap <buffer> <Leader>bm :!pandoc
        \ --latex-engine=xelatex
        \ --no-tex-ligatures
        \ --smart
        \ --include-in-header ~/.pandoc/header-includes.beamer
        \ --bibliography ~/.pandoc/default.bib
        \ --highlight-style=pygments
        \ --variable=fontsize:11pt
        \ --to=beamer
        \ -o "%:p:r.pdf" "%:p"<CR>
  nnoremap <buffer><silent> <Leader>pv :!open "%:p:r.pdf"<CR><CR>
endif

