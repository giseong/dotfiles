set com=s1:/*,mb:*,ex:*/,://,b:#.,:%,:XCOMM,n:>,b:-
setlocal equalprg=pandoc\ -t\ markdown\ -s\ --normalize\ --reference-links\ --atx-headers\ --no-wrap
nnoremap <buffer> <Right> :VoomToggle<CR>
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
      \ --variable=monofont:Cousine
      \ -o "%:p:r.pdf" "%:p"<CR>
if has("mac")
  nnoremap <buffer><silent> <Leader>pv :!open "%:p:r.pdf"<CR><CR>
endif

