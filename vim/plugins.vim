set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" Deps
Bundle 'gmarik/vundle'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'

" list only the plugin groups you will use
if !exists('g:bundle_groups')
  let g:bundle_groups=['general', 'programming', 'composing', 'mac']
endif

" General
if count(g:bundle_groups, 'general')
  Bundle 'tpope/vim-surround'
  Bundle 'tpope/vim-repeat'
  Bundle 'scrooloose/nerdtree'
  Bundle 'chrisbra/NrrwRgn'
  Bundle 'kien/ctrlp.vim'
  Bundle 'mileszs/ack.vim'
  Bundle 'henrik/vim-indexed-search'
  Bundle 'Lokaltog/vim-easymotion'
  Bundle 'Lokaltog/vim-powerline'
  Bundle 'sjl/gundo.vim'
  Bundle 'sjl/clam.vim'
  Bundle 'sjl/vitality.vim'
  Bundle 'benmills/vimux'
  Bundle 'Raimondi/delimitMate'
  Bundle 'ervandew/supertab'
  Bundle 'YankRing.vim'
  Bundle 'matchit.zip'
  Bundle 'sessionman.vim'
  "Bundle 'myusuf3/numbers.vim'
  " Color Schemes
  Bundle 'altercation/vim-colors-solarized'
  Bundle 'chriskempson/vim-tomorrow-theme'
  Bundle 'chriskempson/base16-vim'
  Bundle 'nanotech/jellybeans.vim'
  Bundle 'w0ng/vim-hybrid'
  Bundle 'noahfrederick/Hemisu'
  Bundle 'pyte'
  Bundle 'jacekd/vim-iawriter'
endif

" General Programming
if count(g:bundle_groups, 'programming')
  Bundle 'tpope/vim-fugitive'
  Bundle 'tpope/vim-endwise'
  Bundle 'nathanaelkane/vim-indent-guides'
  Bundle 'scrooloose/nerdcommenter'
  Bundle 'majutsushi/tagbar'
  Bundle 'scrooloose/syntastic'
  Bundle 'AutoTag'
  Bundle 'honza/vim-snippets'
  Bundle 'SirVer/ultisnips'
  Bundle 'Align'
  Bundle 'AutoAlign'
  Bundle 'DoxygenToolkit.vim'
endif

" Composing
if count(g:bundle_groups, 'composing')
  Bundle 'VOoM'
  Bundle 'jcf/vim-latex'
  "Bundle 'tpope/vim-markdown'
  Bundle 'vim-pandoc/vim-pandoc'
  Bundle 'taskpaper.vim'
endif

" PHP
if count(g:bundle_groups, 'php')
  Bundle 'spf13/PIV'
endif

" Python
if count(g:bundle_groups, 'python')
  " Pick either python-mode or pyflakes & pydoc
  Bundle 'klen/python-mode'
  Bundle 'python.vim'
  Bundle 'python_match.vim'
  Bundle 'pythoncomplete'
endif

" Javascript
if count(g:bundle_groups, 'javascript')
  Bundle 'leshill/vim-json'
  Bundle 'groenewege/vim-less'
  Bundle 'taxilian/vim-web-indent'
endif

" HTML
if count(g:bundle_groups, 'html')
  Bundle 'amirh/HTML-AutoCloseTag'
  Bundle 'ChrisYip/Better-CSS-Syntax-for-Vim'
endif

" ruby
if count(g:bundle_groups, 'ruby')
  bundle 'tpope/vim-rails'
endif

" mac specific
if count(g:bundle_groups, 'mac')
  Bundle 'rizzatti/funcoo.vim'
  Bundle 'rizzatti/dash.vim'
endif

" Misc
if count(g:bundle_groups, 'misc')
  Bundle 'tpope/vim-cucumber'
  Bundle 'Puppet-Syntax-Highlighting'
endif

