" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.

" START VUNDLE PLUGIN
runtime! debian.vim
set nocompatible              " be iMproved, required
set showcmd
filetype off                  " required
filetype plugin on
runtime macros/matchit.vim

" set the runtime path to include Vundle and initialize
set rtp+=/home/icecreamww/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'scrooloose/nerdtree'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tmhedberg/matchit'
Plugin 'vim-scripts/surround.vim'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'tpope/vim-abolish'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
" Plugin 'nvie/vim-flake8'
" Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'alvan/vim-closetag'
Plugin 'lervag/vimtex'
Plugin 'iamcco/markdown-preview.vim'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'jiangmiao/auto-pairs'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" END VUNDLE PLUGIN

" BEGIN NERDTree PLUGIN
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
noremap <T> :NERDTreeToggle<CR>
" END NERDTree PLUGIN


" START 'SET' SETTINGS
set number
set incsearch
set hlsearch
set hidden
set pastetoggle=<f5>
set encoding=utf-8
set infercase
set ts=4
set autoindent
set expandtab
set shiftwidth=4
set showmatch
set foldmethod=indent
set foldlevel=99
let autosave=2
let python_highlight_all=1

" call ack by grep
set grepprg=ack\ --nogroup\ --column\ $*
set grepformat=%f:%l:%c:%m
" END 'SET' SETTINGS

" START YCM
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_seed_identifiers_with_syntax = 1 
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" END YCM

" START vim-latex-live-preview
let g:livepreview_engine = 'xelatex'
" END vim-laetx-live-preivew


" START 'MAP' SETTING

" change default behavior for motion on real lines and display lines
" nnoremap k gk
" nnoremap gk k
" nnoremap j gj
" nnoremap gj j

" redo last substitute command with same flags, enable different range in
" visual mode
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" mute highlight search shortcut
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" remap disable sync check
nnoremap <silent> <C-a> :<C-u>SyntasticReset<CR><C-a>

" remap %% to complete curpath
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/': '%%'
" END 'MAP' SETTING

" remap jj to esc in insert mode
inoremap jj <Esc>


" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" colorscheme
colo desert

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

if filereadable("/etc/vim/syntastic.vimrc")
  source /etc/vim/syntastic.vimrc
endif

