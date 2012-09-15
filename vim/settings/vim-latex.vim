let g:tex_flavor                 = 'latex'
let g:Tex_DefaultTargetFormat    = 'pdf'
let g:Tex_CompileRule_pdf        = 'latexmk -xelatex $*'
let g:Tex_ViewRule_pdf           = 'Skim'
let g:Tex_ViewRule_dvi           = 'Skim'
let g:Tex_ViewRule_ps            = 'Skim'
let g:Tex_MultipleCompileFormats = 'pdf'
let g:Tex_BIBINPUTS              = '~/Dropbox/BibTeX/library.bib'
let g:Tex_UseUtfMenus            = 1
let g:Tex_AutoFolding            = 0
"let g:Tex_GotoError              = 0
let g:Tex_TreatMacViewerAsUNIX   = 1
let g:Imap_UsePlaceHolders       = 0

nnoremap <C-Space> <Plug>IMAP_JumpForward
inoremap <C-Space> <Plug>IMAP_JumpForward
vnoremap <C-Space> <Plug>IMAP_JumpForward

