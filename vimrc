call plug#begin()
Plug 'tpope/vim-sensible'                           " sensible vim defaults
Plug 'justinmk/vim-dirvish'                         " alternative to vim-vinegar and netrw
Plug 'tpope/vim-fugitive'                           " git commands
Plug 'flazz/vim-colorschemes'                       " colors
Plug 'fenetikm/falcon'                              " more color
Plug 'itchyny/lightline.vim'                        " status bar
Plug 'sheerun/vim-polyglot'                         " multi-languages syntax and indent
Plug 'mileszs/ack.vim'                              " search
Plug 'maxbrunsfeld/vim-yankstack'                   " copy-paste ring
Plug 'w0rp/ale'                                     " linters
Plug 'rhysd/vim-clang-format'                       " clang auto-format
Plug 'chrisbra/unicode.vim'                         " unicode characters
" Install fzf as binary-only, no bindings
Plug 'junegunn/fzf', { 'dir': '~/src/github.com/junegunn/fzf', 'do': './install --bin --64' }
Plug 'junegunn/fzf.vim'                             " fuzzy-find file/buffer names
Plug 'editorconfig/editorconfig-vim'                " editor space/tab config
Plug 'junegunn/goyo.vim'                            " distraction-free writing
Plug 'junegunn/vim-easy-align'                      " vim alignment, supports markdown tables
Plug 'fatih/vim-go', {'for': 'go'}                  " Go-specific
Plug 'zig-lang/zig.vim'                             " Zig-specific
Plug 'vim-scripts/vim-hackernews', {'on': 'HackerNews'}  " HackerNews
call plug#end()

"
" Vim Configuration
"

" Modeline enabled
set modeline
set modelines=1

" Persistent, cross-session undos
set undofile
set undodir=~/.vim/undo

" Set both number and relative number:
" http://jeffkreeftmeijer.com/2013/vims-new-hybrid-line-number-mode/
set relativenumber
set number

" color scheme
colorscheme falcon
" termguicolors required for falcon theme
set termguicolors

" prevent vim from showing -- INSERT -- (already show in status bar)
set noshowmode

" refresh rate
set updatetime=300

" For cursor shapes on VTE-compatible terminals
" See http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

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
let g:ale_linters = {
\   'javascript': ['standard'],
\   'c': ['cppcheck', 'clang', 'flawfinder', 'gcc'],
\   'cpp': ['cppcheck', 'clang', 'flawfinder', 'gcc'],
\}

" vim-clang-format settings
let g:clang_format#code_style = "chromium"
let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 1

" Set vim-go settings (see https://github.com/fatih/vim-go)
let g:go_fmt_command = "goimports"

" lightline: display relative path to file if not in current dir
let g:lightline = {
      \ 'active': {
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'readonly', 'relativepath', 'modified' ] ]
      \ }
      \ }
" lightline+falcon: use falcon colorscheme
let g:falcon_lightline = 1
let g:lightline.colorscheme='falcon'

" dirvish: sort folders together
let g:dirvish_mode = ':sort ,^.*[\/],'

"
" Key bindings
"

let mapleader = ","
nnoremap <leader>e :Dirvish<cr>

" fzf bindings
nmap ; :Buffers<CR>
nmap <Leader>; :Files<CR>

" ack/ag bindings
nmap <Leader>f :Ack<Space>

" unicode bindings
nmap <Leader>u :UnicodeSearch!<Space>

" Vim-Go bindings
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <Leader>gi <Plug>(go-implements)
au FileType go nmap <Leader>gr <Plug>(go-rename)
au FileType go nmap <Leader>gd <Plug>(go-doc-vertical)

" YankStack override of default bindings
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste
let g:yankstack_map_keys = 0

" EasyAlign bindings, align GitHub-flavored Markdown tables
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

" Useful leader mappings
nnoremap <leader>n :tabnew<CR>

" toggle hex mode
" http://www.kevssite.com/2009/04/21/using-vi-as-a-hex-editor/
nnoremap <leader>h :%!xxd<CR>
nnoremap <leader>H :%!xxd -r<CR>

" Pretty-print json, uglify json
nnoremap <leader>j :%!jq .<CR>
nnoremap <leader>J :%!jq . -c<CR>

" Pretty-print html
nnoremap <leader>m :%!tidy -qi --show-errors 0 --show-warnings false<CR>

" open/close quick fix window
nnoremap <leader>c :copen<CR>
nnoremap <leader>C :cclose<CR>

" open/close location window
nnoremap <leader>l :lopen<CR>
nnoremap <leader>L :lclose<CR>

" close scratch (preview) window
nnoremap <leader>S :pclose<CR>

" switch color scheme
nnoremap <leader>sl :colorscheme lucius<CR>
nnoremap <leader>sd :colorscheme falcon<CR>

