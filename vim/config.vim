if !has("gui_running")
    set t_Co=256
    set term=screen-256color
endif

" # General
" Sets how many lines of history VIM has to remember
set history=1000

" store swap files in their own place
set directory=$HOME/.vim/swapfiles//

set number
set smartindent
if has("patch-7.4.338")
    set breakindent
    set breakindentopt=shift:2
    let &showbreak = '↳ '
endif
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set backspace=2             " make backspace work like most other apps
set pastetoggle=<F2>
nnoremap <F7> :set spell!<CR>

" UI Config
syntax enable
set wildmenu                " visual autocomplete for command menu
set lazyredraw              " redraw only when we need to.
set updatetime=1500         " update more often (this helps git gutter show faster)
set showmatch               " highlight matching [{()}]
set scrolloff=7
set linebreak
set spell
set spelllang=en_ca

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
let @/ = ""                 " don't highlight last search when sourcing vimrc
set ignorecase              " Ignore case when searching
set smartcase               " When searching try to be smart about cases

" turn off search highlightd
nnoremap <leader><space> :nohlsearch<CR>

if executable('ag')
    " bind <leader / to grep shortcut
    command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap <leader>/ :Ag<SPACE>
endif


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
vmap <C-e> $
vmap <C-a> ^

" make certain keys wrap lines
set whichwrap+=<,>,h,l,[,]

" map shift tab to tab backward in insert mode
inoremap <S-Tab> <C-d>

" jk is escape
inoremap kj <esc>

" indent multiple times while in visual mode
vnoremap < <gv
vnoremap > >gv

function! TabEditSmart(file)
    if bufname("%") == ""
        execute "edit " . a:file
    else
        execute "tabedit " a:file
    endif
endfunction

" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>evb :call TabEditSmart($MYVIMRC)<CR>
nnoremap <leader>evc :call TabEditSmart("~/.vim/config.vim")<CR>
nnoremap <leader>evv :call TabEditSmart("~/.vim/vundle.vim")<CR>
nnoremap <leader>ez :call TabEditSmart("~/.zshrc")<CR>
nnoremap <leader>eb :call TabEditSmart("~/.bashrc")<CR>
nnoremap <leader>ebl :call TabEditSmart("~/.bashrc.local")<CR>
nnoremap <leader>et :call TabEditSmart("~/.tmux.conf")<CR>
nnoremap <leader>etl :call TabEditSmart("~/.tmux.conf.local")<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>


" # file saving
" Return to last edit position when opening files (You want this!)
if has("autocmd")
    autocmd BufReadPost *
         \ if line("'\"") > 0 && line("'\"") <= line("$") |
         \   exe "normal! g`\"" |
         \ endif
endif


" # clipboard
" yank to clipboard
if has("clipboard")
    set clipboard=unnamed " copy to the system clipboard

    if has("unnamedplus") " X11 support
        set clipboard+=unnamedplus
    endif
endif

if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor
endif

" # splitting
" split in a more natural direction
set splitbelow
set splitright

" because I can't type :)
command! Q q
command! W w
command! Wq wq
command! WQ wq
command! QW wq
command! Qw wq
map q: <Nop>
nnoremap Q <nop>

" moving line up and down live in sublime
" nnoremap <C-j> :m .+1<CR>==
" nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
