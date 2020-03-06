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

function! MySetColorschemeLight()
  execute('colorscheme ' . g:my_colorscheme_light)
  let g:lightline.colorscheme=g:my_colorscheme_light
  let g:falcon_lightline = 0
endfunction

function! MySetColorschemeDark()
  execute('colorscheme ' . g:my_colorscheme_dark)
  let g:lightline.colorscheme=g:my_colorscheme_dark
  let g:falcon_lightline = 1
endfunction

function! MyToggleColorscheme()
  let current = trim(execute('colorscheme'))
  if current == g:my_colorscheme_dark
    call MySetColorschemeLight()
  else
    call MySetColorschemeDark()
  endif
endfunction

function! MySearchInFiles(word='', opts='')
  call feedkeys(':Ack ' . a:opts . ' ' . a:word, 'n')
  if a:word != ''
    call feedkeys("\<cr>", 'n')
  endif
endfunction

function! MyDeleteCurrentBufferFile()
  let file = expand("%")
  let res = confirm('Delete ' . file . ' ?', "&Yes\n&No", 1)
  if res == 1
    call delete(expand("%"))|bdelete!
  endif
endfunction

function! MyUnicodeSearch()
  call feedkeys(':UnicodeSearch! ', 'n')
endfunction

function! MySearchGoCode(word='')
  call feedkeys(':Ack --file-search-regex ".+\.go" --ignore "*_test.go" --ignore-dir "vendor/" ', 'n')
  if a:word != ''
    call feedkeys("--word-regexp " . a:word . "\<cr>", 'n')
  endif
endfunction

function! MyGoAlternateFile()
  let file = expand("%")
  if file =~ '_test\.go$'
    let file = substitute(file, '_test\.go$', '.go', '')
  elseif file =~ '\.go$'
    let file = substitute(file, '\.go$', '_test.go', '')
  else
    return
  endif
  execute('edit ' . file)
endfunction

function! MyCurrentFuncName()
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bWn'))
  echohl None
endfun

function! MyGoCoverageInBrowser()
  let l:tmpname = tempname()
  let l:result = system('go test -coverprofile ' . l:tmpname)
  if v:shell_error == 0
    call system('go tool cover -html=' . l:tmpname)
  endif
  call delete(l:tmpname)
endfunction

function! MyToggleTerminal()
  let l:terms = filter(range(1, bufnr('$')), 'getbufvar(v:val, "&buftype") == "terminal"')
  let l:visterms = filter(copy(l:terms), 'bufwinnr(v:val) != -1')
  if len(l:visterms) > 0
    execute(l:visterms[0] . "wincmd w")
  elseif len(l:terms) > 0
    execute('botright sbuffer ' . l:terms[0])
  else
    let l:wd = expand('%:p:h')
    botright call term_start('bash', {'cwd': l:wd})
  endif
endfunction
