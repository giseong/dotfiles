if has("gui_macvim")
    function! DistractionFreeWriting()
        set number!
        set columns=120
        set linespace=5
        set fuoptions=maxvert
        set laststatus=0                   " don't show status line
        "set guifont=Cousine:h16

        set fullscreen                     " go to fullscreen editing mode
    endfunction

    function! ToggleDistractionFreeWriting()
        if &laststatus
            let s:prev_columns = &columns
            let s:prev_linespace = &linespace
            let s:prev_fuoptions = &fuoptions
            let s:prev_laststatus = &laststatus
            "let s:prev_guifont = &guifont

            call DistractionFreeWriting()
        else
            exec "set columns=".s:prev_columns
            exec "set linespace=".s:prev_linespace
            exec "set fuoptions=".s:prev_fuoptions
            exec "set laststatus=".s:prev_laststatus
            "exec "set guifont=".s:prev_guifont

            set number
            set fullscreen!
        endif
    endfunction

    map <F7> :call ToggleDistractionFreeWriting()<CR>
endif

