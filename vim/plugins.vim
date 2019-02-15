set nocompatible

call plug#begin('~/.vim/plugged')

" Fuzzy file, buffer, mru, tag, etc finder.
Plug 'kien/ctrlp.vim'
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_show_hidden = 1
let g:ctrlp_use_caching = 0 " don't cache results - turn this off if things are getting slow
if executable('ag')
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --hidden --ignore .git --ignore .hg --nocolor -g ""'
endif

" commentary.vim: comment stuff out
Plug 'tpope/vim-commentary'
map <leader><leader> gcc<ESC>

" A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
Plug 'airblade/vim-gitgutter'
let g:gitgutter_enabled = 1

" precision colorscheme for the vim text editor
Plug 'altercation/vim-colors-solarized'
let g:solarized_termcolors=256
if $SSH_CONNECTION
    let g:solarized_termtrans=1 " makes the background black
endif

" Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline_powerline_fonts = 1
set laststatus=2

" A git mirror of gundo.vim ('super' undo tree)
Plug 'sjl/gundo.vim', {'on': ['GundoToggle']}
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
if has('python3')
    let g:gundo_prefer_python3 = 1
endif

" :sunflower: A Vim alignment plugin
Plug 'junegunn/vim-easy-align', {'on': ['EasyAlign']}
vnoremap A :EasyAlign

" True Sublime Text style multiple selections for Vim
Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_exit_from_insert_mode = 0

" A modern vim plugin for editing LaTeX files.
Plug 'lervag/vimtex', {'for': ['tex']}
let g:Tex_DefaultTargetFormat = 'pdf' " Change default target to pdf, if not dvi is used
let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r -g @line @pdf @tex'
let g:vimtex_echo_ignore_wait = 1
let g:vimtex_compiler_latexmk = {'callback' : 0}
let g:vimtex_imaps_leader = '~'
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
" move between panes even from insert mode
inoremap <silent> <C-h> <ESC> :TmuxNavigateLeft<CR>
inoremap <silent> <C-j> <ESC> :TmuxNavigateDown<CR>
inoremap <silent> <C-k> <ESC> :TmuxNavigateUp<CR>
inoremap <silent> <C-l> <ESC> :TmuxNavigateRight<CR>

" Search Dash.app from Vim
Plug 'rizzatti/dash.vim', {'on': ['Dash']}

" pandoc integration and utilities for vim
Plug 'vim-pandoc/vim-pandoc', {'for': ['markdown']}
autocmd Filetype markdown nnoremap <buffer> <F5> :w<CR>:Pandoc pdf -V geometry:margin=1.00in --table-of-contents --number-sections<CR>
autocmd Filetype markdown inoremap <buffer> <F5> <ESC>:w<CR>:Pandoc pdf -V geometry:margin=1.00in --table-of-contents --number-sections<CR>a
autocmd Filetype markdown nnoremap <buffer> <F6> :w<CR>:Pandoc pdf -V geometry:margin=1.00in<CR>
autocmd Filetype markdown inoremap <buffer> <F6> <ESC>:w<CR>:Pandoc pdf -V geometry:margin=1.00in<CR>a


" pandoc markdown syntax, to be installed alongside vim-pandoc
Plug 'vim-pandoc/vim-pandoc-syntax', {'for': ['markdown']}
let g:pandoc#modules#disabled = ['folding']

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
Plug 'dhruvasagar/vim-table-mode', {'on': ['TableModeToggle']}
nnoremap <leader>tm :TableModeToggle<CR>

" autolist: Automatically continues lists
Plug 'bradford-smith94/vim-autolist'
autocmd Filetype markdown imap <buffer> <CR> <Esc><Plug>AutolistReturn
autocmd Filetype text imap <buffer> <CR> <Esc><Plug>AutolistReturn

" A vim plugin that simplifies the transition between multiline and single-line code
Plug 'AndrewRadev/splitjoin.vim'

" UltiSnips - The ultimate snippet solution for Vim. Send pull requests to SirVer/ultisnips!
Plug 'SirVer/ultisnips', {'do': 'pip3 install unidecode'}

" vim-snipmate default snippets (Previously snipmate-snippets)
Plug 'honza/vim-snippets'

" Perform all your vim insert mode completions with Tab
Plug 'ervandew/supertab'

" Go development plugin for Vim
Plug 'fatih/vim-go', {'for': ['go'], 'do': ':GoInstallBinaries'}
let g:go_fmt_command ='goimports'
let g:go_list_type = 'quickfix'
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <leader>i <Plug>(go-sameids-toggle)
function! s:build_go_files()
    " run :GoBuild or :GoTestCompile based on the go file
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

if v:version >= 704 && (v:version != 704 || has( 'patch1578' ))
    " A code-completion engine for Vim
    Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer'}
    let g:ycm_filetype_blacklist = {
                \ 'tex' : 0,
                \ 'pandoc' : 0,
                \ 'markdown' : 0
                \}
    let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
    let g:ycm_autoclose_preview_window_after_completion = 1
endif

" A VIM plugin for formatting saved JSON file.A VIM plugin for formatting saved JSON file.
Plug 'XadillaX/json-formatter.vim', {'do': 'npm install jjson -g'}

" Rename the current file in the vim buffer + retain relative path.
Plug 'danro/rename.vim'

" Syntax highlighting for thrift definition files.
Plug 'solarnz/thrift.vim', {'for': ['thrift']}

" Alternate Files quickly (.c --> .h etc)
let g:alternateSearchPath = 'reg:#\<src\>$#include#,reg:#\<include\>$#src#'
Plug 'vim-scripts/a.vim'

" Syntax highlighting and typechecker integration for Hack.
Plug 'hhvm/vim-hack', {'for': ['php']}

let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 1
" let g:clang_format#auto_format_on_insert_leave = 1
" Vim plugin for clang-format, a formatter for C, C++, Obj-C, Java, JavaScript, TypeScript and ProtoBuf.
Plug 'rhysd/vim-clang-format'

" eunuch.vim: Helpers for UNIX
Plug 'tpope/vim-eunuch'

call plug#end()
