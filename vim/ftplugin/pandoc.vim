setlocal equalprg=pandoc\ -t\ markdown\ -s\ --normalize\ --reference-links\ --no-wrap
nnoremap <buffer> <Right> :VoomToggle<CR>
nnoremap <buffer> <Leader>pf :!pandoc
      \ --latex-engine=xelatex
      \ --number-sections
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
