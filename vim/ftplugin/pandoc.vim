nnoremap <buffer> <Right> :VoomToggle<CR>
nnoremap <buffer> <F8> :MarkdownTidy<CR>
"nnoremap <buffer> <Leader>bm :!pandoc
      "\ --latex-engine=xelatex
      "\ --no-tex-ligatures
      "\ -t beamer
      "\ --template ~/.pandoc/custom.beamer
      "\ --bibliography ~/.pandoc/default.bib
      "\ --highlight-style=pygments
      "\ -o "%:p:r.pdf" "%:p"<CR>
nnoremap <buffer> <Leader>pf :!pandoc
      \ --latex-engine=xelatex
      \ --number-sections
      \ --template ~/.pandoc/custom.latex
      \ --bibliography ~/.pandoc/default.bib
      \ --highlight-style=pygments
      \ --variable=geometry:margin=1in
      \ -o "%:p:r.pdf" "%:p"<CR>
if has("mac")
  nnoremap <buffer><silent> <Leader>pv :!open "%:p:r.pdf"<CR><CR>
endif
