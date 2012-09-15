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

"nnoremap <Leader>i :set list!<CR>

"Control quickfix window
nnoremap <silent> <Up>   :botright cwindow<CR>:wincmd p<CR>
nnoremap <silent> <Down> :cclose<CR>:wincmd p<CR>

nnoremap <C-k> <C-W>k
nnoremap <C-j> <C-W>j
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

nnoremap j gj
nnoremap k gk

nnoremap <silent> <F3> :call WrapStyle_toggle()<CR>
nnoremap <silent> <F6> :set spell!<CR>

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
nnoremap <silent> <F1> :call RedrawScreen()<CR>

"if has("mac")
  "nnoremap <silent> <D-F> :!open -a Finder "%:p:h"<CR><CR>
  "nnoremap <silent> <D-T> :!~/.vim/scripts/iTerm.sh <CR><CR>
"endif

