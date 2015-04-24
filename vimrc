" why I don't use ed
syntax on
filetype plugin indent on
set ruler
set hidden

""
" Swap files
""
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//

""
" line numbers
""

" color
highlight LineNr ctermfg=grey
highlight CursorLineNr ctermfg=darkgrey

" toggle line numbers
map tn :set relativenumber! number!<CR>


""
" tabs
""

map tt :set expandtab!<CR>

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

""
" whitespace
""

" color
highlight ExtraWhitespace ctermbg=red

" show trailing whitespace
match ExtraWhitespace /\s\+$/

" show trailing whitespace and spaces before a tab
match ExtraWhitespace /\s\+$\| \+\ze\t/

" show whitespace
set listchars=tab:┃\ ,trail:┅,extends:▶,precedes:◀
set list
set nowrap


""
" folding
""

set foldmethod=manual

hi Folded ctermbg=8
hi Folded ctermfg=5

""
" Xml
""

map <F5> :%s/<\([^>]\)*>/\r&\r/g<enter>:g/^$/d<enter>vat=


"""""
""" Plug
"""""

call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe'
Plug 'fatih/vim-go'
Plug 'kongo2002/fsharp-vim'
Plug 'airblade/vim-gitgutter'

Plug 'scrooloose/nerdtree'
map <C-l> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1


call plug#end()
