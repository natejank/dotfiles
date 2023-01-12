" Basic configuration
filetype plugin indent on              " use per-filetype settings
set backspace=indent,eol,start         " delete indentation
set smarttab                           " better tab and delete
set wildmenu                           " get a menu for tab-completing stuff
set mouse=a                            " mouse support in (a)ll modes
set splitright                         " vertical splits open on the right
set splitbelow                         " horizontal splits open below
set scrolloff=1                        " always leave 1 line below the cursor
set sidescrolloff=5                    " always leave 5 chrs right of cursor
set nomodeline                         " don't read arbitrary config from buffers
set smartcase                          " case-aware autocomplete
set incsearch                          " show match while searching/substituting
set hlsearch                           " show all results of a search
set autoread                           " detect when a file is modified
set nostartofline                      " maintain cursor position for move cmds
set showcmd                            " show partial chords as you enter them
set path=$PWD/**                       " path to search for :find
set ttimeout                           " configure a timeout for key codes
set ttimeoutlen=100                    " do not wait after input for a chord
                                       " this removes the delay after <esc>

" vim sneak
let g:sneak#label = 1

" some fast and quick keybindings.  actions are on <leader> and
" window movements are on <space>.  <leader> is comma
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
    autocmd CursorHold * silent call VSCodeNotify('editor.action.showHover')
    nnoremap K <Cmd>call VSCodeNotify('editor.action.showHover')<cr>

    " nerdtree emulation
    nnoremap <leader>e <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<cr>

    " Use vscode native interface for :find
    nnoremap <leader>f <Cmd>call VSCodeNotify('workbench.action.quickOpen')<cr>

    " open terminal
    nnoremap <leader>t <Cmd>call VSCodeNotify('workbench.action.terminal.openNativeConsole')<cr>

    " vim commentary
    map <leader>c <Plug>VSCodeCommentary<cr>

    " vscode doesn't use buffers?  works for me ig
    nnoremap ]b :tabn<cr>
    nnoremap [b :tabp<cr>
    nnoremap <space>n :tabn<cr>
    nnoremap <space>N :tabp<cr>
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