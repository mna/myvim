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
"Plug 'dense-analysis/ale'                           " linters
Plug '~/src/github.com/mna/ale'                     " local fork of ale
Plug 'chrisbra/unicode.vim'                         " unicode characters
" Install fzf as binary-only, no bindings
Plug 'junegunn/fzf', { 'dir': '~/src/github.com/junegunn/fzf', 'do': './install --bin --64' }
Plug 'junegunn/fzf.vim'                             " fuzzy-find file/buffer names
Plug 'sgur/vim-editorconfig'                	      " editor space/tab config
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}            " distraction-free writing
Plug 'junegunn/vim-easy-align', {'on': 'EasyAlign'} " vim alignment, supports markdown tables
Plug 'vim-scripts/vim-hackernews', {'on': 'HackerNews'}  " HackerNews
Plug 'arrufat/vala.vim', {'for': 'vala'}
call plug#end()

" ###############################################
" Constant definitions
" ###############################################
const g:my_colorscheme_dark = 'falcon'
const g:my_colorscheme_light = 'lightning'
source ~/.vim/functions.vim

" ###############################################
" Vim Configuration
" ###############################################

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

" color scheme, dark by default
call MySetColorschemeDark()
" termguicolors required for falcon theme
set termguicolors

" prevent vim from showing -- INSERT -- (already show in status bar)
set noshowmode

" refresh rate
set updatetime=300

" prevent windows resizing when windows get open/close (maintain current
" sizes)
set noequalalways

" For cursor shapes on VTE-compatible terminals
" See http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" automatically set the mail filetype for .mail
au BufRead,BufNewFile *.mail set filetype=mail

" ###############################################
" Plugin Configuration
" ###############################################

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
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_filetype_changed = 0

let g:ale_open_list = 0 "too annoying when 'on_save'
let g:ale_set_loclist = 1
let g:ale_sign_highlight_linenrs = 1
let g:ale_sign_warning = '•'
let g:ale_sign_error = '•'
highlight ALEWarningSign ctermfg=Yellow guifg=Yellow
highlight ALEErrorSign ctermfg=Red guifg=Red
highlight link ALEError Error

let g:ale_completion_enabled = 1
let g:ale_completion_delay = 200
set omnifunc=ale#completion#OmniFunc
set completeopt=menu,menuone,preview,noselect,noinsert

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

" dirvish: sort folders together
let g:dirvish_mode = ':sort ,^.*[\/],'

" ###############################################
" Key bindings
" ###############################################

let mapleader = ","

" hide terminal
tnoremap <C-q> <C-W>:hide<cr>
" exit terminal
tnoremap <C-d> <C-W>:bdelete!<cr>
" enter normal mode (vs terminal mode) using esc as for standard buffers
tnoremap <Esc> <C-\><C-n>
" forward arrow keys (escape sequences) to terminal
tmap <expr> <Esc>]A MySendTerm("\<Esc>]A")
tmap <expr> <Esc>]B MySendTerm("\<Esc>]B")

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
nnoremap <leader>sl :call MySetColorschemeLight()<cr>
nnoremap <leader>sd :call MySetColorschemeDark()<cr>
" surround word in quotes (https://stackoverflow.com/a/2148221/1094941)
nnoremap <Leader>q" ciw""<Esc>P
nnoremap <Leader>q' ciw''<Esc>P
nnoremap <Leader>q` ciw``<Esc>P
nnoremap <Leader>qd daW"=substitute(@@,"'\\\|\"","","g")<CR>P

" Go-specific bindings
augroup gobindings
  autocmd!
  autocmd FileType go nnoremap gd :ALEGoToDefinition<CR>
  autocmd FileType go nnoremap <leader>gr :ALERename<CR>
  autocmd FileType go nnoremap <leader>gu :ALEFindReferences<CR>
  autocmd FileType go nmap <leader>ga :call MyGoAlternateFile()<cr>
  autocmd FileType go nmap <leader>gc :call MyGoCoverageInBrowser()<cr>
  autocmd FileType go nnoremap <leader>F :Ack --ignore "*_test.go" --ignore-dir "vendor/"<Space>
augroup END

" EasyAlign bindings, align GitHub-flavored Markdown tables
augroup markdownbindings
  autocmd!
  autocmd FileType markdown vnoremap <leader><Bslash> :EasyAlign*<Bar><Enter>
augroup END

