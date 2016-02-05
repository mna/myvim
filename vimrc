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
Plug 'rking/ag.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'garyburd/go-explorer', {'for': 'go'}
Plug 'posva/vim-vue', {'for': 'vue'}
Plug 'tpope/vim-haml', {'for': 'sass'}
Plug 'digitaltoad/vim-jade', {'for': 'jade'}
Plug 'ryanss/vim-hackernews', {'on': 'HackerNews'}
Plug 'nicklasos/vim-jsx-riot', {'for': 'tag'}
call plug#end()

" netrw alternate vsplit
let g:netrw_altv = 1
" netrw hide some files
let g:netrw_list_hide= '.*\.sw.$,\..+'

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

" Set ag to search from project root instead of cwd
" https://github.com/rking/ag.vim
let g:ag_working_path_mode="r"

" Highlight columns > 80
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn="80,".join(range(120,999),",")

" Set vim-go settings (see https://github.com/fatih/vim-go)
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" Set syntastic settings
let g:syntastic_javascript_checkers = ["eslint"]

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
