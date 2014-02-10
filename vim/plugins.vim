set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" Deps
Bundle 'gmarik/vundle'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'

" list only the plugin groups you will use
if !exists('g:bundle_groups')
  if has("mac")
    let g:bundle_groups=['general', 'programming', 'composing', 'mac']
  else
    let g:bundle_groups=['general', 'programming', 'composing']
  endif
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
  Bundle 'terryma/vim-multiple-cursors'
  Bundle 'bling/vim-airline'
  Bundle 'mhinz/vim-signify'
  Bundle 'sjl/gundo.vim'
  Bundle 'sjl/clam.vim'
  Bundle 'sjl/vitality.vim'
  Bundle 'benmills/vimux'
  Bundle 'Raimondi/delimitMate'
  Bundle 'YankRing.vim'
  Bundle 'matchit.zip'
  Bundle 'altercation/vim-colors-solarized'
  Bundle 'chriskempson/base16-vim'
endif

" Programming
if count(g:bundle_groups, 'programming')
  Bundle 'tpope/vim-fugitive'
  Bundle 'tpope/vim-endwise'
  Bundle 'nathanaelkane/vim-indent-guides'
  Bundle 'scrooloose/nerdcommenter'
  Bundle 'majutsushi/tagbar'
  Bundle 'scrooloose/syntastic'
  Bundle 'AutoTag'
  "if has("lua")
    "Bundle 'Shougo/neocomplete'
    "Bundle 'Shougo/neosnippet'
    "Bundle 'Shougo/neosnippet-snippets'
  "else
    "Bundle 'Valloric/YouCompleteMe'
  "endif
  Bundle 'ervandew/supertab'
  Bundle 'SirVer/ultisnips'
  Bundle 'Align'
  Bundle 'AutoAlign'
  Bundle 'DoxygenToolkit.vim'
endif

" Composing
if count(g:bundle_groups, 'composing')
  Bundle 'VOoM'
  Bundle 'jcf/vim-latex'
  "if v:version >= 704
  "Bundle 'vim-pandoc/vim-pandoc-syntax'
  "Bundle 'vim-pandoc/vim-pantondoc'
  "Bundle 'vim-pandoc/vim-pandoc-after'
  "else
  Bundle 'vim-pandoc/vim-pandoc'
  "endif
  Bundle 'davidoc/taskpaper.vim'
  "Bundle 'dhruvasagar/vim-table-mode'
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

