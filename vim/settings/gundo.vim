"let g:gundo_width              = 60
let g:gundo_right              = 1
let g:gundo_preview_bottom     = 1
let g:gundo_tree_statusline    = "Gundo"
let g:gundo_preview_statusline = "Gundo Preview"
nnoremap <Leader>u :GundoToggle<CR>

"if has("gui_macvim") && has("gui_running")
  "nnoremap <D-u> :GundoToggle<CR>
"else
  "nnoremap <Leader>u :GundoToggle<CR>
"endif

