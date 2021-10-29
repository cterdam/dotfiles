" vim:foldmethod=marker

" cterdam.vimrc: cterdam's own vimrc file.
" See https://github.com/cterdam/linuxrc

" BUILTIN --------------------------------------------------------------------

" GENERAL {{{

" Do no weird things and welcome to the 21st century
set nocompatible

" Save view when leaving
autocmd BufWinLeave ?* silent! mkview

" Load view when entering
autocmd BufWinEnter ?* silent! loadview

" Detect file type; load filetype plugin and indent setting
filetype plugin indent on

" Activate lexical coloring
syntax on

" More powerful backspace
set backspace=indent,eol,start

" Update working directory to directory containing current file
set autochdir

" Update file if changed outside Vim
set autoread

" Enable command completion
set wildmenu

" Do not timeout on ':'mappings or key codes
set notimeout nottimeout

" }}}
" INTERFACE {{{

" Always show at least 5 lines above/below cursor when available
set scrolloff=5

" Show command in the bottom right as you type
set showcmd

" Underscore the current line the cursor is on
set cursorline

" Supply text color suitable for a dark background
set background=dark

" }}}
" LINE NUMBER {{{

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

" }}}
" MODELINE {{{

" Enable modeline
set modeline

" Read modeline on top and bottom 5 lines, as default
set modelines=5

" }}}
" WIDTH & WRAP {{{

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

" }}}
" INDENT {{{

" Indent continued lines to preserve horizontal blocks
set breakindent

" Inherit indentation from preceding line
set autoindent

" Insert indent based on some C syntax
set smartindent

" }}}
" TABS & SPACES {{{

" Store tabs as spaces
set expandtab

" One tab inputs four spaces
set tabstop=4

" Setting softtabstop=tabstop thus effectively disabling soft tabs
set softtabstop=4

" >, <, and = all shift/reindent by 4 spaces per level
set shiftwidth=4

" }}}
" SEARCH {{{

" Incrementally show search results while typing the search term
set incsearch

" Highlight search results throughout text
set hlsearch

" <Leader><Space> to clear highlight
map <Leader><Space> :nohl<CR>

" au is not the same as Au!
set noignorecase

" }}}
" SWAPPING {{{

" These are currently buggy:
" Swapping the leftmost 2 chars to the left can cause the char to disappear.
" Swapping lines will lose the current column.
" TODO: Fix these and write them into a Vim plugin

" <Ctrl>h to swap a char to the left
:nnoremap <silent><C-h> :let save_a=@a<Cr>"axhh"ap:let @a=save_a<Cr>

" <Ctrl>j to swap a line down
:nnoremap <silent><C-j> :let save_a=@a<Cr>"add"ap:let @a=save_a<Cr>

" <Ctrl>k to swap a line up
:nnoremap <silent><C-k> :let save_a=@a<Cr><Up>"add"ap<Up>:let @a=save_a<Cr>

" <Ctrl>l to swap a char to the right
:nnoremap <silent><C-l> :let save_a=@a<Cr>"ax"ap:let @a=save_a<Cr>

" }}}
" FOLD {{{

" Fold level is equal to indentation divided by shiftwidth (round down)
set foldmethod=indent

" Do not ignore lines starting with '#', or any character
set foldignore=

" Enable folds by default, can be toggled with 'zi'
set foldenable

" Display fold level on the leftmost one column
set foldcolumn=1

" Press <Space> to toggle current fold
nnoremap <Space> za

" }}}
" UNDO {{{

" Save undo history
set undofile

" Remember 100 operations
set history=100

" Ensure that undodir exists
if !isdirectory($HOME . "/.vim/undo")
    call mkdir($HOME . "/.vim/undo", "p")
endif

" Set undodir and include full pathname for unfo files
set undodir=$HOME/.vim/undo//

" }}}
" BACKUP {{{

" Make a backup before overwriting a file
set writebackup

" Do not save that backup file upon successful overwrite
set nobackup

" Ensure that backupdir exists
if !isdirectory($HOME . "/.vim/backup")
    call mkdir($HOME . "/.vim/backup", "p")
endif

" Set backupdir and include full pathname for backup files
set backupdir=$HOME/.vim/backup//

" }}}
" SWAP {{{

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

" Set swapdir (option named dir) and include full pathname for swap files
set dir=$HOME/.vim/swap//

" }}}
" TAB PAGES {{{

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
map <Leader>e :tabe 

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

" }}}

" PLUGINS --------------------------------------------------------------------

" VIM-PLUG {{{

" Installs vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Runs :PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')
" Begin list of plugins ===============

" vim-plug itself for managing plugins
Plug 'junegunn/vim-plug'

" COC for Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" lightline for status line
Plug 'itchyny/lightline.vim'

" NERDTree for file browsing
Plug 'preservim/nerdtree'

" undotree for browsing the undo tree
Plug 'mbbill/undotree'

" indentLine for displaying indent lines
Plug 'Yggdroot/indentLine'

" End list of plugins =================
call plug#end()
" According to specs (https://github.com/junegunn/vim-plug) This also
" automatically executes 'filetype plugin indent on' and 'syntax enable'.
" This script executed these separately on its own, nonetheless.

" Need to run :PlugUpdate every once in a while

" TODO: Some things to consider in the future:
" - kien/ctrlp.vim or junegunn/fzf.vim for finding files
" - ggreer/the_silver_searcher or mileszs/ack.vim for grepping code
" - kana/vim-textobj-user for custom text objects
" - tpope/vim-obsession for saving/loading vim sessions

" }}}
" COC {{{

" COC will auto install any missing extensions in g:coc_global_extensions
" See https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
let g:coc_global_extensions = [
    \'coc-calc',
    \'coc-clangd',
    \'coc-json',
    \]

" }}}
" LIGHTLINE {{{

" Successfully display the lightline bar
set laststatus=2

" Hide that default '-- INSERT --' as that info is covered by lightline
set noshowmode

" }}}
" NERDTREE {{{

" <Leader>tf to open (switch to) NERDTree finding current file
nnoremap <Leader>tf :NERDTreeFind<CR>

" <Leader>tt to recover and switch to an existing NERDTree window
nnoremap <Leader>tt :NERDTreeFocus<CR>

" <Leader>T to close NERDTree
nnoremap <Leader>T :NERDTreeClose<CR>

" Confine NERDTree window to 25 chars wide
let g:NERDTreeWinSize = 25

" Hide guide text but still type '?' for help
let NERDTreeMinimalUI = 1

" }}}
" UNDOTREE {{{

" <Leader>u to toggle the undo tree
nnoremap <Leader>u :UndotreeToggle<CR>

" 1 = side pane on left; 2 = tree on left diff in bottom
" 3 = side pane on right ; 4 = tree on right diff in bottom
let g:undotree_WindowLayout = 4

" Display s, m, h, d instead of seconds, minutes, hours, days
let g:undotree_ShortIndicators = 1

" Look at the stars, look how they shine for you
let g:undotree_TreeNodeShape = '*'

" Hide guide text but still type '?' for help
let g:undotree_HelpLine = 0

" Limit tree window to 25 chars wide 
let g:undotree_SplitWidth = 25

" Limit preview window to 10 chars high
let g:undotree_DiffpanelHeight = 10

" Auto open diff window
let g:undotree_DiffAutoOpen = 1

" Focus on tree window when opening
let g:undotree_SetFocusWhenToggle = 1

" }}}
" INDENTLINE {{{

" Use default grey for indent lines
let g:indentLine_setColors = 1

" If file encoding is not UTF-8, can change this to | instead
let g:indentLine_char = '¦'

" indentLine will override 'concealcursor' with this value
let g:indentLine_concealcursor = 'inc'

" indentLine will override 'conceallevel' with this value
" indentLine will not function if conceallevel is not set to 1 or 2
let g:indentLine_conceallevel = 2

" Enable indentLine
let g:indentLine_enabled = 1

" <Leader>| to toggle displaying of indent lines
map <Leader>\| :IndentLinesToggle<CR>

" }}}
