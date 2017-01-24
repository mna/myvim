call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-vinegar'
Plug 'flazz/vim-colorschemes'
Plug 'bling/vim-airline'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'rking/ag.vim'
Plug 'yuratomo/w3m.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'keith/swift.vim', {'for': 'swift'}
Plug 'ryanss/vim-hackernews', {'on': 'HackerNews'}
call plug#end()

" toggle cursor appearance, see
" https://github.com/neovim/neovim/wiki/FAQ#how-can-i-change-the-cursor-shape-in-the-terminal
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Persistent, cross-session undos
set undofile
set undodir=~/.vim/undo

" Tabs : http://stackoverflow.com/questions/1878974/redefine-tab-as-4-spaces
" set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

" editorconfig setup
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
" let g:EditorConfig_exec_path = '/usr/bin/editorconfig'

colorscheme 256_noir

" Set both number and relative number:
" http://jeffkreeftmeijer.com/2013/vims-new-hybrid-line-number-mode/
set relativenumber
set number

" Set vim to recognize .md as markdown
au BufRead,BufNewFile *.md set filetype=markdown

" Set ag to search from project root instead of cwd
" https://github.com/rking/ag.vim
let g:ag_working_path_mode="r"

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
" run compiler/checker
nnoremap <leader>k :silent make!\|redraw!\|cc<CR>
" open/close quick fix window
nnoremap <leader>c :copen<CR>
nnoremap <leader>C :cclose<CR>
" switch color scheme
nnoremap <leader>sl :colorscheme lucius<CR>
nnoremap <leader>sd :colorscheme 256_noir<CR>

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

