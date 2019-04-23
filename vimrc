call plug#begin()
Plug 'tpope/vim-sensible'                           " sensible vim defaults
Plug 'justinmk/vim-dirvish'                         " alternative to vim-vinegar and netrw
Plug 'tpope/vim-fugitive'                           " git commands
Plug 'flazz/vim-colorschemes'                       " colors
Plug 'fenetikm/falcon'                              " more color
Plug 'itchyny/lightline.vim'                        " status bar
Plug 'mileszs/ack.vim'                              " search
Plug 'maxbrunsfeld/vim-yankstack'                   " copy-paste ring
Plug 'w0rp/ale'                                     " linters
Plug 'chrisbra/unicode.vim'                         " unicode characters
" Install fzf as binary-only, no bindings
Plug 'junegunn/fzf', { 'dir': '~/src/github.com/junegunn/fzf', 'do': './install --bin --64' }
Plug 'junegunn/fzf.vim'                             " fuzzy-find file/buffer names
Plug 'sgur/vim-editorconfig'                	      " editor space/tab config
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}            " distraction-free writing
Plug 'junegunn/vim-easy-align', {'on': 'EasyAlign'} " vim alignment, supports markdown tables
Plug 'fatih/vim-go', {'for': 'go'}                  " Go-specific
Plug 'ziglang/zig.vim', {'for': 'zig'}              " Zig-specific
Plug 'hashivim/vim-terraform', {'for': 'tf'}        " Terraform-specific
Plug 'cespare/vim-toml', {'for': 'toml'}            " Toml-specific
Plug 'vim-scripts/vim-hackernews', {'on': 'HackerNews'}  " HackerNews
call plug#end()

"
" Vim Configuration
"

" move viminfo outside the home dir
set viminfo+=n~/.vim/viminfo

" Modeline enabled
set modeline
set modelines=2

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
\   'javascript': ['standard', 'eslint'],
\   'c': ['cppcheck', 'clang', 'flawfinder', 'gcc'],
\   'cpp': ['cppcheck', 'clang', 'flawfinder', 'gcc'],
\}
let g:ale_fixers = {'javascript': ['standard', 'eslint']}
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1

" Set vim-go settings (see https://github.com/fatih/vim-go)
let g:go_fmt_command = "goimports"
let g:go_test_show_name = 1
let g:go_test_timeout= '30s'
" fixes lost folds on save (see https://github.com/fatih/vim-go/issues/502)
let g:go_fmt_experimental = 1
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_metalinter_command='golangci-lint'

" lightline: display relative path to file if not in current dir
function! LightlineRelativePath()
  return fnamemodify(expand("%"), ":~:.")
endfunction
let g:lightline = {
      \ 'active': {
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'relativepath': 'LightlineRelativePath'
      \ }
      \ }
" lightline+falcon: use falcon colorscheme
let g:falcon_lightline = 1
let g:lightline.colorscheme='falcon'

" dirvish: sort folders together
let g:dirvish_mode = ':sort ,^.*[\/],'

" Zig: use stage 2 compiler for formatting
let g:zig_fmt_autosave = 1
let g:zig_fmt_command = ['zig2', 'fmt', '--color', 'off']

" Terraform: fmt on save
let g:terraform_fmt_on_save = 1

"
" Key bindings
"

let mapleader = ","
nnoremap <leader>e :Dirvish<cr>

" fzf bindings
nnoremap ; :Buffers<CR>
nnoremap <leader>; :Files<CR>

" ack/ag bindings
nnoremap <leader>f :Ack --ignore-dir "vendor/"<Space>

" unicode bindings
nnoremap <leader>u :UnicodeSearch!<Space>

" wrap/nowrap
nnoremap <leader>w :setlocal wrap<cr>
nnoremap <leader>W :setlocal nowrap<cr>

" Vim-Go bindings
augroup gobindings
  autocmd!
  autocmd FileType go nmap <leader>ga <Plug>(go-alternate-vertical)
  autocmd FileType go nmap <leader>gc <Plug>(go-coverage-toggle)
  autocmd FileType go nmap <leader>gi <Plug>(go-info)
  autocmd FileType go nmap <leader>gt <Plug>(go-coverage-toggle)
  autocmd FileType go nnoremap <leader>F :Ack --ignore "*_test.go" --ignore-dir "vendor/"<Space>
  " define folds based on syntax (see vim-go help for fold options)
  "autocmd FileType go setlocal foldmethod=syntax
  " expand all folds by default
  "autocmd FileType go :normal! zR
  " set a start fold level, to prevent collapsing blocks on save of a new file
  "autocmd FileType go setlocal foldlevelstart=5
augroup END

" YankStack override of default bindings
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" EasyAlign bindings, align GitHub-flavored Markdown tables
augroup markdownbindings
  autocmd!
  autocmd FileType markdown vnoremap <leader><Bslash> :EasyAlign*<Bar><Enter>
augroup END

" automatically set the mail filetype for .mail
au BufRead,BufNewFile *.mail set filetype=mail

" Useful leader mappings
nnoremap <leader>n :tabnew<CR>

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

