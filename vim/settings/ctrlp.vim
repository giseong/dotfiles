let g:ctrlp_root_markers        = ['.tags','tags']
let g:ctrlp_match_window_bottom = 1
let g:ctrlp_by_filename         = 1
let g:ctrlp_follow_symlinks     = 1
let g:ctrlp_dotfiles            = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_custom_ignore       = {
      \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.neocon$\|\.backups$',
      \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$',
      \ }

"if has("gui_macvim") && has("gui_running")
"let g:ctrlp_map     = '<D-p>'
"nnoremap <D-r>      :CtrlPBufTag<CR>
"else
"let g:ctrlp_map     = '<Leader>p'
"nnoremap <Leader>r :CtrlPBufTag<CR>
"endif

"let g:ctrlp_map     = '<Leader>cp'
nnoremap <silent> <Leader>bt :CtrlPBufTag<CR>
nnoremap <silent> <Leader>be :CtrlPBuffer<CR>

let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }

func! MyCtrlPMappings()
  nnoremap <buffer> <silent> <c-@> :call <sid>DeleteBuffer()<cr>
endfunc

func! s:DeleteBuffer()
  let line = getline('.')
  let bufid = line =~ '\[\d\+\*No Name\]$' ? str2nr(matchstr(line, '\d\+'))
        \ : fnamemodify(line[2:], ':p')
  exec "bd" bufid
  exec "norm \<F5>"
endfunc
