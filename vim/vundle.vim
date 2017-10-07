set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Vundle, the plug-in manager for Vim
Plugin 'gmarik/vundle'

" A tree explorer plugin for vim.
Plugin 'scrooloose/nerdtree'
map <C-t> :NERDTreeToggle<CR>

" A plugin of NERDTree showing git status
Plugin 'Xuyuanp/nerdtree-git-plugin'

" Vim plugin to list, select and switch between buffers.
Plugin 'jeetsukumaran/vim-buffergator'

" Fuzzy file, buffer, mru, tag, etc finder.
Plugin 'kien/ctrlp.vim'
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_show_hidden = 1
if executable('ag')
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --hidden --ignore .git --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

" Vim plugin for intensely orgasmic commenting
Plugin 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1
map <leader><leader> <plug>NERDCommenterToggle

" A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
Plugin 'airblade/vim-gitgutter'

" precision colorscheme for the vim text editor
Plugin 'altercation/vim-colors-solarized'
let g:solarized_termcolors=256
if $SSH_CONNECTION
    let g:solarized_termtrans=1
endif
colorscheme solarized
set background=dark

" Lean & mean status/tabline for vim that's light as air.
Plugin 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
set laststatus=2

" git wrapper
Plugin 'tpope/vim-fugitive'

" A git mirror of gundo.vim ('super' undo tree)
Plugin 'sjl/gundo.vim'
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

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
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_cpp_compiler = 'gpp'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_java_javac_config_file_enabled = 1

" A modern vim plugin for editing LaTeX files.
Plugin 'lervag/vimtex'
let g:Tex_DefaultTargetFormat = 'pdf' " Change default target to pdf, if not dvi is used
let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r -g @line @pdf @tex'
let g:vimtex_echo_ignore_wait = 1
let g:vimtex_compiler_latexmk = {'callback' : 0}
" mapping F5 to build latex
autocmd Filetype tex nnoremap <buffer> <F5> :w<CR>:VimtexView<CR>
autocmd Filetype tex inoremap <buffer> <F5> <ESC>:w<CR>:VimtexView<CR>a

" Highlights trailing whitespace in red and provides :FixWhitespace to fix it.
Plugin 'bronson/vim-trailing-whitespace'
" trim extra whitespaces at ends of lines
nnoremap <leader>w :FixWhitespace<CR>

" CoffeeScript support for vim
Plugin 'kchmck/vim-coffee-script'

" Seamless navigation between tmux panes and vim splits
Plugin 'christoomey/vim-tmux-navigator'

" Search Dash.app from Vim
Plugin 'rizzatti/dash.vim'

" pandoc integration and utilities for vim
Plugin 'vim-pandoc/vim-pandoc'
autocmd Filetype markdown nnoremap <buffer> <F5> :w<CR>:Pandoc pdf -V geometry:margin=1.00in --table-of-contents --number-sections<CR>
autocmd Filetype markdown inoremap <buffer> <F5> <ESC>:w<CR>:Pandoc pdf -V geometry:margin=1.00in --table-of-contents --number-sections<CR>a
autocmd Filetype markdown nnoremap <buffer> <F6> :w<CR>:Pandoc pdf -V geometry:margin=1.00in<CR>
autocmd Filetype markdown inoremap <buffer> <F6> <ESC>:w<CR>:Pandoc pdf -V geometry:margin=1.00in<CR>a


" pandoc markdown syntax, to be installed alongside vim-pandoc
Plugin 'vim-pandoc/vim-pandoc-syntax'
let g:pandoc#modules#disabled = ["folding"]

" Vim motions on speed!
Plugin 'easymotion/vim-easymotion'
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
Plugin 'ap/vim-css-color'

" VIM Table Mode for instant table creation
Plugin 'dhruvasagar/vim-table-mode'

filetype plugin indent on
