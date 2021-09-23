" ================================= BUILTIN ==================================

" GENERAL --------------------------------------------------------------------

" Do no weird things and welcome to the 21st century
set nocompatible

" Save view when leaving
autocmd BufWinLeave ?* mkview

" Load view when entering
autocmd BufWinEnter ?* silent loadview

" Update working directory to directory containing current file
set autochdir

" Update file if changed outside Vim
set autoread

" Enable command completion
set wildmenu

" Do not timeout on :mappings or key codes
set notimeout nottimeout

" APPEARANCE -----------------------------------------------------------------

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

" LINE NUMBER ----------------------------------------------------------------

" Display line numbers
set number

" Display line number as difference from current line
set relativenumber

" <Leader><Leader> to toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc
map <Leader><Leader> :call ToggleNumber()<CR>

" Color the line numbers grey
highlight LineNr ctermfg=grey

" WIDTH & WRAP ---------------------------------------------------------------

" Keep your line within 80 chars
set colorcolumn=81

" Break lines longer than 78 chars. Vim forces this to 78 anyways
set textwidth=78

" Do not horizontally extend a line past screen boundary
set wrap

" Do not break words over lines
set linebreak

" Mark the beginning of a continued line
set showbreak=↳

" INDENT ---------------------------------------------------------------------

" Indent continued lines to preserve horizontal blocks
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

" <Leader><Space> to clear highlight
map <Leader><Space> :nohl<CR>

" au is not the same as Au!
set noignorecase

" FOLD -----------------------------------------------------------------------

" Fold level is equal to indentation divided by shiftwidth (round down)
set foldmethod=indent

" Do not ignore lines starting with '#', or any character
set foldignore=

" Expand all folds by default, can be toggled with `zi`
set nofoldenable

" Display fold level on the leftmost one column
set foldcolumn=1

" Press space to toggle current fold
nnoremap <Space> za

" UNDO -----------------------------------------------------------------------

" Save undo history
set undofile

" Remember 100 operations
set history=100

" Ensure that undodir exists
if !isdirectory($HOME . "/.vim/undo")
    call mkdir($HOME . "/.vim/undo", "p")
endif

" Set undodir
set undodir=$HOME/.vim/undo//

" BACKUP ---------------------------------------------------------------------

" Make a backup before overwriting a file
set writebackup

" Do not save that backup file upon successful overwrite
set nobackup

" Ensure that backupdir exists
if !isdirectory($HOME . "/.vim/backup")
    call mkdir($HOME . "/.vim/backup", "p")
endif

" Set backupdir
set backupdir=$HOME/.vim/backup//

" SWAP -----------------------------------------------------------------------

" Make a swap file to prepare for a crash
set swapfile

" Update the swap file every 100 characters
set updatecount=100

" If for 4000 miliseconds nothing is typed, write the swap file
set updatetime=4000

" Ensure that swapdir exists
if !isdirectory($HOME . "/.vim/swap")
    call mkdir($HOME . "/.vim/swap", "p")
endif

" Set swapdir (option named dir)
set dir=$HOME/.vim/swap//

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

" Other mappings for switching tabs
map <Leader>= :tabn<CR>
map <Leader>- :tabp<CR>
map <Leader>e :tabe<CR>

" <Leader>S-<n> to close tab <n>
map <Leader>! :tabclose 1<CR>
map <Leader>@ :tabclose 2<CR>
map <Leader># :tabclose 3<CR>
map <Leader>$ :tabclose 4<CR>
map <Leader>% :tabclose 5<CR>
map <Leader>^ :tabclose 6<CR>
map <Leader>& :tabclose 7<CR>
map <Leader>* :tabclose 8<CR>
map <Leader>( :tabclose 9<CR>
map <Leader>) :tabclose 10<CR>

" Other mappings for closing tabs
map <Leader>_ :tabclose -<CR>
map <Leader>+ :tabclose +<CR>
map <Leader>c :tabclose<CR>

" ================================= PLUGINS ==================================

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

call plug#begin('~/.vim/plugged')
" Begin list of plugins ===============

" Vim-plug itself for managing plugins
Plug 'junegunn/vim-plug'

" COC for Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Lightline for status line
Plug 'itchyny/lightline.vim'

" NERDTree for file browsing
Plug 'preservim/nerdtree'

" End list of plugins =================
call plug#end()
" According to specs (https://github.com/junegunn/vim-plug) This also
" automatically executes `filetype plugin indent on` and `syntax enable`.
" This script executed these separately on its own, nonetheless.

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

" Hide that default '-- INSERT --' as that info is covered by lightline
set noshowmode

" NERDTREE -------------------------------------------------------------------

" `<Leader>t` to open (switch to) NERDTree window in working directory
nnoremap <Leader>t :NERDTreeFocus<CR>

" `<Leader>T` to close NERDTree
nnoremap <Leader>T :NERDTreeClose<CR>

" Hide guide text
let NERDTreeMinimalUI = 1
