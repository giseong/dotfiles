" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.backups > /dev/null 2>&1
set undodir=~/.backups
set undofile

