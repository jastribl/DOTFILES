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

" Fuzzy file, buffer, mru, tag, etc finder.
Plugin 'kien/ctrlp.vim'
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_show_hidden = 1
" The Silver Searcher
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --hidden --ignore .git --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

" Vim plugin for intensely orgasmic commenting
Plugin 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1

" A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
Plugin 'airblade/vim-gitgutter'

" Monokai color scheme for Vim converted from Textmate theme
Plugin 'sickill/vim-monokai'

" Lean & mean status/tabline for vim that's light as air.
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
set laststatus=2

" git wrapper
Plugin 'tpope/vim-fugitive'

" A git mirror of gundo.vim ('super' undo tree)
Plugin 'sjl/gundo.vim'

" Help folks to align text, eqns, declarations, tables, etc
Plugin 'Align'

" True Sublime Text style multiple selections for Vim
Plugin 'terryma/vim-multiple-cursors'
let g:multi_cursor_exit_from_insert_mode = 0

" Syntax checking hacks for vim
Plugin 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_cpp_compiler = 'gpp'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_java_javac_config_file_enabled = 1
let g:syntastic_quiet_messages = {
    \ "!level":  "warnings",
    \ "type":    "syntax",
    \ "regex":   'serializable class Stroke has no definition of serialVersionUID'}

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
" set spell
set spelllang=en_ca
" set mouse=a

function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>


" # Searching
set incsearch               " search as characters are entered
set hlsearch                " highlight matches
set ignorecase              " Ignore case when searching
set smartcase               " When searching try to be smart about cases

" turn off search highlightd
nnoremap <leader><space> :nohlsearch<CR>

" bind <leader / to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap <leader>/ :Ag<SPACE>


" # Movement
" move vertically by visual line
nnoremap j gj
nnoremap k gk
nnoremap <down> g<down>
nnoremap <up> g<up>

" map ctrl-e and ctrl-a to beginning and end of line like in terminal
imap <C-e> <ESC>A
imap <C-a> <ESC>I
nmap <C-E> A
nmap <C-A> I

" make certain keys wrap lines
set whichwrap+=<,>,h,l,[,]

" map shift tab to tab backward in insert mode
inoremap <S-Tab> <C-d>


" # Leader key shortcuts
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

" trim extra whitespaces at ends of lines for certain file types
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


" because I can't type :)
command! Q q
command! W w
command! WQ wq
command! QW wq

" Selecting and moving things like in Sublime
" nnoremap <C-S-L> V
vnoremap <C-S-L> j

" mapping F5 to build latex
autocmd Filetype tex nnoremap <buffer> <F5> :w<CR><Bar>:VimtexView<CR>
autocmd Filetype tex inoremap <buffer> <F5> <ESC>:w<CR><Bar>:VimtexView<CR>

