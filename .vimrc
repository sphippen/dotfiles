set nocompatible

""""""""""""
" General
""""""""""""
set encoding=utf-8
set history=9999
set autoread
let mapleader = ","
let maplocalleader = "\\"

""""""""""""
" Display
""""""""""""
set ruler
set showcmd
set incsearch

set laststatus=2
set statusline=%f[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%m%r%y%=%c,%l/%L\ %P

set number
set hlsearch
set scrolloff=5

set wildmenu
set wildignore=*.o,*~,*.exe,*.jpg,*.gif,*.png
set wildmode=list:longest

set showmatch
set matchtime=2

set lazyredraw

set splitbelow
set splitright

""""""""""""
" Editing
""""""""""""
set backspace=indent,eol,start
set mouse=a
set whichwrap=b,s,h,l,<,>,~,[,]
set ignorecase
set smartcase
set infercase

""""""""""""
" Indentation, tabs, formatting
""""""""""""
set expandtab
set tabstop=2
set shiftwidth=2

set autoindent
set smartindent
set wrap
set shiftround

set fileformats=unix,dos,mac

syntax on
filetype plugin indent on

let &showbreak = '++ '
set cpoptions+=n

""""""""""""
" Backups
""""""""""""
set nobackup
set nowritebackup

""""""""""""
" Moving around
""""""""""""

" Move up/down through wrapped lines as if they were multiple lines
noremap j gj
noremap k gk

" Make moving through windows easier
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l

""""""""""""
" Misc/Functions
""""""""""""

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

function <SID>ToggleTab()
  if (&expandtab == "1")
    set noexpandtab
    echo "Real tabs are being inserted."
  else
    set expandtab
    echo "Real tabs are not being inserted."
  endif
endfunction

nnoremap <leader>t :call <SID>ToggleTab()<cr>
nnoremap <leader>h :nohlsearch<cr>
nnoremap <leader>ev :vs $MYVIMRC<cr>
nnoremap <leader>, ,
