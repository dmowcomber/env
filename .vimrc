set nocompatible              " be iMproved, required
filetype off                  " required

" au BufWritePost *.go !gofmt -w % > /dev/null
" let g:go_fmt_command = "goimports"

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'tomasr/molokai'
" Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

syntax on

" python tab style
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" ruby tab style
"set tabstop=2
"set shiftwidth=2
"set softtabstop=2
"set expandtab

set colorcolumn=80
set guifont=Monaco:h14
set number
set nowrap
set magic

set t_Co=256
colorscheme molokai

set encoding=utf-8
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest

set hlsearch
set ignorecase
"set smartcase
set gdefault
set incsearch
set showmatch

" custom mappings
map <F11> :tabp<CR>
map <F12> :tabn<CR>
"map :tree :NERDTree

nnoremap tt  :tabedit<Space>
nnoremap vv  :vs<Space>
nnoremap vc  :vsplit<CR>
nnoremap <C-]> :tabprevious<CR>
nnoremap <C-\>   :tabnext<CR>

" remove trailing whites from *.rb files
autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :%s/\s\+$//e

" ruby syntax checking
"autocmd FileType ruby map <F6> :w<CR>:!ruby -c %<CR>

" fold settings
"set foldmethod=indent

"set foldnestmax=5
"set nofoldenable
"set foldlevel=1

"Don't auto indent when pasting
set paste
