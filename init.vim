set nocompatible              " be iMproved, required
filetype off                  " required
filetype plugin on

" set the runtime path to include Vundle and initialize
" set rtp+=~/.config/nvim/bundle/Vundle.vim
call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tmhedberg/matchit'
Plug 'vim-scripts/surround.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'tpope/vim-abolish'
Plug 'tmhedberg/SimpylFold'
Plug 'iamcco/markdown-preview.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'lervag/vimtex'
Plug 'folke/tokyonight.nvim'
Plug 'sainnhe/sonokai'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'ervandew/supertab'

" deprecated supertab plugin
" let g:SuperTabDefaultCompletionType = "<c-n>"
" let g:SuperTabContextDefaultCompletionType = "<c-n>"
"

imap <silent><script><expr> <C-E> copilot#Accept("\<CR>")
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
let g:copilot_no_tab_map = v:true
let g:copilot_proxy = 'http://cu01:14227'
let g:copilot_proxy_strict_ssl = v:false

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ exists('b:_copilot.suggestions') ? copilot#Accept("\<CR>") :
      \ CheckBackSpace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>f  :<C-u>call CocAction('format')<cr>
nmap <silent> gd <Plug>(coc-definition)

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" vimtex
let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
let g:vimtex_fold_enabled = 0 "So large files can open more easily
let g:vimtex_compiler_latexmk_engines = {
    \ '_'                : '-xelatex',
    \}
let g:vimtex_compiler_latexmk = { 
        \ 'executable' : 'latexmk',
        \ 'options' : [ 
        \   '-xelatex',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}
nmap <c-c> <plug>(vimtex-errors)
nmap <space>lc <plug>(vimtex-compile-toggle)
nmap <space>ll <plug>(vimtex-compile)
nmap <space>lv <plug>(vimtex-view)

call plug#end()            " required
filetype plugin indent on    " required

" NERDTree Plug Settings
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
noremap <T> :NERDTreeToggle<CR>


" START 'SET' SETTINGS
set number
set background="dark"
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
set splitright
set splitbelow
set ruler
set guicursor=
let autosave=2
let python_highlight_all=1

" call ack by grep
set grepprg=ack\ --nogroup\ --column\ $*
set grepformat=%f:%l:%c:%m
" END 'SET' SETTINGS

" mute highlight search shortcut
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
inoremap <silent> <C-p> <Esc>:Copilot panel<CR>

" inoremap <silent> <space>b import pdb; pdb.set_trace()
nnoremap <silent><nowait> <space>b Oimport pdb; pdb.set_trace()<Esc>

" remap %% to complete curpath
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/': '%%'

" remap jj to esc in insert mode
inoremap jj <Esc>

" colorscheme
if has('termguicolors')
  set termguicolors
endif
" The configuration options should be placed before `colorscheme sonokai`.
let g:sonokai_style = 'andromeda'
let g:sonokai_better_performance = 1
colorscheme sonokai

if has("syntax")
  syntax on
endif

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

if has("autocmd")
    autocmd FileType make   set noexpandtab
endif

