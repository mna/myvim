call plug#begin()
Plug 'mna/quickmenu.vim'                            " discoverable keybindings via menu
Plug 'tpope/vim-sensible'                           " sensible vim defaults
Plug 'justinmk/vim-dirvish'                         " alternative to vim-vinegar and netrw
Plug 'Valloric/ListToggle'                          " toggle loclist and quickfix
Plug 'tpope/vim-fugitive'                           " git commands
Plug 'flazz/vim-colorschemes'                       " colors
Plug 'fenetikm/falcon'                              " more color
Plug 'itchyny/lightline.vim'                        " status bar
Plug 'mileszs/ack.vim'                              " search
Plug 'maxbrunsfeld/vim-yankstack'                   " copy-paste ring
Plug 'dense-analysis/ale'                           " linters
Plug 'chrisbra/unicode.vim'                         " unicode characters
" Install fzf as binary-only, no bindings
Plug 'junegunn/fzf', { 'dir': '~/src/github.com/junegunn/fzf', 'do': './install --bin --64' }
Plug 'junegunn/fzf.vim'                             " fuzzy-find file/buffer names
Plug 'sgur/vim-editorconfig'                	      " editor space/tab config
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}            " distraction-free writing
Plug 'junegunn/vim-easy-align', {'on': 'EasyAlign'} " vim alignment, supports markdown tables
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

" disable bell beep
set belloff=all

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

" quickmenu setup
let g:quickmenu_options = "HL"
let g:quickmenu_disable_nofile = 0
source ~/.vim/quickmenu.vim

" ListToggle setup
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>c'

" ALE setup - check only on save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_open_list = 'on_save'
let g:ale_set_loclist = 1
let g:ale_sign_highlight_linenrs = 1
let g:ale_sign_warning = '•'
let g:ale_sign_error = '•'
let g:ale_completion_enabled = 1
let g:ale_completion_delay = 200
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
highlight ALEWarningSign ctermfg=Yellow guifg=Yellow
highlight ALEErrorSign ctermfg=Red guifg=Red

" ALE setup of linters and fixers
let g:ale_linters = {
\   'javascript': ['standard', 'eslint'],
\   'c': ['cppcheck', 'clang', 'flawfinder', 'gcc'],
\   'cpp': ['cppcheck', 'clang', 'flawfinder', 'gcc'],
\   'go': ['gopls', 'golangci-lint'],
\}
let g:ale_fixers = {
\   'javascript': ['standard', 'eslint'],
\   'go': ['goimports'],
\}

" ALE Go setup
let g:ale_go_golangci_lint_options = ''
let g:ale_go_golangci_lint_package = 1

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

" automatically set the mail filetype for .mail
au BufRead,BufNewFile *.mail set filetype=mail

"
" Key bindings
"

let mapleader = ","
nnoremap <leader>tn :tabnew<CR>
" disable entering ex-mode
nnoremap Q <nop>
" dirvish binding
nnoremap <leader>e :Dirvish<cr>
" quickmenu binding
nnoremap <silent><space> :call quickmenu#bottom(0)<cr>
" fzf bindings
nnoremap ; :Buffers<CR>
nnoremap <leader>; :Files<CR>
nnoremap <leader>R :History<CR>
" ack/ag bindings
nnoremap <leader>f :Ack --ignore-dir "vendor/"<Space>
" unicode bindings
nnoremap <leader>u :UnicodeSearch!<Space>
" wrap/nowrap
nnoremap <leader>w :setlocal wrap<cr>
nnoremap <leader>W :setlocal nowrap<cr>
" YankStack override of default bindings
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste
" next/previous loclist (error)
nnoremap <silent> <leader>n :lnext<CR>
nnoremap <silent> <leader>N :lprev<CR>
" Pretty-print json, uglify json
nnoremap <leader>j :%!jq .<CR>
nnoremap <leader>J :%!jq . -c<CR>
" Pretty-print html
nnoremap <leader>m :%!tidy -qi --show-errors 0 --show-warnings false<CR>
" switch color scheme
nnoremap <leader>sl :colorscheme lightning<CR>
nnoremap <leader>sd :colorscheme falcon<CR>

" Go-specific bindings
augroup gobindings
  autocmd!
  autocmd FileType go nnoremap gd :ALEGoToDefinition<CR>
  autocmd FileType go nnoremap <leader>gr :ALERename<CR>
  autocmd FileType go nnoremap <leader>gu :ALEFindReferences<CR>
  "autocmd FileType go nmap <leader>ga <Plug>(go-alternate-vertical)
  "autocmd FileType go nmap <leader>a :GoAlternate<cr>
  "autocmd FileType go nmap <leader>gc <Plug>(go-coverage-toggle)
  "autocmd FileType go nmap <leader>gi <Plug>(go-info)
  "autocmd FileType go nmap <leader>gt <Plug>(go-coverage-toggle)
  autocmd FileType go nnoremap <leader>F :Ack --ignore "*_test.go" --ignore-dir "vendor/"<Space>
augroup END

" EasyAlign bindings, align GitHub-flavored Markdown tables
augroup markdownbindings
  autocmd!
  autocmd FileType markdown vnoremap <leader><Bslash> :EasyAlign*<Bar><Enter>
augroup END

