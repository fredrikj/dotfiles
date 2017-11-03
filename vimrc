source ~/.vimrc.common

filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"   " The following are examples of different formats supported.
"   " Keep Plugin commands between vundle#begin/end.
"   " plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
"   " plugin from http://vim-scripts.org/vim/scripts.html
"   Plugin 'L9'
"   " Git plugin not hosted on GitHub
"   Plugin 'git://git.wincent.com/command-t.git'
"   " git repos on your local machine (i.e. when working on your own plugin)
"   Plugin 'file:///home/gmarik/path/to/plugin'
"   " The sparkup vim script is in a subdirectory of this repo called vim.
"   " Pass the path to set the runtimepath properly.
"   Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"   " Avoid a name conflict with L9
"   Plugin 'user/L9', {'name': 'newL9'}

Plugin 'jelera/vim-javascript-syntax'

Plugin 'Valloric/YouCompleteMe'
Plugin 'marijnh/tern_for_vim'
Plugin 'scrooloose/nerdTree'
Plugin 'albfan/nerdtree-git-plugin'
Plugin 'yegappan/grep'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/gitignore'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'JamshedVesuna/vim-markdown-preview'

Plugin 'scrooloose/syntastic'
Plugin 'leafgarland/typescript-vim'
Plugin 'jbnicolai/vim-AnsiEsc'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()            " required

" Ultisnips: Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let vim_markdown_preview_github=1
let vim_markdown_preview_toggle=2

" typescript compilation
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Syntastic settings -------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

function! HasConfig(file, dir)
    return findfile(a:file, escape(a:dir, ' ') . ';') !=# ''
endfunction

autocmd BufNewFile,BufReadPre *.js  let b:syntastic_checkers =
    \ HasConfig('.eslintrc', expand('<amatch>:h')) ? ['eslint'] :
    \ HasConfig('.jshintrc', expand('<amatch>:h')) ? ['jshint'] :
    \     ['standard']
"----------------------------------------------

" Automatically start NERDTree when Vim starts
"autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" Removed text type from the default ycm blacklist.
let g:ycm_filetype_blacklist = {'notes': 1, 'markdown': 1, 'unite': 1, 'tagbar': 1, 'pandoc': 1, 'qf': 1, 'vimwiki': 1, 'infolog': 1, 'mail': 1}

let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_autoclose_preview_window_after_insertiona = 1




" ~/.vimrc (configuration file for vim only)
" skeletons
function! SKEL_spec()
	0r /usr/share/vim/current/skeletons/skeleton.spec
	language time en_US
	let login = system('whoami')
	if v:shell_error
	   let login = 'unknown'
	else
	   let newline = stridx(login, "\n")
	   if newline != -1
		let login = strpart(login, 0, newline)
	   endif
	endif
	let hostname = system('hostname -f')
	if v:shell_error
	    let hostname = 'localhost'
	else
	    let newline = stridx(hostname, "\n")
	    if newline != -1
		let hostname = strpart(hostname, 0, newline)
	    endif
	endif
	exe "%s/specRPM_CREATION_DATE/" . strftime("%a\ %b\ %d\ %Y") . "/ge"
	exe "%s/specRPM_CREATION_AUTHOR_MAIL/" . login . "@" . hostname . "/ge"
	exe "%s/specRPM_CREATION_NAME/" . expand("%:t:r") . "/ge"
endfunction
autocmd BufNewFile	*.spec	call SKEL_spec()
" ~/.vimrc ends here
"""
""" SETTINGS
"""
set autoindent
set backspace=indent,eol,start
set encoding=utf8
set expandtab
set fileencoding=utf8
set fileformat=unix
set fileformats=unix
set hlsearch
set linebreak
set modeline
set mouse=
set nobackup
set nocindent
set wrap
set nowrapscan
set ruler
set scrolloff=10
set shiftwidth=2 "indentation size
set showbreak=>>\ 
set showcmd
if version >= 700
    set showtabline=2
endif
set notitle
set smartindent 
set softtabstop=4
set tabstop=4
set tags=$HOME/.ctagsfile
"set textwidth=78
set titlestring=vim\ [%f]
set vb t_vb=
set viminfo=
set number
set foldenable
set foldmethod=indent
set ignorecase
set incsearch
"set shell=bash\ --login "to source .bashrc when running command
set shell=zsh

"""
""" xterm
"""
if match($TERM, "screen")!=-1
  set term=xterm
endif
if &term =~ "xterm"
  if has("terminfo")
	set t_Co=256
	set t_Sf=<Esc>[3%p1%dm
	set t_Sb=<Esc>[4%p1%dm
  else
	set t_Co=256
	set t_Sf=<Esc>[3%dm
	set t_Sb=<Esc>[4%dm
  endif
endif
"""
""" KEY MAPPINGS
"""
nnoremap ; :w<CR>
nnoremap J <C-w>j
nnoremap K <C-w>k
nnoremap H <C-w>h
nnoremap L <C-w>l 
"nnoremap <CR> :nohlsearch<CR>

"nnoremap M <C-w>_<C-w>\|
nnoremap <S-Up> <C-w>_
nnoremap <S-Right> <C-w>\|
nnoremap <S-Left> <C-w>=
nnoremap <S-Down> <C-w>=

nmap ,e :Explore<cr>
nmap ,t :tabnew<cr>

" Open a file under the cursor in a new split
nmap gf :sp <cfile><CR>nzo

"""
""" NetRW settings
"""
let g:netrw_list_hide="\.gz"
let g:netrw_ftp_cmd="/usr/bin/ftp -p "
let g:netrw_uid="glasp"
let lpc_syntax_for_c = 1
let lpc_pre_v22 = 1
let g:netrw_longlist=2
"""
""" Color load
"""
syntax on
colorscheme fkj
set cursorline
"hi CursorLine   cterm=NONE ctermbg=lightyellow ctermfg=black guibg=lightyellow guifg=black
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
autocmd InsertEnter * setlocal nocursorline
autocmd InsertLeave * setlocal cursorline


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""       Get command output in a vim buffer
function! s:ExecuteInShell(command, bang)
	let _ = a:bang != '' ? s:_ : a:command == '' ? '' : join(map(split(a:command), 'expand(v:val)'))

	if (_ != '')
		let s:_ = _
		let bufnr = bufnr('%')
		let winnr = bufwinnr('^' . _ . '$')
		silent! execute  winnr < 0 ? 'belowright new ' . fnameescape(_) : winnr . 'wincmd w'
		setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile wrap number
		silent! :%d
		let message = 'Execute ' . _ . '...'
		call append(0, message)
		echo message
		silent! 2d | resize 1 | redraw
		silent! execute 'silent! %!'. _
		silent! execute 'resize ' . line('$')
		silent! execute 'syntax on'
		silent! execute 'autocmd BufUnload <buffer> execute bufwinnr(' . bufnr . ') . ''wincmd w'''
		silent! execute 'autocmd BufEnter <buffer> execute ''resize '' .  line(''$'')'
		silent! execute 'nnoremap <silent> <buffer> <CR> :call <SID>ExecuteInShell(''' . _ . ''', '''')<CR>'
		silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . _ . ''', '''')<CR>'
		silent! execute 'nnoremap <silent> <buffer> <LocalLeader>g :execute bufwinnr(' . bufnr . ') . ''wincmd w''<CR>'
		nnoremap <silent> <buffer> <C-W>_ :execute 'resize ' . line('$')<CR>
		silent! syntax on
	endif
endfunction

command! -complete=shellcmd -nargs=* -bang Shell call s:ExecuteInShell(<q-args>, '<bang>')
cabbrev shell Shell

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap qu :q<CR>
nnoremap qi :q<CR>
nnoremap zi :q<CR>

"set statusline=%<%w%f\ %=%y[%{&ff}][%6c][%{printf('%'.strlen(line('$')).'s',line('.'))}/%L][%3p%%]%{'['.(&readonly?'RO':'\ \ ').']'}%{'['.(&modified?'+':'-').']'}

" Padding a line to length 80:
":%s/.*/\=printf('%-80s', submatch(0))
" Even better, for non ascii situations:
":%s/$/\=repeat(' ',81-virtcol('$'))

cabbrev lv
      \ lvim /\<lt><C-R><C-W>\>/gj
      \ **/*<C-R>=(expand("%:e")=="" ? "" : ".".expand("%:e"))<CR>
      \ <Bar> lw
      \ <C-Left><C-Left><C-Left>
"nmap g :lv<CR>

function AddCheckpoints()
  let i=1 | g/;/s//\=";logcrit('checkpoint ".i."');"/ | let i=i+1
endfunction

nmap cp $alogcrit("Fredrik checkpoint ");<Esc>2hi
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" vim -b : edit binary using xxd-format!
" But it doesn't work! In some magical way it goes back to the original text when exiting xxd mode. How?
" It does work! You're supposed to edit the hex code! Not the text display of it to the right!
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

set dir=/Users/fred/.vim/swapfiles  " Put swp,swo,swn,... files there
"map <C>r :set paste<CR>o<esc>"*]p:set nopaste<cr>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

nnoremap <silent> * :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<CR>
  \:call histadd("/",@/)<CR>

nmap ) *:Egrep -Irnsa  --exclude-dir={tmp,log,.svn,.git,node_modules,lib} --exclude={'*.min.*','*.map'} <C-r>/ *<CR>
vmap ) *:Egrep -Irnsa  --exclude-dir={tmp,log,.svn,.git,node_modules,lib} --exclude={'*.min.*','*.map'} <C-r>/ *<CR>
nmap ( *:Egrep -Irinsa --exclude-dir={tmp,log,.svn,.git,node_modules,lib} --exclude={'*.min.*','*.map'}
