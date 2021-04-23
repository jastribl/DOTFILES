" UltiSnips - The ultimate snippet solution for Vim. Send pull requests to SirVer/ultisnips!
Plug 'SirVer/ultisnips', {'do': 'pip3 install unidecode'}

" vim-snipmate default snippets (Previously snipmate-snippets)
Plug 'honza/vim-snippets'

" Perform all your vim insert mode completions with Tab
Plug 'ervandew/supertab'

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
