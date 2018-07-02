let g:buffergator_viewport_split_policy = "B"
let g:buffergator_split_size            = 10
let g:buffergator_suppress_keymaps      = 1

nnoremap <Leader>be :BuffergatorOpen<CR>

"if has("gui_macvim") && has("gui_running")
  "nnoremap <D-t> :BuffergatorOpen<CR>
"else
  "nnoremap <Leader>t :BuffergatorOpen<CR>
"endif

