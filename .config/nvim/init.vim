" Disable compatibility to old-time vi
set nocompatible

" Show matching brackets
set showmatch

" Case insensitive search
set ignorecase

" Enable mouse support (middle-click paste)
set mouse=v

" Highlight search matches
set hlsearch

" Enable incremental search
set incsearch

" Set tab width to 4
set tabstop=4

" Set soft tab stop to 4
set softtabstop=4

" Convert tabs to spaces
set expandtab

" Set auto-indent width to 4
set shiftwidth=4

" Auto indent new lines
set autoindent

" Show line numbers
set number

" Enable bash-like tab completion
set wildmode=longest,list

" Filetype specific plugin and indent settings
filetype plugin indent on

" Enable syntax highlighting
syntax on

" Enable mouse click functionality
set mouse=a

" Use system clipboard
set clipboard=unnamedplus

" Enable filetype plugin
filetype plugin on

" Speed up scrolling
set ttyfast

" Enable spell checking (optional)
" set spell

" Disable swap files
" set noswapfile

" Directory to store backup files
" set backupdir=~/.cache/vim

" Set terminal colors to default, and background to 100% opacity
set t_Co=256                             " Enable 256 color support in the terminal
let $TERM='xterm-256color'                " Set terminal type to support 256 colors

" Set background transparency to none (100% opacity)
hi NonText ctermbg=none guibg=NONE
hi Normal guibg=NONE ctermbg=NONE
hi NormalNC guibg=NONE ctermbg=NONE
hi SignColumn ctermbg=NONE ctermfg=NONE guibg=NONE

" Set transparency for popup menu and floating windows
hi Pmenu ctermbg=NONE ctermfg=NONE guibg=NONE
hi FloatBorder ctermbg=NONE ctermfg=NONE guibg=NONE
hi NormalFloat ctermbg=NONE ctermfg=NONE guibg=NONE
hi TabLine ctermbg=None ctermfg=None guibg=None
