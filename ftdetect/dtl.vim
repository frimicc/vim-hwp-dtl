autocmd BufNewFile,BufRead *.dtl
      \ if &ft =~# '^\%(conf\|modula2\)$' |
      \   set ft=dtl |
      \ else |
      \   setf dtl |
      \ endif
