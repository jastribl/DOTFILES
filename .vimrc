set nocompatible

" # Plugins
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" This is the Vundle package, which can be found on GitHub.
" For GitHub repos, you specify plugins using the
" 'user/repository' format
Plugin 'gmarik/vundle'

" We could also add repositories with a ".git" extension
Plugin 'scrooloose/nerdtree.git'

" To get plugins from Vim Scripts, you can reference the plugin
" by name as it appears on the site
Plugin 'Buffergator'

" for latex building
Plugin 'LaTeX-Box-Team/LaTeX-Box'

" Fuzzy file, buffer, mru, tag, etc finder.
Plugin 'kien/ctrlp.vim'
" CtrlP settings
let g:ctrlp_match_window = 'top,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
" install ag first and try the one below
" let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" Vim plugin for intensely orgasmic commenting
Plugin 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1

" A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
"oPlugin 'airblade/vim-gitgutter'

" Monokai color scheme for Vim converted from Textmate theme
Plugin 'sickill/vim-monokai'

" Lean & mean status/tabline for vim that's light as air.
" Plugin 'bling/vim-airline'

" git wrapper
Plugin 'tpope/vim-fugitive'

" 'super' undo tree
Plugin 'Gundo'

filetype plugin indent on


" # General
" Sets how many lines of history VIM has to remember
set history=700

set number
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set backspace=indent,eol,start


" UI Config
syntax enable
colorscheme monokai
set wildmenu                " visual autocomplete for command menu
set lazyredraw              " redraw only when we need to.
set showmatch               " highlight matching [{()}]
set cursorline


" # Searching
set incsearch               " search as characters are entered
set hlsearch                " highlight matches
set ignorecase              " Ignore case when searching
set smartcase               " When searching try to be smart about cases


" # Movement
" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" make certain keys wrap lines
set whichwrap+=<,>,h,l,[,]

" highlight last inserted text
" nnoremap gV `[v`]


" # Leader key shortcuts
" let mapleader=","       " leader is comma
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" jk is escape
inoremap kj <esc>

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" # file saving
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" # splitting
" split in a more natural direction
set splitbelow
set splitright
" remap ctrl-w, ? -> ctrl-? for plit movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

