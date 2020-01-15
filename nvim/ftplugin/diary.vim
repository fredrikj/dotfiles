set textwidth=80
nnoremap O :let starttime=system("date +%s")<CR>o<Esc>80i-<Esc>o<Esc>!!date<CR>ISTART AT: <Esc>o
nnoremap U o<Esc>"=(system("date +%s")-starttime)<CR>pIEND AFTER <Esc>A SECONDS<CR><Esc>

