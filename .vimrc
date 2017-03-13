set nocompatible

" # Plugins
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Vundle, the plug-in manager for Vim
Plugin 'gmarik/vundle'

" A tree explorer plugin for vim.
Plugin 'scrooloose/nerdtree'

" Vim plugin to list, select and switch between buffers.
Plugin 'jeetsukumaran/vim-buffergator'

" Lightweight Toolbox for LaTeX - New Official repository
" Plugin 'latex-box-team/latex-box'

" Fuzzy file, buffer, mru, tag, etc finder.
Plugin 'kien/ctrlp.vim'
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
" install ag first and try the one below
" let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" Vim plugin for intensely orgasmic commenting
Plugin 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1

" A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
Plugin 'airblade/vim-gitgutter'

" Monokai color scheme for Vim converted from Textmate theme
Plugin 'sickill/vim-monokai'

" Lean & mean status/tabline for vim that's light as air.
" Plugin 'bling/vim-airline'

" git wrapper
Plugin 'tpope/vim-fugitive'

" A git mirror of gundo.vim ('super' undo tree)
Plugin 'sjl/gundo.vim'

" Vim script for text filtering and alignment
Plugin 'godlygeek/tabular'

" A code-completion engine for Vim
" Plugin 'valloric/youcompleteme'

" Plugin 'xuhdev/vim-latex-live-preview'
" let g:livepreview_previewer = 'open -a Skim'
" let g:livepreview_previewer = 'open -a Skim'

" A modern vim plugin for editing LaTeX files.
Plugin 'lervag/vimtex'
let g:Tex_DefaultTargetFormat = 'pdf' " Change default target to pdf, if not dvi is used
let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r -g @line @pdf @tex'
let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']
let g:vimtex_echo_ignore_wait = 1
function! UpdateSkim(status)
  if !a:status | return | endif
  let l:out = b:vimtex.out()
  let l:tex = expand('%:p')
  let l:cmd = [g:vimtex_view_general_viewer, '-r', '-g']
  call job_start(l:cmd + [line('.'), l:out, l:tex])
endfunction
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
set scrolloff=10
set spell
set spelllang=en_ca
set mouse=a

function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

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

" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :tabedit $MYVIMRC<CR>
nnoremap <leader>ez :tabedit ~/.zshrc<CR>
nnoremap <leader>eb :tabedit ~/.bashrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>


" # file saving
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

autocmd FileType h,c,cpp,java,php,tex autocmd BufWritePre <buffer> %s/\s\+$//e

" # clipboard
" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" # splitting
" split in a more natural direction
set splitbelow
set splitright
" remap ctrl-w, ? -> ctrl-? for plit movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" # other
command! Q q
command! W w

" Disable Arrow keys in Escape mode
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>

" Disable Arrow keys in Insert mode
" imap <up> <nop>
" imap <down> <nop>
" imap <left> <nop>
" imap <right> <nop>

inoremap <S-Tab> <C-d>

