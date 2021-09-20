" GENERAL & APPEARANCE -------------------------------------------------------

" Do no weird things and welcome to the 21st century
set nocompatible

" Enable command completion
set wildmenu

" Always show at least 5 lines above/below cursor when available
set scrolloff=5

" Show command in the bottom right as you type
set showcmd

" Underscore the current line the cursor is on
set cursorline

" Detect file type; load filetype plugin and indent setting
filetype plugin indent on

" Activate lexical coloring
syntax on

" Supply text color suitable for a dark background
set background=dark

" FILE -----------------------------------------------------------------------

" Save undo history
" set undofile

" Remember 100 operations
" set history=100

" TODO Add support for undo, swap, and backup dir

" Make a backup before overwriting a file
set writebackup

" Do not save that backup file upon successful overwrite
set nobackup

" Make a swap file to prepare for a crash
set swapfile

" Update the swap file every 200 characters
set updatecount=200

" Update working directory to directory containing current file
set autochdir

" Update file if changed outside Vim
set autoread

" LINE NUMBER ----------------------------------------------------------------

" Display line numbers
set number

" Display line number as difference from current line
set relativenumber

" Color the line numbers grey
highlight LineNr ctermfg=grey

" WIDTH & WRAP ---------------------------------------------------------------

" Keep your line within 80 chars
set colorcolumn=81

" Break lines longer than 78. This gets automatically set to 78 by vim anyways
set textwidth=78

" Do not horizontally extend a line past screen boundary
set wrap

" Do not break words over lines
set linebreak

" Mark the beginning of a wrapped line
set showbreak=↳

" INDENT ---------------------------------------------------------------------

" Indent wrapped lines to preserve horizontal blocks
set breakindent

" Inherit indentation from preceding line
set autoindent

" Indent based on language of current document
set smartindent

" TABS & SPACES --------------------------------------------------------------

" Store tabs as spaces
set expandtab

" One tab inputs four spaces
set tabstop=4

" Setting softtabstop=tabstop thus effectively disabling soft tabs
set softtabstop=4

" >, <, and = all shift/reindent by 4 spaces per level
set shiftwidth=4

" SEARCH ---------------------------------------------------------------------

" Incrementally show search results while typing the search term
set incsearch

" Highlight search results throughout text
set hlsearch

" Ignore case when searching
set ignorecase

" TAB PAGES ------------------------------------------------------------------

" <Leader><n> to switch to tab <n>
map <Leader>1 :tabn 1<CR>
map <Leader>2 :tabn 2<CR>
map <Leader>3 :tabn 3<CR>
map <Leader>4 :tabn 4<CR>
map <Leader>5 :tabn 5<CR>
map <Leader>6 :tabn 6<CR>
map <Leader>7 :tabn 7<CR>
map <Leader>8 :tabn 8<CR>
map <Leader>9 :tabn 9<CR>
map <Leader>0 :tabn 10<CR>

" <Leader>

" Other mappings for switching tabs
map <Leader>= :tabn<CR>
map <Leader>- :tabp<CR>
map <Leader>e :tabe<CR>

" VIM-PLUG -------------------------------------------------------------------

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $MYVIMRC
\| endif

" Begin list of plugins ===============
call plug#begin('~/.vim/plugged')

" Vim-plug itself for managing plugins
Plug 'junegunn/vim-plug'

" COC for Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Lightline for status line
Plug 'itchyny/lightline.vim'

" NERDTree for file browsing
Plug 'preservim/nerdtree'

" End list of plugins =================
" According to specs (https://github.com/junegunn/vim-plug) This also
" automatically executes `filetype plugin indent on` and `syntax enable`.
" I executed `filetype plugin indent on` and `syntax on` on my own, nonetheless.
call plug#end()

" Need to run :PlugUpdate every once in a while

" COC ------------------------------------------------------------------------

" COC will auto install any missing extensions in g:coc_global_extensions
" See https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
let g:coc_global_extensions = [
    \'coc-calc',
    \'coc-clangd',
    \'coc-json',
    \]

" LIGHTLINE ------------------------------------------------------------------

" Successfully display the lightline bar
set laststatus=2

" Hide that default -- INSERT -- as it is being covered by lightline
set noshowmode

" NERDTREE -------------------------------------------------------------------

" <Leader>tt to open (and switch to) NERDTree in working directory
nnoremap <Leader>tt :NERDTree<CR>

" <Leader>tf to open (and switch to) NERDTree finding current file
nnoremap <Leader>tf :NERDTreeFind<CR>

" <Leader>T to close NERDTree
nnoremap <Leader>T :NERDTreeClose<CR>
