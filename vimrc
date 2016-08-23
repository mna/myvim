call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-vinegar'
Plug 'flazz/vim-colorschemes'
" Plug 'PuerkitoBio/nofrils'
Plug 'bling/vim-airline'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'benekastah/neomake' " Too buggy with Go :( revisit at later date
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'rking/ag.vim'
Plug 'yuratomo/w3m.vim'
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'digitaltoad/vim-jade', {'for': 'jade'}
Plug 'ryanss/vim-hackernews', {'on': 'HackerNews'}
Plug 'lluchs/vim-wren', {'for': 'wren'}
call plug#end()

" toggle cursor appearance, see
" https://github.com/neovim/neovim/wiki/FAQ#how-can-i-change-the-cursor-shape-in-the-terminal
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" netrw alternate vsplit
" let g:netrw_altv = 1
" netrw hide some files
" let g:netrw_list_hide= '.*\.sw.$,\..+'

" Persistent, cross-session undos
set undofile
set undodir=~/.vim/undo

" Tabs : http://stackoverflow.com/questions/1878974/redefine-tab-as-4-spaces
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" to set syntax fully off
" syntax off
" let g:syntax_on=1 - because of vim-sensible??
colorscheme monokai

" Set both number and relative number:
" http://jeffkreeftmeijer.com/2013/vims-new-hybrid-line-number-mode/
set relativenumber
set number

" Set vim to recognize .md as markdown
au BufRead,BufNewFile *.md set filetype=markdown

" run neomake on save
" autocmd! BufWritePost * Neomake
" let g:neomake_open_list = 2

" syntastic
let g:syntastic_mode_map = { 'mode': 'passive' } " disable by default, run SyntasticCheck to run
let g:syntastic_go_checkers = ["go", "govet"] " removed golint, annoying on save
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_javascript_checkers = ["eslint"]

" Set ag to search from project root instead of cwd
" https://github.com/rking/ag.vim
let g:ag_working_path_mode="r"

" Highlight columns > 80
" hi ColorColumn cterm=NONE ctermfg=NONE ctermbg=238
" let &colorcolumn="80,".join(range(120,999),",")

" Set vim-go settings (see https://github.com/fatih/vim-go)
let g:go_fmt_command = "goimports"

" CtrlP triggers MRU by default
let g:ctrlp_cmd = 'CtrlPMRU'

" Key bindings
let mapleader = ","
nnoremap <leader>e :Explore<cr>
" Vim-Go bindings
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <Leader>gi <Plug>(go-implements)
au FileType go nmap <Leader>gr <Plug>(go-rename)
au FileType go nmap <Leader>gd <Plug>(go-doc-vertical)
" YankStack override of default bindings
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste
let g:yankstack_map_keys = 0
" Useful leader mappings
nnoremap <leader>n :tabnew<CR>
nnoremap <leader>c :tabclose<CR>
" toggle hex mode
" http://www.kevssite.com/2009/04/21/using-vi-as-a-hex-editor/
nnoremap <leader>h :%!xxd<CR>
nnoremap <leader>H :%!xxd -r<CR>
" Pretty-print json, uglify json
nnoremap <leader>j :%!jq .<CR>
nnoremap <leader>J :%!jq . -c<CR>
" run Syntastic
nnoremap <leader>k :SyntasticCheck<CR>
" switch color scheme
nnoremap <leader>sl :colorscheme lucius<CR>
nnoremap <leader>sd :colorscheme monokai<CR>

"Status bar,
"http://got-ravings.blogspot.ca/2008/08/vim-pr0n-making-statuslines-that-own.html
set statusline=%t       "tail of the filename
set statusline+=%{fugitive#statusline()}
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2        " status always visible

" use powerline symbols
let g:airline_powerline_fonts = 1

