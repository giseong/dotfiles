" Toggle spell with a language. {{{
function! ToggleSpell(lang)
    if !exists("b:old_spelllang")
        let b:old_spelllang = &spelllang
        let b:old_spellfile = &spellfile
        let b:old_dictionary = &dictionary
    endif

    let l:newMode = ""
    if !&l:spell || a:lang != &l:spelllang
        setlocal spell
        let l:newMode = "spell"
        execute "setlocal spelllang=" . a:lang
        execute "setlocal spellfile=" . "~/.vim/spell/" . matchstr(a:lang, "[a-zA-Z][a-zA-Z]") . "." . &encoding . ".add"
        execute "setlocal dictionary=" . "~/.vim/spell/" . a:lang . "." . &encoding . ".dic"
        let l:newMode .= ", " . a:lang
    else
        setlocal nospell
        let l:newMode = "nospell"
        execute "setlocal spelllang=" . b:old_spelllang
        execute "setlocal spellfile=" . b:old_spellfile
        execute "setlocal dictionary=" . b:old_dictionary
    endif
    return l:newMode
endfunction
" }}}
nmap <silent> <F6> :echo ToggleSpell("en_us")<CR>

