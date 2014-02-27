" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

let $lang = 'en'
" Map leader and localleader key to comma
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","
let g:maplocalleader = ","

" Activate plugins
source ~/.vim/plugins.vim
filetype plugin indent on

" =============== General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set noshowmode                  "Show current mode down the bottom
set lazyredraw
set ttyfast
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set showmatch                   "Show matching bracets when text indicator is over them
set clipboard=unnamed           "share windows clipboard
set mouse=a                     "use mouse everywhere
set laststatus=2                "always show the status line
set cmdheight=2                 "status bar height
set cursorline                  "shows the horizontal cursor line
set tags=.tags;,tags;
set encoding=utf-8
set fileformats=unix,dos,mac    "support all three, in this order

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" ================ Search Settings  =================

set incsearch        "Find the next match as we type the search
set hlsearch         "Highlight searches by default
set smartcase        "Ignore case when searching lowercase
set ignorecase
set gdefault         "Substitutions globally
set viminfo='100,f1  "Save up to 100 marks, enable capital marks

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Indentation ======================
set autoindent
set smartindent
set smarttab
set linebreak
set textwidth=80
set cinoptions=:0,g0,(0,Ws,l1
" List chars
set listchars=""           " Reset the listchars
set listchars=tab:▸\ ,eol:¬
set listchars+=trail:.     " show trailing spaces as dots
set listchars+=extends:>   " The character to show in the last column when wrap is
" off and the line continues beyond the right of the screen
set listchars+=precedes:<  " The character to show in the last column when wrap is
" off and the line continues beyond the right of the screen

function! WrapStyle_nowrap()
  set nowrap
  set formatoptions=cqron1
  if v:version >= 703
    set colorcolumn=+1 "highlight column after 'textwidth'
  endif
  set list
endfunction

function! WrapStyle_wrap()
  set wrap
  set formatoptions=ro1
  if v:version > 702
    set colorcolumn=""
  endif
  set nolist
endfunction

function! WrapStyle_toggle()
  if (&wrap)
    call WrapStyle_nowrap()
  else
    call WrapStyle_wrap()
  endif
endfunction

augroup ftdetect
  au!
  autocmd BufRead,BufNewFile *.txt               set filetype=pandoc
  autocmd BufRead,BufNewFile *todolist.txt       set filetype=taskpaper
augroup END

augroup wrap_style
  au!
  autocmd FileType *                                     call WrapStyle_nowrap()
  autocmd FileType qf,pandoc,tex,man,text,help,taskpaper call WrapStyle_wrap()
augroup END

augroup tabstop_setting
  au!
  autocmd FileType *                              set sts=2 ts=2 sw=2
  autocmd FileType pandoc,java,python             set sts=4 ts=4 sw=4
  autocmd FileType c,cpp,help                     set sts=8 ts=8 sw=8
augroup END

augroup expandtab_setting
  au!
  autocmd FileType *                              set expandtab
  autocmd FileType c,cpp,make,taskpaper           set noexpandtab
augroup END

augroup csrc
  au!
  autocmd FileType *                              set nocindent
  autocmd FileType c,cpp                          set cindent
augroup END

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "don't fold by default

" ================ Completion =======================

set completeopt=longest,menuone,preview
set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*~           "stuff to ignore when tab completing
set wildignore+=*backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc                            " Python byte code

" ================ Scrolling ========================

"set scrolloff=8
set sidescrolloff=15
set sidescroll=1

" =========== Windows and Buffers ====================
set splitbelow splitright

" ================ Cursor settings ===================
" This makes terminal vim sooo much nicer!
" Tmux will only forward escape sequences to the terminal if surrounded by a DCS
" sequence
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" ================= Appearance ======================
if has('gui_running')
  set guioptions=ce
  set antialias           " Antialias font
  set columns=98 lines=50 " Default size of window
  set linespace=3
  set gtl=%t gtt=%F       " Tab headings
  autocmd VimResized * wincmd =

  if has("gui_macvim")
    "macmenu &File.Open\ Tab\.\.\.   key=<nop>
    set guifont=Consolas:h13
    set guifontwide=NanumGothicCoding:h13
  elseif has("gui_win32")
    set guifont=Consolas:h10
    set guifontwide=NanumGothicCoding:h10
  endif

else " Terminal
  set t_Co=256
  let base16colorspace=256

endif
set background=dark
colorscheme base16-default

" ======= Helper Funtions and Plugin Settings =======
for f in split(glob('~/.vim/settings/*.vim'), '\n')
  exe 'source' f
endfor

