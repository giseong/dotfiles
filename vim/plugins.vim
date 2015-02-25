set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" Deps
Plugin 'gmarik/vundle'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'

" list only the plugin groups you will use
if !exists('g:bundle_groups')
    let g:bundle_groups=['general', 'programming', 'composing', 'python']
endif

" General
if count(g:bundle_groups, 'general')
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-repeat'
    Plugin 'scrooloose/nerdtree'
    Plugin 'chrisbra/NrrwRgn'
    Plugin 'kien/ctrlp.vim'
    Plugin 'rking/ag.vim'
    Plugin 'henrik/vim-indexed-search'
    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'bling/vim-airline'
    Plugin 'mhinz/vim-signify'
    Plugin 'sjl/gundo.vim'
    Plugin 'sjl/clam.vim'
    Plugin 'sjl/vitality.vim'
    Plugin 'benmills/vimux'
    Plugin 'matchit.zip'
    Plugin 'xolox/vim-misc'
    Plugin 'xolox/vim-session'
    Plugin 'Valloric/ListToggle'
    Plugin 'chriskempson/base16-vim'
    Plugin 'morhetz/gruvbox'
endif

" Programming
if count(g:bundle_groups, 'programming')
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-endwise'
    Plugin 'tpope/vim-dispatch'
    Plugin 'nathanaelkane/vim-indent-guides'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'majutsushi/tagbar'
    Plugin 'scrooloose/syntastic'
    Plugin 'SirVer/ultisnips'
    Plugin 'honza/vim-snippets'
    if ! has("win32")
        Plugin 'Valloric/YouCompleteMe'
    endif
    Plugin 'Align'
    Plugin 'AutoAlign'
    Plugin 'DoxygenToolkit.vim'
    Plugin 'chazy/cscope_maps'
endif

" Composing
if count(g:bundle_groups, 'composing')
    Plugin 'VOoM'
    Plugin 'jcf/vim-latex'
    Plugin 'godlygeek/tabular'
    Plugin 'vim-pandoc/vim-pandoc'
    Plugin 'vim-pandoc/vim-pandoc-syntax'
    Plugin 'vim-pandoc/vim-pandoc-after'
endif

" golang
if count(g:bundle_groups, 'golang')
    Plugin 'fatih/vim-go'
endif

" PHP
if count(g:bundle_groups, 'php')
    Plugin 'spf13/PIV'
endif

" Python
if count(g:bundle_groups, 'python')
    " Pick either python-mode or pyflakes & pydoc
    Plugin 'klen/python-mode'
endif

" Javascript
if count(g:bundle_groups, 'javascript')
    Plugin 'moll/vim-node'
    Plugin 'jelera/vim-javascript-syntax'
endif

" HTML
if count(g:bundle_groups, 'html')
    Plugin 'amirh/HTML-AutoCloseTag'
    Plugin 'ChrisYip/Better-CSS-Syntax-for-Vim'
endif

" ruby
if count(g:bundle_groups, 'ruby')
    Plugin 'tpope/vim-rails'
endif

" Mac specific
if count(g:bundle_groups, 'mac')
    Plugin 'rizzatti/funcoo.vim'
    Plugin 'rizzatti/dash.vim'
endif

" Misc
if count(g:bundle_groups, 'misc')
    Plugin 'tpope/vim-cucumber'
    Plugin 'Puppet-Syntax-Highlighting'
endif

