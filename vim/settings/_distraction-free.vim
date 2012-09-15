function! DistractionFreeWriting()
  set columns=100
  set fuoptions=maxvert
  set laststatus=0                   " don't show status line
  set fullscreen                     " go to fullscreen editing mode
endfunction

function! ToggleDistractionFreeWriting()
  if &laststatus
    let s:prev_columns = &columns
    let s:prev_fuoptions = &fuoptions
    let s:prev_laststatus = &laststatus

    call DistractionFreeWriting()
  else
    exec "set columns=".s:prev_columns
    exec "set fuoptions=".s:prev_fuoptions
    exec "set laststatus=".s:prev_laststatus

    set fullscreen!
  endif
endfunction

if has("gui_running")
  map <F2> :call ToggleDistractionFreeWriting()<CR>
endif

