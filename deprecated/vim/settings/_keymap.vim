"clearing highlighted search
nnoremap <silent> <Leader>/ :nohlsearch<CR>

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Formatting, TextMate-style
nnoremap <Leader>q gqip
vnoremap <Leader>q gq

" Change Working Directory to that of the current file
cnoremap cwd lcd %:p:h

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

nnoremap <silent> <F3> :call WrapStyle_toggle()<CR>

" remove all trailing whitespaces
nnoremap <silent> <F4> :%s/\s\+$//e<CR>

" copy current filename into system clipboard - mnemonic: (c)urrent(f)ilename
" this is helpful to paste someone the path you're looking at
nnoremap <silent> <Leader>cf :let @* = expand("%:p")<CR>
nnoremap <silent> <Leader>cd :let @* = expand("%:p:h")<CR>

function! RedrawScreen()
    syntax sync fromstart
    redraw!
    wincmd =
endfunction

" redraw screen
nnoremap <silent> <F5> :call RedrawScreen()<CR>

" paste mode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
