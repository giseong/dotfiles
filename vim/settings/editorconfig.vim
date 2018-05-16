let g:EditorConfig_exclude_patterns = ['scp://.*']
let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']
if has ("win32")
    let g:EditorConfig_exec_path = 'C:\ProgramData\chocolatey\bin\editorconfig.exe'
else
    let g:EditorConfig_exec_path = '/usr/bin/editorconfig'
endif
