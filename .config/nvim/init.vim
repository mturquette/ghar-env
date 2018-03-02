call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'tpope/vim-sensible'

" org-mode plugins
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
Plug 'itchyny/calendar.vim'
"Plug 'SyntaxRange'
"Plug 'utl.vim'
"Plug 'tpope/vim-repeat'
"Plug 'taglist.vim'
"Plug 'majutsushi/tagbar'
"Plug 'chrisbra/nrrwrgn'
Plug 'frankier/neovim-colors-solarized-truecolor-only'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"Plug 'junegunn/vim-easy-align'

" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Tim Pope's vim-fugitive
Plug 'tpope/vim-fugitive'

" Powerline - currently doesn't work with neovim
"Plug '/usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin'

" Airline - Powerline alternative until Powerline works with Neovim
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" fast fuzzy finder for buffers, files & tags
"Plug 'wincent/command-t'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'weynhamz/vim-plugin-minibufexpl'

"Plug 'simplyzhao/cscope_maps.vim'
"Plug 'mfulz/cscope.nvim'
" Add plugins to &runtimepath
call plug#end()

filetype plugin indent on

set termguicolors
set background=dark "light or dark
" solarized options 
"let g:solarized_visibility = "high"
"let g:solarized_contrast = "high"
"let g:solarized_termcolors=16
"let g:solarized_termcolors=256
let g:solarized_termtrans = 1
" notes here:
" http://stackoverflow.com/questions/7278267/incorrect-colors-with-vim-in-iterm2-using-solarized
" http://ethanschoonover.com/solarized/vim-colors-solarized
colorscheme solarized

let g:airline_powerline_fonts = 1

let g:org_agenda_files = ['~/Dropbox/org-mode/*-agenda.org']

set mouse=

set ignorecase
set smartcase

"let g:cscope_map_keys = 1

if has("cscope")
	set csprg=/usr/local/bin/cscope
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
	    cs add cscope.out
	" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
	    cs add $CSCOPE_DB
	endif
	set csverb
endif

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>a :cs find a <C-R>=expand("<cword>")<CR><CR>

" horizontal split

nmap <C-Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-Space>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>a :scs find a <C-R>=expand("<cword>")<CR><CR>

" vertical split

nmap <C-Space><C-Space>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space><C-Space>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>a :vert scs find a <C-R>=expand("<cword>")<CR><CR>

