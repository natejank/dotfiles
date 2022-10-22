" Nathan Jankowski's (mostly portable) vimrc
" this is just a few inoffensive features to make vim more ergonomic

set number                             " use line numbers
filetype plugin indent on              " use per-filetype settings
syntax on                              " enable syntax highlighting
set tabstop=4                          " tabs display as 4 spaces
set shiftwidth=4                       " number of spaces to use for indent
set expandtab                          " use spaces instead of tabs
set smartindent                        " use smart indenting on new line
set backspace=indent,eol,start         " delete indentation
set smarttab                           " better tab and delete
set wildmenu                           " get a menu for tab-completing stuff
set mouse=a                            " mouse support in (a)ll modes
set splitright                         " vertical splits open on the right
set splitbelow                         " horizontal splits open below
set scrolloff=1                        " always leave 1 line below the cursor
set sidescrolloff=5                    " always leave 5 chrs right of cursor
set hidden                             " open more than 1 buffer simultaneously
set nomodeline                         " don't read arbitrary config from 
set smartcase                          " case-aware autocomplete
set notimeout                          " don't timeout waiting for a chord
set incsearch                          " show match while searching/substituting
set hlsearch                           " show all results of a search
set autoread                           " detect when a file is modified
set path=$PWD/**                       " path to search for :find
match ErrorMsg '\%>80v.\+'             " highlight lines longer than 80 chrs
set ttimeout                           " add a timeout for key codes
set ttimeoutlen=0                      " do not wait for key codes for a chord
                                       " this removes the delay after <esc>

" create swap directory if it doesn't exists
silent exec '!mkdir -p $HOME/.cache/vim'
set directory=$HOME/.cache/vim//       " store swap files at ~/.cache/vim

" delete comment characters when joining lines but don't autoformat comments
autocmd filetype * setlocal formatoptions+=j
autocmd filetype * setlocal formatoptions-=cro

" ignore certain filetypes in :find
set wildignore+=**/.git/**
set wildignore+=,*.swp
set wildignore+=,**/__pycache__/**,**/venv/**,*.pyc
set wildignore+=,**/node_modules/**
set wildignore+=,**/bin/**,**/dist/**,**/build/**,*.class
set wildignore+=,*.o

let mapleader=","                      " A key to map things with
nnoremap <leader>n :noh<cr>
" toggle spellchecking
nnoremap <space>s :setlocal spell! spelllang=en_us<cr>
" move between buffers
nnoremap <space>N :bp<cr>
nnoremap <space>n :bn<cr>
map <space>b :ls<cr>:b<Space>
" move between splits
nnoremap <space>h <C-w>h
nnoremap <space>j <C-w>j
nnoremap <space>k <C-w>k
nnoremap <space>l <C-w>l
nnoremap <space>Q <C-w>q
" half-page movements
nnoremap <space>u <C-u>
nnoremap <space>d <C-d>

" a little statusline I borrowed from the internet
" https://shapeshed.com/vim-statuslines/
" checks spaces/tabs and size
function! Indent() abort
    let l:tabtype=(&expandtab ? "Spaces" : "Tab")
    let l:tabsize=(&expandtab ? &shiftwidth : &tabstop)
    return  l:tabtype . ':' . l:tabsize
endfunction

" checks variables to fetch file encoding
function! Encoding() abort
    return (&fileencoding ? &fileencoding : &encoding)
endfunction

set laststatus=2                       " enable the statusline
set statusline=                        " concatenate to the statusline
set statusline+=\                      " start padding
set statusline+=%F                     " whole path to filename
set statusline+=%m                     " modified
set statusline+=%=                     " left/right separation
set statusline+=%{Indent()}            " Indentation
set statusline+=\ %y                   " filetype
set statusline+=\ %{Encoding()}        " get encoding
set statusline+=\ \[%{&fileformat}\]   " line ending (unix/windows)
set statusline+=\ %p%%                 " file percentage
set statusline+=\ %l:%c                " line:column
set statusline+=\                      " end padding

" (optional) a few plugins I think are awfully useful
" clone these into `~/vim/pack/pkgs/start` if you want them
" editorconfig-vim (https://github.com/editorconfig/editorconfig-vim):
"   read indent/format info from .editorconfig
" indentLine (https://github.com/Yggdroot/indentLine):
"   add visual indent lines.  this doesn't work with macos vim :(
" vim-sneak (https://github.com/justinmk/vim-sneak):
"   this adds the s key as a more useful motion
let g:sneak#label=1  " add labels when there's multiple results
" NERDTree (https://github.com/preservim/nerdtree):
"   a user-friendly file tree
map <leader>e :NERDTreeToggle<cr>
" vim-commentary (https://github.com/tpope/vim-commentary):
"   a mechanism to comment stuff out
map <leader>c :Commentary<cr>
