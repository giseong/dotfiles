if has("mac")
  command! Marked silent !open -a "Marked.app" "%:p"
  nnoremap <silent> <Leader>md :Marked<CR>\|:redraw!<CR>
  "if has("gui_macvim") && has("gui_running")
    "nnoremap <silent> <D-e> :Marked<CR>
  "else
    "nnoremap <silent> <Leader>e :Marked<CR>\|:redraw!<CR>
  "endif
endif

