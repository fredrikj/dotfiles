if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-sensible'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""
" Common appearance/behavior
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
set number            " number lines
set foldmethod=indent " automatically create fold on indentation
set ignorecase        " ignore case when searcing
set cursorline        " underline where cursor is
set clipboard=unnamed " Use system clipboard for yank/paste
set fileformat=unix   " Use line endings <NL>
set linebreak         " wrap long lines at a character in 'breakat'
set showbreak=>>\     " String to put at the start of lines that have been wrapped.
set nowrapscan        " do not wrap search around end of file
set shiftwidth=2      " indentation size
set showtabline=2     " Always show tab label
set smartindent       " Do smart autoindenting (C style) when starting a new line.
set visualbell        " Use visual bell instead of beeping.
set shell=zsh         " Use zsh
set wildignore=node_modules

""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY MAPPINGS
" Closing
nnoremap qi :q<CR>
" Saving
nnoremap ; :w<CR>
" Split navigation
nnoremap J <C-w>j
nnoremap K <C-w>k
nnoremap H <C-w>h
nnoremap L <C-w>l 
" Split resizing
nnoremap <S-Up> <C-w>_
nnoremap <S-Right> <C-w>\|
nnoremap <S-Left> <C-w>=
nnoremap <S-Down> <C-w>=
" Question mark to look up documentation
nnoremap ? K

""""""""""""""""""""""""""""""""""""""""""""""""""
