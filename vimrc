call plug#begin()
Plug 'tpope/vim-sensible'                           " sensible vim defaults
Plug 'tpope/vim-vinegar'                            " better netrw
Plug 'tpope/vim-fugitive'                           " git commands
Plug 'airblade/vim-gitgutter'                       " git state indicators
Plug 'flazz/vim-colorschemes'                       " colors
Plug 'itchyny/lightline.vim'                        " status bar
Plug 'mileszs/ack.vim'                              " search
Plug 'maxbrunsfeld/vim-yankstack'                   " copy-paste ring
Plug 'w0rp/ale'                                     " linters
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim' " fuzzy-find file/buffer names
Plug 'editorconfig/editorconfig-vim'                " editor space/tab config
Plug 'fatih/vim-go', {'for': 'go'}                  " Go-specific
Plug 'keith/swift.vim', {'for': 'swift'}            " Swift-specific
Plug 'zig-lang/zig.vim', {'for': 'zig'}             " Zig-specific
Plug 'lluchs/vim-wren', {'for': 'wren'}             " Wren-specific
Plug 'ryanss/vim-hackernews', {'on': 'HackerNews'}  " HackerNews
call plug#end()

"
" Vim Configuration
"

" Persistent, cross-session undos
set undofile
set undodir=~/.vim/undo

" Set both number and relative number:
" http://jeffkreeftmeijer.com/2013/vims-new-hybrid-line-number-mode/
set relativenumber
set number

" color scheme
colorscheme default

" prevent vim from showing -- INSERT -- (already show in status bar)
set noshowmode

" refresh rate
set updatetime=300

" Set vim to recognize .md as markdown
au BufRead,BufNewFile *.md set filetype=markdown

"
" Plugin Configuration
"

" editorconfig setup
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" ack.vim setup
let g:ackprg = 'ag --vimgrep'

" ALE setup - check only on save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

" Set ag to search from project root instead of cwd
" https://github.com/rking/ag.vim
let g:ag_working_path_mode="r"

" Set vim-go settings (see https://github.com/fatih/vim-go)
let g:go_fmt_command = "goimports"

" gitgutter: do not configure any key binding
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_added = '•'
let g:gitgutter_sign_modified = '•'
let g:gitgutter_sign_removed = '•'
let g:gitgutter_sign_removed_first_line = '•'
let g:gitgutter_sign_modified_removed = '•'

"
" Key bindings
"

let mapleader = ","
nnoremap <leader>e :Explore<cr>

" fzf bindings
nmap ; :Buffers<CR>
nmap <Leader>; :Files<CR>

" ack/ag bindings
nmap <Leader>f :Ack<Space>

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
nnoremap <leader>sd :colorscheme default<CR>

