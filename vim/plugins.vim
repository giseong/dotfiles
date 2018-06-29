set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Deps
Plugin 'VundleVim/Vundle.vim'
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
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'rking/ag.vim'
    Plugin 'henrik/vim-indexed-search'
    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'mhinz/vim-signify'
    Plugin 'sjl/clam.vim'
    Plugin 'sjl/vitality.vim'
    Plugin 'benmills/vimux'
    Plugin 'christoomey/vim-tmux-navigator'
    Plugin 'matchit.zip'
    Plugin 'Valloric/ListToggle'
    Plugin 'chriskempson/base16-vim'
    " Plugin 'editorconfig/editorconfig-vim'

    " Status Bar
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    " python3 from powerline.vim import setup as powerline_setup
    " python3 powerline_setup
    " python3 del powerline_setup
endif

" Programming
if count(g:bundle_groups, 'programming')
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-endwise'
    Plugin 'tpope/vim-dispatch'
    Plugin 'nathanaelkane/vim-indent-guides'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'majutsushi/tagbar'
    Plugin 'DoxygenToolkit.vim'
    " Plugin 'scrooloose/syntastic'
    " Plugin 'sirver/ultisnips'
    " Plugin 'honza/vim-snippets'
    " Plugin 'Valloric/YouCompleteMe'
    " Plugin 'jeaye/color_coded'
    " Plugin 'rdnetto/YCM-Generator'
    " Plugin 'chazy/cscope_maps'
endif

" Composing
if count(g:bundle_groups, 'composing')
    Plugin 'jcf/vim-latex'
    Plugin 'godlygeek/tabular'
    Plugin 'vim-pandoc/vim-pandoc'
    Plugin 'vim-pandoc/vim-pandoc-syntax'
    Plugin 'vim-pandoc/vim-pandoc-after'
    Plugin 'vim-pandoc/vim-markdownfootnotes'
    Plugin 'aklt/plantuml-syntax'
    Plugin 'irrationalistic/vim-tasks'
endif

" golang
if count(g:bundle_groups, 'golang')
    Plugin 'fatih/vim-go'
endif

" rust-lang
if count(g:bundle_groups, 'rust-lang')
    Plugin 'rust-lang/rust.vim'
endif

" swift-lang
if count(g:bundle_groups, 'swift-lang')
    Plugin 'keith/swift.vim'
endif

" PHP
if count(g:bundle_groups, 'php')
    Plugin 'spf13/PIV'
endif

" Python
if count(g:bundle_groups, 'python')
    Plugin 'python-mode/python-mode'
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

call vundle#end()
