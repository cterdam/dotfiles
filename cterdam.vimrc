" vim:foldmethod=marker

" cterdam.vimrc: cterdam's personal vimrc file.
" See https://github.com/cterdam/dotfiles

" BUILTIN --------------------------------------------------------------------

" GENERAL {{{

" Do no weird things and welcome to the 21st century
set nocompatible

" Save view when leaving
autocmd BufWinLeave ?* silent! mkview

" Load view when entering
autocmd BufWinEnter ?* silent! loadview

" Detect file type; load filetype plugin and indent setting
filetype on
filetype plugin on
filetype indent on

" Activate lexical coloring
syntax on

" Enable modeline
set modeline

" Read modeline on top and bottom 5 lines, as default
set modelines=5

" More powerful backspace
set backspace=indent,eol,start

" Update working directory to that containing current file
set autochdir

" Update file if changed outside Vim
set autoread

" Enable command completion
set wildmenu

" Secure the default \ as mapleader
let mapleader='\'

" Ctrl+q to toggle in and out of paste mode
set pastetoggle=<C-q>

" Do not timeout on ':'mappings or key codes
set notimeout nottimeout

" Use <C-n> to move to the next non-empty line
nnoremap <C-n> :<C-u>call search('^.\+')<CR>

" Use <C-p> to move to the previous non-empty line
nnoremap <C-p> :<C-u>call search('^.\+', 'b')<CR>

" }}}
" GUI"{{{

" Set gui font to be displayed in MacVim
set guifont=IBM\ Plex\ Mono:h20

" gui displays block cursor in all modes
set guicursor=n-v-c-i:block-Cursor

" Disable gui cursor blinking
set guicursor+=a:blinkon0

"}}}
" INTERFACE {{{

" Always show at least 5 lines above/below cursor when available
set scrolloff=5

" Show command in the bottom right as you type
set showcmd

" Underscore the current line the cursor is on
set cursorline

" Supply text color suitable for a dark background
set background=dark

" Make sign column black for use by vim-gitgutter
highlight SignColumn ctermbg=black ctermfg=yellow

" vim-hexokinase needs this to display text code colors
" This also makes vim appear weird outside tmux, but why use vim without tmux?
set termguicolors

" Set Vim-specific sequences for RGB colors,
" so color scheme can be displayed even with termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" <Leader>v to toggle viewing invisible characters.
function! ToggleList()
    if(&list == 1)
        set nolist
    else
        set list
    endif
endfunction
map <Leader>v :call ToggleList()<CR>

" }}}
" LINE NUMBER {{{

" Display line numbers
set number

" Display line number as difference from current line
set relativenumber

" <Leader><Return> to toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunction
map <Leader><Return> :call ToggleNumber()<CR>

" Color the line numbers dark
highlight LineNr ctermfg=darkgrey

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
" INDENT & TABS  {{{

" Store tabs as spaces
set expandtab

" One tab inputs four spaces
set tabstop=4

" Setting softtabstop=tabstop thus effectively disabling soft tabs
set softtabstop=4

" >, <, and = all shift/reindent by 4 spaces per level
set shiftwidth=4

" Indent continued lines to preserve horizontal blocks
set breakindent

" Inherit indentation from preceding line
set autoindent

" Insert indent based on some C syntax
set smartindent

" }}}
" SEARCH {{{

" Incrementally show search results while typing the search term
set incsearch

" Highlight search results throughout text
set hlsearch

" To be or not to be is the question...
set ignorecase

" <Leader>/ to clear highlight
map <Leader>/ :nohl<CR>

" Show search index
set shortmess-=S

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

" Supply color for the fold column
highlight FoldColumn ctermbg=darkgrey ctermfg=white

" Supply color for the folded lines
highlight Folded ctermbg=darkgrey ctermfg=white

" }}}
" UNDO FILE {{{

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
" BACKUP FILE {{{

" Make a backup before overwriting a file
" Turned off because some COC servers have issues with backup files.
" See COC README sample config.
set nowritebackup

" Do not save that backup file upon successful overwrite
" Kept off because some COC servers have issues with backup files.
" See COC README sample config.
set nobackup

" Ensure that backupdir exists
if !isdirectory($HOME . "/.vim/backup")
    call mkdir($HOME . "/.vim/backup", "p")
endif

" Set backupdir and include full pathname for backup files
set backupdir=$HOME/.vim/backup//

" }}}
" SWAP FILE {{{

" Make a swap file to prepare for a crash
set swapfile

" Update the swap file every 100 characters
set updatecount=100

" If for 100 miliseconds nothing is typed, write the swap file
" This also governs such other update events as gitgutter update
set updatetime=100

" Ensure that swapdir exists
if !isdirectory($HOME . "/.vim/swap")
    call mkdir($HOME . "/.vim/swap", "p")
endif

" Set swapdir (option named dir) and include full pathname for swap files
set dir=$HOME/.vim/swap//

" }}}
" LOCATION LIST {{{

" <Leader>l<n> to switch to the nth location in the list
map <Leader>l1 :ll 1<CR>
map <Leader>l2 :ll 2<CR>
map <Leader>l3 :ll 3<CR>
map <Leader>l4 :ll 4<CR>
map <Leader>l5 :ll 5<CR>
map <Leader>l6 :ll 6<CR>
map <Leader>l7 :ll 7<CR>
map <Leader>l8 :ll 8<CR>
map <Leader>l9 :ll 9<CR>
map <Leader>l0 :ll 10<CR>

" Other mappings for navigating the location list
map [l :lprev<CR>
map ]l :lnext<CR>
map [L :lfirst<CR>
map ]L :llast<CR>
map <Leader>ll :lopen<CR>
map <Leader>L :lclose<CR>

" }}}
" QUICKFIX LIST {{{

" <Leader>q<n> to switch to the nth location in the list
map <Leader>q1 :cc 1<CR>
map <Leader>q2 :cc 2<CR>
map <Leader>q3 :cc 3<CR>
map <Leader>q4 :cc 4<CR>
map <Leader>q5 :cc 5<CR>
map <Leader>q6 :cc 6<CR>
map <Leader>q7 :cc 7<CR>
map <Leader>q8 :cc 8<CR>
map <Leader>q9 :cc 9<CR>
map <Leader>q0 :cc 10<CR>

" Other mappings for navigating the location list
map [q :cprev<CR>
map ]q :cnext<CR>
map [Q :cfirst<CR>
map ]Q :clast<CR>
map <Leader>qq :copen<CR>
map <Leader>Q :cclose<CR>

" }}}
" TAB PAGES {{{

" NAVIGATING =================================================================

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

" Other mappings for navigating tabs
map <Leader><Leader> :tabedit<Space>
map [<Leader> :tabprevious<CR>
map ]<Leader> :tabnext<CR>
map [\| :tabfirst<CR>
map ]\| :tablast<CR>

" MOVING =====================================================================

" <Leader><S-<n>> to move current tab after <n>
map <Leader>) :tabmove 0<CR>
map <Leader>! :tabmove 1<CR>
map <Leader>@ :tabmove 2<CR>
map <Leader># :tabmove 3<CR>
map <Leader>$ :tabmove 4<CR>
map <Leader>% :tabmove 5<CR>
map <Leader>^ :tabmove 6<CR>
map <Leader>& :tabmove 7<CR>
map <Leader>* :tabmove 8<CR>
map <Leader>( :tabmove 9<CR>

" Other mappings for moving tabs
map <Leader>{ :tabmove -<CR>
map <Leader>} :tabmove +<CR>
map \|{ :tabmove 0<CR>
map \|} :tabmove $<CR>

" CLOSING ====================================================================

" <Leader><Backspace><n> to close tab <n> with confirmation
map <Leader><Backspace>1 :tabclose 1<CR>
map <Leader><Backspace>2 :tabclose 2<CR>
map <Leader><Backspace>3 :tabclose 3<CR>
map <Leader><Backspace>4 :tabclose 4<CR>
map <Leader><Backspace>5 :tabclose 5<CR>
map <Leader><Backspace>6 :tabclose 6<CR>
map <Leader><Backspace>7 :tabclose 7<CR>
map <Leader><Backspace>8 :tabclose 8<CR>
map <Leader><Backspace>9 :tabclose 9<CR>
map <Leader><Backspace>0 :tabclose 10<CR>

" Other mappings for closing tabs with confirmation
map <Leader><Backspace>[ :tabclose -<CR>
map <Leader><Backspace>] :tabclose +<CR>
map <Leader><Backspace><Leader> :tabclose<CR>

" <Leader><Backspace><S-<n>> to close tab <n> discarding unsaved changes
map <Leader><Backspace>! :tabclose! 1<CR>
map <Leader><Backspace>@ :tabclose! 2<CR>
map <Leader><Backspace># :tabclose! 3<CR>
map <Leader><Backspace>$ :tabclose! 4<CR>
map <Leader><Backspace>% :tabclose! 5<CR>
map <Leader><Backspace>^ :tabclose! 6<CR>
map <Leader><Backspace>& :tabclose! 7<CR>
map <Leader><Backspace>* :tabclose! 8<CR>
map <Leader><Backspace>( :tabclose! 9<CR>
map <Leader><Backspace>) :tabclose! 10<CR>

" Other mappings for closing tabs discarding unsaved changes
map <Leader><Backspace>{ :tabclose! -<CR>
map <Leader><Backspace>} :tabclose! +<CR>
map <Leader><Backspace>\| :tabclose!<CR>

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
" Begin list of plugins ======================================================

" vim-plug itself for managing plugins
Plug 'junegunn/vim-plug'

" COC for completion and diagnostics
" Requires Node.js
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" lightline for statusline and tabline
Plug 'itchyny/lightline.vim'

" NERDTree for file browsing
Plug 'preservim/nerdtree'

" undotree for browsing the undo tree
Plug 'mbbill/undotree'

" indentLine for displaying indent lines
Plug 'Yggdroot/indentLine'

" vim-commentary for manipulating comments
Plug 'tpope/vim-commentary'

" vim-surround for manipulating brackets, quotes, and tags
Plug 'tpope/vim-surround'

" vim-floaterm for floating terminals
Plug 'voldikss/vim-floaterm'

" vim-fugitive for git commands
Plug 'tpope/vim-fugitive'

" vim-gitgutter for viewing git status per line
Plug 'airblade/vim-gitgutter'

" vim-diffsave for viewing file diff against disk save"
Plug 'cterdam/vim-diffsave'

" gruvbox, monokai, and dracula colorschemes
Plug 'morhetz/gruvbox'
Plug 'sickill/vim-monokai'
Plug 'dracula/vim', { 'as': 'dracula' }

" goyo for focused writing
Plug 'junegunn/goyo.vim'

" markdown-preview for previewing markdown
" Requires Node.js and yarn
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" vim-cursorword for viewing the current word underlined
Plug 'itchyny/vim-cursorword'

" vim-hexokinase for previewing colors
" Requires golang
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" vim-better-whitespace for highlighting and removing trailing whitespaces
Plug 'ntpeters/vim-better-whitespace'

" rainbow to colorize different levels of parentheses
Plug 'luochen1990/rainbow'

" omnisharp-vim to provide completion and diagnostics for C#
" So far, the only IDE plugin outside of COC
Plug 'OmniSharp/omnisharp-vim'

" End list of plugins ========================================================
call plug#end()
" According to specs (https://github.com/junegunn/vim-plug) This also
" automatically executes 'filetype plugin indent on' and 'syntax enable'.
" This script executed these separately on its own, nonetheless.

" Run :PlugUpdate every once in a while to update plugins
" To uninstall, remove from this list, then run :PlugClean

" TODO: Some things to consider in the future:
" - kien/ctrlp.vim or junegunn/fzf.vim for finding files
" - ggreer/the_silver_searcher or mileszs/ack.vim for grepping code
" - kana/vim-textobj-user for custom text objects
" - tpope/vim-obsession for saving/loading vim sessions
" - godlygeek/tabular for lining up text
" - chrisbra/csv.vim for treating csv files
" - kyazdani42/nvim-tree.lua for a better file tree
" - xiyaowong/coc-symbol-line for viewing current symbol name

" }}}
" COC {{{

" CONQUERER OF COMPLETION
" Requires Node.js

" Extensions =================================================================

" List:
" COC will auto install any missing extensions in this list.
" See https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
" Use :CocUpdate or :CocUpdateSync to update COC extensions
" To uninstall, remove from this list, then run like :CocUninstall coc-css
let g:coc_global_extensions = [
    \'coc-calc',
    \'coc-clangd',
    \'coc-json',
    \'coc-markdownlint',
    \'coc-pyright',
    \'coc-sh',
    \'coc-vimlsp',
    \'coc-yank'
    \]
" run individual extension commands like this :CocCommand python.runLinting
" Extension config options are set in :CocConfig

" Individual WhatIs:
" coc-calc: autocomplete mathematical expression calculations.
" coc-clangd: C-language family extension.
"   Requires Node.js and clangd in PATH.
" coc-json: json file extension.
" coc-markdownlint: markdown file extension.
" coc-pyright: pyright extension for python.
" coc-sh: SH language extension.
"   Requires bash-language-server.
" coc-vimlsp: vimscript language extension.
" coc-yank: yank completion, plus persistent yank list across vim instances

" Settings:
" Most config options for coc extensions should be set in :CocConfig

" coc-sh:
" Automatically recognize these files as sh
autocmd BufNewFile,BufRead *.zshrc,*.zsh,*.sh set filetype=sh

" coc-vimlsp:
" Apply highlight in these filetypes
let g:markdown_fenced_languages = [
    \ 'vim',
    \ 'help'
    \]

" coc-yank:
" <Leader>y to view yank list
nnoremap <silent> <Leader>y :<C-u>CocList -A --normal yank<cr>

" The following config are adapted from COC's official sample vimrc:
" Completion =================================================================

" COC TextEdit might fail if hidden is not set
set hidden

" COC uses some unicode characters in the file autoload/float.vim
set encoding=utf-8

" Don't pass messages to |ins-completion-menu|
set shortmess+=c

" <Tab> to trigger completion.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" It's unclear which description block this function belongs to.
" It seems to have no effect.
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" <CR> to auto-select the first completion item and format on enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Diagnostics ================================================================

" <Leader>g to list all diagnostics of current buffer in location list
map <Leader>g :CocDiagnostics<CR>
" <Leader><S-g> to list all diagnostics for fuzzy searching
map <Leader><S-g> :<C-u>CocList diagnostics<cr>

" <Leader>o to list outline of current document
map <Leader>o :CocOutline<CR>
" <Leader><S-o> to list outline of current document for fuzzy searching
map <Leader><S-o> :CocList outline<CR>
" <Leader><C-o> to search symbols in current workspace
map <Leader><C-o> :CocList -I symbols<CR>

" `[g` and `]g` to navigate diagnostics
" Alternatively it's also fine to use location list navigation keys directly
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" `Ctrl+k` to show documentation in preview window
nnoremap <silent> <C-k> :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Remap <C-f> and <C-b> to scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f>
              \ coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b>
              \ coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f>
              \ coc#float#has_scroll() ?
              \ "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b>
              \ coc#float#has_scroll() ?
              \ "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f>
              \ coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b>
              \ coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Edit =======================================================================

" <Leader>r to rename current symbol
nmap <leader>r <Plug>(coc-rename)

" <Leader>= to format selected code
xmap <leader>=  <Plug>(coc-format-selected)
nmap <leader>=  <Plug>(coc-format-selected)

" <Leader>f to apply AutoFix to problem on the current line.
nmap <leader>f  <Plug>(coc-fix-current)

" <Leader>a to apply codeAction to selected region
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" <Leader><C-a> to apply Code Lens action on the current line.
nmap <leader><C-a>  <Plug>(coc-codelens-action)

" Use `f` for function and `c` for class text objects
" Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" <C-s> to expand selections ranges
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" `:Fold` command to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" `:OR` command to organize imports of the current buffer
command! -nargs=0 OR :call
    \ CocActionAsync('runCommand', 'editor.action.organizeImport')

" }}}
" NERDTREE {{{

" <Leader>t to recover and switch to an existing NERDTree window
nnoremap <Leader>t :NERDTreeFocus<CR>

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

" <Leader><Tab> to toggle displaying of indent lines
map <Leader><Tab> :IndentLinesToggle<CR>

" }}}
" VIM-FLOATERM {{{

" <F12> to toggle the floaterm
let g:floaterm_keymap_toggle = '<F12>'

" No title for floaterm
let g:floaterm_title = ''

" Float in the center
let g:floaterm_position = 'center'

" Always close floaterm upon job exit
let g:floaterm_autoclose = 2

" }}}
" VIM-GITGUTTER {{{

" Supply colors for GitGutter signs.
" These don't seem to get used, but removing them spawns another set of colors.
highlight GitGutterAdd    ctermbg=black ctermfg=green ctermfg=2
highlight GitGutterChange ctermbg=black ctermfg=yellow ctermfg=3
highlight GitGutterDelete ctermbg=black ctermfg=red ctermfg=1

" Turn off hunk highlighting on default
autocmd VimEnter * GitGutterLineHighlightsDisable

" <Leader>i to toggle hunk line highlighting
map <Leader>i :GitGutterLineHighlightsToggle<CR>

" Use location list and not quickfix for hunks
let g:gitgutter_use_location_list = 1

" <Leader>c to toggle change list (view/hide hunks)
function! ToggleHunks()
    if get(getloclist(0, {'winid':0}), 'winid', 0)
        :lclose
    else
        :GitGutterQuickFix
        :lopen
    endif
endfunction
map <Leader>c :call ToggleHunks()<CR>

" }}}
" LIGHTLINE {{{

" Successfully display the statusline
set laststatus=2

" Hide that default '-- INSERT --' as that info is covered by lightline
set noshowmode

" Define fields of the statusline and tabline.
" For more available fields, See :help lightline,
" and more specifically :help g:lightline.component
let g:lightline= {
    \ 'active': {
        \ 'left': [ [ 'mode', 'paste' ],
        \           [ 'readonly', 'filename', 'modified'],
        \           [ 'gitbranch', 'gitstatus' ] ],
        \ 'right': [ [ 'percent', 'lineinfo'],
        \            [ 'filetype' ],
        \            [ 'statusdiagnostic' ] ] },
    \ 'inactive':{
        \ 'left': [ [ 'readonly', 'absolutepath', 'modified' ] ],
        \ 'right': [ [ 'lineinfo' ],
        \            [ 'percent' ] ] },
    \ 'tabline': {
        \ 'left': [ [ 'tabs' ] ],
        \ 'right': [] },
    \ 'component_function': {
        \ 'gitbranch': 'FugitiveHead',
        \ 'gitstatus': 'GitStatus',
        \ 'statusdiagnostic': 'StatusDiagnostic'}
\ }

" Function to format current file git info
" This requires vim-gitgutter and vim-fugitive
function! GitStatus()
    if FugitiveHead() == ''
        return ''
    else
        let [a,m,r] = GitGutterGetHunkSummary()
        return printf('+%d ~%d -%d', a, m, r)
    endif
endfunction

" Function to get formatted status diagnostic from COC
function! StatusDiagnostic() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return '' | endif
    let msgs = []

    " Display the number of errors even if it's 0
    call add(msgs, '!' . info['error'])

    " Display the number of warnings even if it's 0
    call add(msgs, '?' . info['warning'])

    return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

" }}}
" VIM-DIFFSAVE {{{

" <Leader>w to toggle the diffsave window
map <Leader>w <Plug>ToggleDiffSave<CR>

" }}}
" GRUVBOX {{{

" Enable bold text
let g:gruvbox_bold=1

" Enable italics text
let g:gruvbox_italic=1

" Italicize comments
let g:gruvbox_italicize_comments=1

" Italicize strings
let g:gruvbox_italicize_strings=1

" Enable underlined text
let g:gruvbox_underline=1

" Enable undercurled text
let g:gruvbox_undercurl=1

" Use 256-color palette (as opposed to 16)
let g:gruvbox_termcolors=256

" Set contrast for dark mode. Possible values: 'soft', 'medium', 'hard'
let g:gruvbox_contrast_dark='hard'

" Set contrast for dark mode. Possible values: 'soft', 'medium', 'hard'
let g:gruvbox_contrast_light='hard'

" Color the color column red. Also possible for number colomn and sign column
let g:gruvbox_color_column='red'

" Do not invert background color of selected text
let g:gruvbox_invert_selection=0

" Do not invert signs in the sign column
let g:gruvbox_invert_signs=0

" Do not extrahighlight string background
let g:gruvbox_improved_strings=0

" Activate the gruvbox colorscheme
autocmd vimenter * ++nested colorscheme gruvbox

" }}}
" GOYO {{{

" <Leader>e to toggle goyo
map <Leader>e :Goyo<CR>

" Set goyo width
let g:goyo_width = 80

" Set goyo height
let g:goyo_height = 45

" No line numbers in goyo
let g:goyo_linenr = 0

" This function will be executed when entering goyo
function! s:goyo_enter()
    set showmode
    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

" This function will be executed when leaving goyo
function! s:goyo_leave()
    set noshowmode
    " Quit Vim if this is the only remaining buffer
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        if b:quitting_bang
            qa!
        else
            qa
        endif
    endif
endfunction

" Bind enter and leave functions to goyo command
autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" }}}
" MARKDOWN-PREVIEW {{{

" Echo preview page url in command line when opening preview page
let g:mkdp_echo_preview_url = 1

" use a custom markdown style must be absolute path
" This file enables previewing Github-flavored Markdown
let g:mkdp_markdown_css = expand("$CTERDAMRC") .
            \"/github-markdown-css/github-markdown.css"

" <Leader>m to toggle preview window
map <Leader>m <Plug>MarkdownPreviewToggle

" }}}
" VIM-HEXOKINASE {{{

" For all possible highlighters, :help hexokinase.txt
let g:Hexokinase_highlighters = [ 'backgroundfull' ]

" Patterns to match for colors
" Can be a comma separated string or a list of strings
let g:Hexokinase_optInPatterns = [
\     'full_hex',
\     'triple_hex',
\     'rgb',
\     'rgba',
\     'hsl',
\     'hsla',
\     'colour_names'
\ ]

" Disable colorizing by default
autocmd vimenter * :HexokinaseToggle

" <Leader>k to toggle colorizing
map <Leader>k :HexokinaseToggle<CR>

" }}}
" VIM-BETTER-WHITESPACE {{{

" Use red color to highlight trailing whitespace
let g:better_whitespace_ctermcolor='red'
let g:better_whitespace_guicolor=g:better_whitespace_ctermcolor

" Highlight trailing whitespace
let g:better_whitespace_enabled=1

" Do not strip trailing whitespace on save
let g:strip_whitespace_on_save=0

" <Leader>Space to toggle highlighting trailing whitespace
map <Leader><Space> :ToggleWhitespace<CR>

" <C-Space> to strip trailing whitespace on the entire file, or with a range.
map <C-@> :StripWhitespace<CR>

" Disable the built-in operator mapping to clean whitespace
let g:better_whitespace_operator=''

" Do not strip empty lines at the end of the file when stripping whitespace
let g:strip_whitelines_at_eof=0

" Highlight space characters that appear before or in-between tabs
let g:show_spaces_that_precede_tabs=1

" Do not ignore lines that contain only whitespace
let g:better_whitespace_skip_empty_lines=0

" Navigate to the previous or next trailing whitespace
nnoremap [<Space> :PrevTrailingWhitespace<CR>
nnoremap ]<Space> :NextTrailingWhitespace<CR>

" Won't hurt to give more info
let g:better_whitespace_verbosity=1

" }}}
" RAINBOW {{{

" Disable colorizing parens by default
let g:rainbow_active = 0

" <Leader>n to toggle rainbow coloring
map <Leader>n :RainbowToggle<CR>

" Supply color hierarchy for raindow
let g:rainbow_conf = {
\	'guifgs': ['red', 'orange', 'yellow', 'green', 'lightblue', 'blue',
        \'purple'],
\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\	'guis': [''],
\	'cterms': [''],
\	'operators': '_,_',
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold',
        \'start=/{/ end=/}/ fold']
\}

" }}}
" OMNISHARP-VIM {{{

" The following config are adapted from omnisharp-vim's official sample vimrc:
" ============================================================================

augroup omnisharp_commands
  autocmd!

" Diagnostics ================================================================

  " `go` to generate symbol outline
  autocmd FileType cs nmap <silent> <buffer>
    \ <Leader>o <Plug>(omnisharp_find_symbol)

  " <Leader>g to populate the quickfix window with code errors/warnings
  autocmd FileType cs nmap <silent> <buffer>
    \ <Leader>g <Plug>(omnisharp_global_code_check)

  " <C-k> to preview definition in pop-up
  autocmd FileType cs nmap <silent> <buffer>
    \ <C-k> <Plug>(omnisharp_preview_definition)

  " <C-i> to preview implementation in pop-up
  autocmd FileType cs nmap <silent> <buffer>
    \ <C-i> <Plug>(omnisharp_preview_implementations)

  " GoTo code navigation
  autocmd FileType cs nmap <silent> <buffer>
	\ gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer>
    \ gy <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer>
    \ gi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer>
    \ gr <plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer>
    \ gm <Plug>(omnisharp_documentation)

  " Edit =======================================================================

  " [[ and ]] to navigate up and down by method/property/field
  autocmd FileType cs nmap <silent> <buffer>
    \ [[ <Plug>(omnisharp_navigate_up)
  autocmd FileType cs nmap <silent> <buffer>
    \ ]] <Plug>(omnisharp_navigate_down)

  " <Leader>a for contextual code actions
  " uses fzf, vim-clap, CtrlP or unite.vim selector " when available
  autocmd FileType cs nmap <silent> <buffer>
    \ <Leader>a <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer>
    \ <Leader>a <Plug>(omnisharp_code_actions)

  " <Leader>. to repeat the last code action performed (doesn't use a selector)
  autocmd FileType cs nmap <silent> <buffer>
    \ <Leader>. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer>
    \ <Leader>. <Plug>(omnisharp_code_action_repeat)

  " <Leader>= to format code
  autocmd FileType cs nmap <silent> <buffer>
    \ <Leader>= <Plug>(omnisharp_code_format)

  " <Leader>r to rename symbol
  autocmd FileType cs nmap <silent> <buffer>
    \ <Leader>r <Plug>(omnisharp_rename)

augroup END

" }}}
