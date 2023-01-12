" basic config
" set tabstop=4                          " tabs display as 4 spaces
" set shiftwidth=4                       " number of spaces to use for indent
" set expandtab                          " use spaces instead of tabs
" set smartindent                        " use language features to determine indentation
filetype plugin indent on              " use per-filetype settings
set autoindent                         " use indentation from the previous line
set backspace=indent,eol,start         " delete indentation
set smarttab                           " better tab and delete
set wildmenu                           " get a menu for tab-completing stuff
set mouse=a                            " mouse support in (a)ll modes
set splitright                         " vertical splits open on the right
set splitbelow                         " horizontal splits open below
set scrolloff=1                        " always leave 1 line below the cursor
set sidescrolloff=5                    " always leave 5 chrs right of cursor
set hidden                             " open more than 1 buffer simultaneously
set nomodeline                         " don't read arbitrary config from buffers
set smartcase                          " case-aware autocomplete
set incsearch                          " show match while searching/substituting
set hlsearch                           " show all results of a search
set autoread                           " detect when a file is modified
set nostartofline                      " maintain cursor position for move cmds
set showcmd                            " show partial chords as you enter them
set path=$PWD/**                       " path to search for :find
set notimeout                          " don't timeout waiting for a chord
set ttimeout                           " configure a timeout for key codes
set ttimeoutlen=0                      " do not wait after input for a chord
                                       " this removes the delay after <esc>

" using plugins vim-sneak and vim-sleuth
" vim sneak
let g:sneak#label = 1

" create swap directory if it doesn't exists
silent exec '!mkdir -p $HOME/.cache/vim'
set directory=$HOME/.cache/vim//       " store swap files at ~/.cache/vim

augroup FormatOpts
    " clear autocmd for this group
    autocmd!
    " delete comment characters when joining lines but don't autoformat comments
    autocmd BufWinEnter,BufRead * setlocal formatoptions+=j
    autocmd BufWinEnter,BufRead * setlocal formatoptions-=roc

    " ensure indent is respected
    autocmd BufEnter * silent! set autoindent
augroup END


" ignore certain filetypes and folders in :find
set wildignore+=**/.git/**
set wildignore+=,*.swp
set wildignore+=,**/__pycache__/**,**/venv/**,*.pyc
set wildignore+=,**/node_modules/**
set wildignore+=,**/bin/**,**/dist/**,**/build/**,*.class
set wildignore+=,*.o

" actions are on <leader> and window movements are on <space>.  <leader> is comma
let mapleader=","

" clear search highlight
nnoremap <leader>n :nohl<cr>

" move between splits
" using recursive remap; these keys are handled differently in vscode
nmap <space>h <C-w>h
nmap <space>j <C-w>j
nmap <space>k <C-w>k
nmap <space>l <C-w>l
nmap <space>Q <C-w>q

" half-page movements
nnoremap <space>u <C-u>
nnoremap <space>d <C-d>

if exists('g:vscode')
    " show documentation on cursor hold
    " set updatetime=1000  " lower cursor hold time
    " autocmd CursorHold * silent call VSCodeNotify('editor.action.showHover')
    nnoremap K <Cmd>call VSCodeNotify('editor.action.showHover')<cr>

    " nerdtree emulation
    nnoremap <leader>e <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<cr>

    " Use vscode native interface for :find
    nnoremap <leader>f <Cmd>call VSCodeNotify('workbench.action.quickOpen')<cr>

    " open terminal
    nnoremap <leader>t <Cmd>call VSCodeNotify('workbench.action.terminal.openNativeConsole')<cr>

    " vim commentary
    map <leader>c <Plug>VSCodeCommentary<cr>

    " go to next/previous problem
    nnoremap ]g <Cmd>call VSCodeNotify('editor.action.marker.next')<cr>
    nnoremap [g <Cmd>call VSCodeNotify('editor.action.marker.previous')<cr>

    " vscode doesn't use buffers?  works for me ig
    nmap ]b :tabn<cr>
    nmap [b :tabp<cr>
    nmap <space>n :tabn<cr>
    nmap <space>N :tabp<cr>
else
    nnoremap <leader>f :find

    " Comment stuff
    map <leader>c :Commentary<cr>

    " make a little menu to switch buffers
    map <space>b :ls<cr>:b<Space>

    " move between buffers
    nnoremap ]b :bn<cr>
    nnoremap [b :bp<cr>
    nnoremap <space>n :bn<cr>
    nnoremap <space>N :bp<cr>
endif
