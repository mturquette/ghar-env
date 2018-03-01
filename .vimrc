"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup

" show tabs
set list
set listchars=tab:\|-,trail:█

" highlight matching search patterns
set hlsearch

" minibufexplorer uses hjkl for window navigation
let g:miniBufExplMapWindowNavVim = 1

"map <F5> :wall!<CR>:!sbcl --load foo.cl<CR><CR>
map m :make -j16 uImage dtbs <CR><CR><CR>

" treat mbox files like diff or patch files
au BufReadPost *.mbox set syntax=diff

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" solarized color scheme
"syntax enable
"set background=dark
"let g:solarized_termcolors=256
"colorscheme solarized

syntax on
syntax enable
if has('gui_running')
	set background=dark
	"set background=light
	set tw=72
	set ai
	set lbr
	set spell
	" see what options I pass for vim in ~/.config/alot/config
else
	set background=dark
endif
set guifont=Ubuntu\ Mono\ derivative\ Powerline:h18
set t_Co=16
let g:solarized_termcolors=16
colorscheme solarized
set noantialias

" used for setting tabstop from comments lines
set modeline

"set term=xterm

source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
"source ~/.local/lib/python3.4/site-packages/powerline/bindings/vim/plugin/powerline.vim
set laststatus=2

set nocompatible
set backspace=indent,eol,start

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Group dependencies, vim-snippets depends on ultisnips
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" org-mode plugins
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
Plug 'itchyny/calendar.vim'
Plug 'SyntaxRange'
Plug 'utl.vim'
Plug 'tpope/vim-repeat'
Plug 'taglist.vim'
Plug 'majutsushi/tagbar'
Plug 'chrisbra/nrrwrgn'

" Add plugins to &runtimepath
call plug#end()
