set nocompatible

call plug#begin('~/.vim/plugged')

" Vim plugin to list, select and switch between buffers.
Plug 'jeetsukumaran/vim-buffergator', {'on': ['BuffergatorOpen']}

" Fuzzy file, buffer, mru, tag, etc finder.
Plug 'kien/ctrlp.vim'
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_use_caching = 0 " don't cache results - turn this off if things are getting slow
if executable('ag')
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --hidden --ignore .git --nocolor -g ""'
endif

" Vim plugin for intensely orgasmic commenting
Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1
map <leader><leader> <plug>NERDCommenterToggle

" A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
Plug 'airblade/vim-gitgutter'
let g:gitgutter_enabled = 0

" precision colorscheme for the vim text editor
Plug 'altercation/vim-colors-solarized'
let g:solarized_termcolors=256
if $SSH_CONNECTION
    let g:solarized_termtrans=1
endif

" Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline_powerline_fonts = 1
set laststatus=2

" git wrapper
Plug 'tpope/vim-fugitive'

" A git mirror of gundo.vim ('super' undo tree)
Plug 'sjl/gundo.vim', {'on': ['GundoToggle']}
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" :sunflower: A Vim alignment plugin
Plug 'junegunn/vim-easy-align', {'on': ['EasyAlign']}

" True Sublime Text style multiple selections for Vim
Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_exit_from_insert_mode = 0

" Asynchronous Lint Engine
Plug 'w0rp/ale'
let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_enter = 0
" let g:ale_lint_delay = 1000
let g:airline#extensions#ale#enabled = 1
nmap <silent> <S-k> <Plug>(ale_previous_wrap)
nmap <silent> <S-j> <Plug>(ale_next_wrap)

" A modern vim plugin for editing LaTeX files.
Plug 'lervag/vimtex', {'for': ['tex']}
let g:Tex_DefaultTargetFormat = 'pdf' " Change default target to pdf, if not dvi is used
let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r -g @line @pdf @tex'
let g:vimtex_echo_ignore_wait = 1
let g:vimtex_compiler_latexmk = {'callback' : 0}
" mapping F5 to build latex
autocmd Filetype tex nnoremap <buffer> <F5> :w<CR>:VimtexView<CR>
autocmd Filetype tex inoremap <buffer> <F5> <ESC>:w<CR>:VimtexView<CR>a

" Highlights trailing whitespace in red and provides :FixWhitespace to fix it.
Plug 'bronson/vim-trailing-whitespace'
" trim extra whitespaces at ends of lines
nnoremap <leader>w :FixWhitespace<CR>

" CoffeeScript support for vim
Plug 'kchmck/vim-coffee-script', {'for': ['coffee']}

" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'

" Search Dash.app from Vim
Plug 'rizzatti/dash.vim'

" pandoc integration and utilities for vim
Plug 'vim-pandoc/vim-pandoc', {'for': ['markdown']}
autocmd Filetype markdown nnoremap <buffer> <F5> :w<CR>:Pandoc pdf -V geometry:margin=1.00in --table-of-contents --number-sections<CR>
autocmd Filetype markdown inoremap <buffer> <F5> <ESC>:w<CR>:Pandoc pdf -V geometry:margin=1.00in --table-of-contents --number-sections<CR>a
autocmd Filetype markdown nnoremap <buffer> <F6> :w<CR>:Pandoc pdf -V geometry:margin=1.00in<CR>
autocmd Filetype markdown inoremap <buffer> <F6> <ESC>:w<CR>:Pandoc pdf -V geometry:margin=1.00in<CR>a


" pandoc markdown syntax, to be installed alongside vim-pandoc
Plug 'vim-pandoc/vim-pandoc-syntax', {'for': ['markdown']}
let g:pandoc#modules#disabled = ["folding"]

" Vim motions on speed!
Plug 'easymotion/vim-easymotion'
" disable default mappings
let g:EasyMotion_do_mapping = 0
" turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Preview colours in source code while editing
Plug 'ap/vim-css-color', {'for': ['css', 'html']}

" VIM Table Mode for instant table creation
Plug 'dhruvasagar/vim-table-mode'

" autolist: Automatically continues lists
Plug 'bradford-smith94/vim-autolist'
autocmd Filetype markdown imap <buffer> <CR> <Esc><Plug>AutolistReturn

" Go development plugin for Vim
Plug 'fatih/vim-go', {'for': ['go'], 'do': ':GoInstallBinaries'}
let g:go_fmt_command = "goimports"

" A tree explorer plugin for vim.
Plug 'scrooloose/nerdtree'

call plug#end()
