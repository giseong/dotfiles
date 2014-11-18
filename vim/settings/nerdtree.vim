" Make nerdtree look nice
let NERDTreeMinimalUI  = 1
let NERDTreeDirArrows  = 1
let NERDTreeShowHidden = 1
let NERDTreeWinPos     = 'left' " left window
let NERDTreeWinSize    = 40
let NERDTreeChDirMode  = 2
nmap <silent> <Left> :NERDTreeToggle<CR>:wincmd p<CR>
nmap <silent> <F4> :NERDTreeFind<CR>:wincmd p<CR>
"nmap <silent> <F4> :NERDTree %:p:h<CR>:lch %:p:h<CR>:wincmd p<CR>

"autocmd vimenter * NERDTree | wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

