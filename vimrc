filetype off

set nocompatible
set number
"set backupdir=$HOME/vimbackup
"set directory=$HOME/vimbackup
set nobackup
set noswapfile
set browsedir=buffer
set clipboard=unnamed
set hidden
set showmatch
set whichwrap=b,s,h,l,<,>,[,]
set backspace=indent,eol,start
set autoread
set scrolloff=0
set fileformats=unix,dos,mac
set clipboard+=unnamed
set textwidth=0

"colorscheme desert

" tab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent

" search
set incsearch
set ignorecase
set smartcase

" remove space of eol
autocmd BufWritePre * :%s/\s\+$//ge
" replace tab to space
" autocmd BufWritePre * :%s/\t/    /ge

highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /\u3000/

" color of statusline
augroup InsertHook
  autocmd!
  "autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
  "autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

" encoding
" set encoding=utf-8
" set termencoding=utf-8
" set fileencoding=utf-8
" set fileencodings=ucs-bom,euc-jp,cp932,iso-2022-jp
" set fileencodings+=,ucs-2le,ucs-2,utf-8

" statusline format
set statusline=%F%m%r%h%w%=[%{&ff}\ %{&enc}\ %Y\ %l,%v,%L]

" keymap
let mapleader = ','
let maplocalleader = ' '
noremap <C-k> <Esc>
noremap! <C-k> <Esc>
nnoremap <C-a> <Home>
nnoremap <C-e> <End>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Del>
nnoremap <silent> <C-x>1 :only<CR>
nnoremap <silent> <C-x>2 :sp<CR>
nnoremap <silent> <C-x>3 :vsp<CR>
nnoremap <C-t> gt
nnoremap <silent> <C-Tab> :bNext<cr>
nnoremap <C-n> :tabnew<space>

" vimrc
command! Ev edit $MYVIMRC
command! Rv source $MYVIMRC


" vundle
set rtp+=~/.vim/vundle/
call vundle#rc()


Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimshell'
Bundle 'thinca/vim-ref'
Bundle 'thinca/vim-quickrun'
Bundle 'unite-colorscheme'
Bundle 'Simple-Javascript-Indenter'
Bundle 'scrooloose/nerdcommenter'
Bundle 'Sixeight/unite-grep'
Bundle 'Shougo/vimfiler'


" pathogen
set rtp+=~/.vim/pathogen/
call pathogen#runtime_append_all_bundles('bundle2')


" vimshell
vmap <silent> ,s :VimShellSendString<cr>

" gauche
autocmd FileType scheme :let is_gauche=1
:command! Gosh execute ":VimShellInteractive gosh -i"

" vimclojure
autocmd FileType clojure
            \ :command! Ngconnect execute ":let vimclojure#WantNailgun = 1\n:execute vimclojure#InitBuffer()"
autocmd FileType clojure
            \ :setlocal lispwords+=defproject,deftest,monad,defmonad,with-monad,domonad,defmonadfn,monad-transformer,with-parser,defparser
let vimclojure#NailgunClient = "/Users/jou4/Library/Clojure/vimclojure/client/ng"
let vimclojure#HighlightBuiltins = 1
":command! Clj execute ":VimShellInteractive clj"

" nerdcommenter
let NERDSpaceDelims = 1
nmap <C-l> <plug>NERDCommenterToggle
vmap <C-l> <plug>NERDCommenterToggle

" unite.vim
" 入力モードで開始する
" let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>


" unite-grep
let g:unite_source_grep_default_opts = '-iRHn --exclude=*.svn*'
nnoremap <silent> ,ug :Unite grep:<CR>


" Makefile
au FileType make set noexpandtab

" enable
filetype plugin indent on
syntax on
