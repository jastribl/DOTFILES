" # General
" Sets how many lines of history VIM has to remember
set history=1000
set directory=$HOME/.vim/swapfiles// " store swap files in their own place
set nonumber
set smartindent
set spell
set spelllang=en_ca
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
nnoremap <F3> :windo set number!<CR>:GitGutterToggle<CR>
nnoremap <F7> :set spell!<CR>

" todo: pick another shortcut for this that isn't the enter key or figure out
" how to differentiate the enter key from the actual <C-m>
" function! ToggleMouse()
    " if &mouse == 'a'
        " set mouse=
        " echo "Mouse Off"
    " else
        " set mouse=a
        " echo "Mouse On"
    " endif
" endfunc
" nnoremap <C-M> :call ToggleMouse()<CR>

" use % to select blocks
noremap % v%


" UI Config
colorscheme solarized
set background=dark
if !has("gui_running")
    set t_Co=256
    set term=screen-256color
endif
syntax enable
set wildmenu                " visual autocomplete for command menu
set lazyredraw              " redraw only when we need to.
set updatetime=1500         " update more often (this helps git gutter show faster)
set showmatch               " highlight matching [{()}]
set scrolloff=3
set linebreak
set autowrite               " write buffer to file on make

" set colorcolumn=100
" set textwidth=100

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
set ignorecase
set smartcase               " When searching try to be smart about cases

" turn off search highlightd
nnoremap <space> :nohlsearch<CR>

if executable('ag')
    " bind <leader / to grep shortcut
    command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap <leader>/ :Ag<SPACE>
endif


" # Movement
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" nnoremap <up> g<up>
" nnoremap <down> g<down>

" break bad habits
nnoremap <UP> <NOP>
nnoremap <DOWN> <NOP>
nnoremap <LEFT> <NOP>
nnoremap <RIGHT> <NOP>
inoremap <UP> <NOP>
inoremap <DOWN> <NOP>
inoremap <LEFT> <NOP>
inoremap <RIGHT> <NOP>
vnoremap <UP> <NOP>
vnoremap <DOWN> <NOP>
vnoremap <LEFT> <NOP>
vnoremap <RIGHT> <NOP>

" map ctrl-e and ctrl-a to beginning and end of line like in terminal
inoremap <C-e> <ESC>A
inoremap <C-a> <ESC>I
nnoremap <C-E> A
nnoremap <C-A> I
vnoremap <C-e> $
vnoremap <C-a> ^

" make certain keys wrap lines
set whichwrap+=<,>,h,l,[,]

" map shift tab to tab backward in insert mode
inoremap <S-Tab> <C-d>

" jk is escape
inoremap kj <esc>

" indent multiple times while in visual mode
vnoremap < <gv
vnoremap > >gv

" use tab and shift tab in visual mode for indentation
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
nnoremap <Tab> >>
noremap <S-Tab> <<

" get out of visual mode quicker
vnoremap <ESC> <ESC><ESC>

function! TabEditSmart(file)
    if bufname("%") == ""
        execute "edit " . a:file
    else
        execute "vsplit " a:file
    endif
endfunction

" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>evb :call TabEditSmart($MYVIMRC)<CR>
nnoremap <leader>evc :call TabEditSmart("~/.vim/config.vim")<CR>
nnoremap <leader>evv :call TabEditSmart("~/.vim/plugins.vim")<CR>
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
noremap q: <NOP>
nnoremap q <NOP>
nnoremap Q <NOP>

" moving line up and down like in sublime
" nnoremap <C-j> :m .+1<CR>== <- these don't work so well with my tmux setup
" nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
vnoremap <C-h> <gv
vnoremap <C-l> >gv

" easier moving between tabs
nnoremap H gT
nnoremap L gt
