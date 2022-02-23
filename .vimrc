
call plug#begin('~/.vim/plugged')
Plug 'mlochbaum/BQN', {'rtp': 'editors/vim'}
Plug 'PyGamer0/vim-apl'
Plug 'https://codeberg.org/ngn/k.git', {'rtp': 'vim-k'}
Plug 'altercation/vim-colors-solarized'
Plug 'Lokaltog/vim-monotone'
Plug 'neovimhaskell/haskell-vim'

call plug#end()


set autochdir                   " Changes the cwd to the directory of the current
                                " buffer whenever you switch buffers.
set browsedir=current           " Make the file browser always open the current
                                " directory.
set clipboard=unnamedplus
syntax on
filetype plugin on
set background=dark
set t_Co=12
" colorscheme solarized
set guifont=Iosevka\ Fixed\ SS09\ 14
colorscheme monotone
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
let g:haskell_indent_if = 3
