call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/syntastic'
Plug 'bling/vim-airline'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'kien/ctrlp.vim'
Plug 'jszakmeister/vim-togglecursor'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'mustache/vim-mustache-handlebars'
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'rhysd/vim-crystal', {'for': 'crystal'}
Plug 'PuerkitoBio/nimrod.vim', {'for': 'nim'}
Plug 'ryanss/vim-hackernews', {'on': 'HackerNews'}
Plug 'fasterthanlime/ooc.vim', {'for': ['ooc', 'use']}
call plug#end()

" netrw alternate vsplit
let g:netrw_altv = 1
" netrw hide some files
let g:netrw_list_hide= '.*\.sw(p|o)$,\..+'

" Persistent, cross-session undos
set undofile
set undodir=~/.vim/undo

" Tabs : http://stackoverflow.com/questions/1878974/redefine-tab-as-4-spaces
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

colorscheme darkburn
set relativenumber " Set both number and relative number: http://jeffkreeftmeijer.com/2013/vims-new-hybrid-line-number-mode/
set number " Default to line numbers on

" Set vim to recognize .md as markdown
au BufRead,BufNewFile *.md set filetype=markdown

" Highlight columns > 80
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn="80,".join(range(120,999),",")

" Set Go fmt tool
let g:go_fmt_command = "goimports"

" Set eslint as javascript checker
let g:syntastic_javascript_checkers = ["eslint"]

" Key bindings
let mapleader = ","
nnoremap <leader>e :Explore<cr>

" Vim-Go bindings
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <Leader>gi <Plug>(go-implements)
au FileType go nmap <Leader>gr <Plug>(go-rename)

" YankStack override of default bindings
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste
let g:yankstack_map_keys = 0

" Useful leader mappings
" See http://karmanebula.com/technically-borked/2013/12/16/leader-key-as-space-capslock-as-esc
noremap <up> <C-w>+
noremap <down> <C-w>-
noremap <left> 3<C-w><
noremap <right> 3<C-w>>
nnoremap <leader>= <C-w>=
nnoremap <leader>, <C-w><C-w>
nnoremap <leader>n :tabnew<CR>
nnoremap <leader>c :tabclose<CR>

" CtrlP triggers MRU by default
let g:ctrlp_cmd = 'CtrlPMRU'

" toggle hex mode
" http://www.kevssite.com/2009/04/21/using-vi-as-a-hex-editor/
nnoremap <leader>h :%!xxd<CR>
nnoremap <leader>H :%!xxd -r<CR>

" Pretty-print json, uglify json
nnoremap <leader>j :%!jq .<CR>
nnoremap <leader>J :%!jq . -c<CR>

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
