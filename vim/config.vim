" a fix for something I can't remember
if has('python3')
    silent! python3 1
endif

" General
set history=1000                     " sets how many lines of history VIM has to remember
set directory=$HOME/.vim/swapfiles// " store swap files in their own place
set number                           " turns on line numbers
set smartindent                      " be smart with indentation
set encoding=utf-8                   " set the encoding to UTF-8
set spell                            " turn on spell checking
set spelllang=en_ca                  " set dictionary to Canadian English
" set spelllang=en_us                  " set dictionary to USA English
" toggle spelling
nnoremap <F7> :set spell!<CR>

set tabstop=4        " smart tabs
set softtabstop=4    " make tabs and spaces play nice together
set shiftwidth=4     " make tabs and spaces play nice together
set expandtab        " use the right number of spaces for tabs
set backspace=2      " make backspace work like most other apps
set pastetoggle=<F2> " toggle paste mode

" toggle line numbers and git gutter together
nnoremap <F3> :windo set number!<CR>:GitGutterToggle<CR>

" toggle mouse mode
function! ToggleMouse()
    if &mouse == 'a'
        set mouse=
        echo "Mouse Off"
    else
        set mouse=a
        echo "Mouse On"
    endif
endfunc
nnoremap <F4> :call ToggleMouse()<CR>

" UI Config
syntax enable         " enable syntax
colorscheme solarized " my current colorscheme of choice
set background=dark   " use dark mode
                      " no background for vertical splits
hi VertSplit ctermbg=NONE guibg=NONE cterm=NONE
set fillchars+=vert:│ " use tmux vsplit character
set wildmenu          " visual autocomplete for command menu
set lazyredraw        " redraw only when we need to.
set updatetime=100    " update more often (this helps git gutter show faster)
set showmatch         " highlight matching [{()}]
set scrolloff=3       " keep the cursor offset while scrolling
set linebreak         " break lines at words, not at characters
set autowrite         " write buffer to file on make

" show fancy line breaks
if has("patch-7.4.338")
    set breakindent
    set breakindentopt=shift:2
    let &showbreak = '↳ '
endif


" Searching
set incsearch         " search as characters are entered
set hlsearch          " highlight matches
let @/ = ""           " don't highlight last search when sourcing vimrc
set ignorecase        " ignore case while searching
set smartcase         " When searching try to be smart about cases
" turn off search highlighting with space
nnoremap <space> :nohlsearch<CR>

" split in a more natural direction
set splitbelow
set splitright

" special things with ag
if executable('ag')
    " bind <leader / to grep shortcut
    command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap <leader>/ :Ag<SPACE>

    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor
endif

function! TabEditSmart(file)
    if bufname("%") == ""
        execute "edit " . a:file
    else
        execute "vsplit " a:file
    endif
endfunction

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

" use % to select blocks
noremap % v%

" use tab and shift tab in visual mode for indentation
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
nnoremap <Tab> >>
noremap <S-Tab> <<

" get out of visual mode quicker
vnoremap <ESC> <ESC><ESC>

" edit rc files and load vimrc bindings
nnoremap <leader>ev :call TabEditSmart("~/.vim/config.vim")<CR> :call TabEditSmart("~/.vim/plugins.vim")<CR>
nnoremap <leader>eb :call TabEditSmart("~/.bashrc")<CR> :call TabEditSmart("~/.bashrc.local")<CR>
nnoremap <leader>et :call TabEditSmart("~/.tmux.conf")<CR> :call TabEditSmart("~/.tmux.conf.local")<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

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

" replace word under cursor in entire file (with confirmation)
inoremap <C-r> <ESC>:%s/<C-r><C-w>/<C-r><C-w>/gc<left><left><left>

" easier moving between tabs
nnoremap H gT
nnoremap L gt

" correct the last spelling mistake
nnoremap [= [sz=

" use commas as a second leader key
nmap , \
vmap , \

" convert files between hex and bin
command! Hexbin %!xxd
command! Unhexbin %!xxd -r

nnoremap <F8> :make<BAR>cw<CR><CR><CR>
