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

" tab
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent

" search
set incsearch
set ignorecase
set smartcase

" remove space of eol
fun! StripTrailingWhitespace()
  " Only strip if the b:noStripeWhitespace variable isn't set
  if exists('b:noStripWhitespace')
    return
  endif
  " %s/\s\+$//ge
endfun
autocmd BufWritePre * call StripTrailingWhitespace()
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
noremap <SID>(increment) <C-a>
noremap <SID>(decrement) <C-x>
nmap ,incr <SID>(increment)
nmap ,decr <SID>(decrement)
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
nnoremap vv viwy

" vimrc
command! Ev edit $MYVIMRC
command! Rv source $MYVIMRC


" vundle
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
if has('win32') || has('win64')
  set rtp+=$HOME/vimfiles/bundle/vundle/
  call vundle#rc('$HOME/vimfiles/bundle')
else
  set rtp+=$HOME/.vim/bundle/vundle/
  call vundle#rc('$HOME/.vim/bundle')
endif


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
Bundle 'msanders/snipmate.vim'
Bundle 'quickrun.vim'
Bundle 'Markdown'
Bundle 'tyru/open-browser.vim'
Bundle 'thinca/vim-ft-clojure'
Bundle 'vim-scripts/sudo.vim'
" for Haskell
Bundle 'dag/vim2hs'
Bundle 'eagletmt/ghcmod-vim'
Bundle 'ujihisa/neco-ghc'
Bundle 'eagletmt/unite-haddock'
Bundle 'pbrisbin/html-template-syntax'


" vimshell
nnoremap <silent> ,vs :VimShell<CR>
nnoremap ,vsi :VimShellInteractive<space>
nnoremap <silent> ,ghci :VimShellInteractive ghci<CR>
nnoremap <silent> ,repl :VimShellInteractive lein repl<CR>
nnoremap <silent> ,node :VimShellInteractive node<CR>
nnoremap <silent> ,gosh :VimShellInteractive gosh -i<CR>
nnoremap <silent> ,irb :VimShellInteractive irb<CR>
vmap <silent> ,s :VimShellSendString<CR>

" gauche
autocmd FileType scheme :let is_gauche=1

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

" quickrun
let g:quickrun_config = {}
let g:quickrun_config.markdown = {
      \ 'type': 'markdown/pandoc',
      \ 'cmdopt': '-s',
      \ 'outputter': 'browser'
      \ }


" Makefile
au FileType make set noexpandtab

" Markdown
au FileType markdown set tabstop=4
au FileType markdown set softtabstop=4
au FileType markdown set shiftwidth=4
au FileType markdown let b:noStripWhitespace=1

" Bodhi
au BufNewFile,BufRead *.bd setfiletype bodhi



" enable
filetype plugin indent on
syntax on


" if has('win32') || has('win64')
" endif


" help for myself
" *     search the word pointed by cursor strictly, to the front
" g*    search the word pointed by cursor to the front
" #     search the word pointed by cursor strictly, to back
" g#    search the word pointed by cursor to back
" viw   selected the word pointed by cursor
" vaw   selected the word pointed by cursor including space
" vit   selected the text-node in this tag
