" --------------------------------
" Vim configuration file
" Author: Guilherme Dantas
" Contact: guidanoli@hotmail.com
" --------------------------------

" ----------------------------------
" Automatic installation of vim-plug
" ----------------------------------

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" -----------------------
" Basic options
" -----------------------

" Syntax highlight
syntax on

" Auto indent
set ai

" Smart indent
set si

" Highlight search
set hls

" Incremental search
set is

" Absolute line numbers
set nu

" Set map leader
let mapleader='\'

" If vim suports persisent undo
if has('persistent_undo')

	" Define target path for undo files
	let target_path = expand('~/.vim/undo')

	" Create the directory if the location
	" does not exist yet
	if !isdirectory(target_path)
		call system('mkdir -p ' . target_path)
	endif

	" Set directory for undo files
	let &undodir = target_path

	" Allow persistent undo file storage
	set undofile

endif

" -----------------------
" Plug-ins
" -----------------------

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Vim syntax file for solidity
Plug 'TovarishFin/vim-solidity'

" Interactive Coq Proofs
Plug 'whonore/Coqtail'

" Retro groove color scheme
Plug 'morhetz/gruvbox'

" A minimalist task manager for vim
Plug 'vuciv/vim-bujo'
let g:bujo#window_width = 80

" CamelCase motion through words
Plug 'bkad/CamelCaseMotion'
let g:camelcasemotion_key = ';'

" Vim syntax for TOML
Plug 'cespare/vim-toml', { 'branch': 'main' }

" Vim python-mode. PyLint, Rope, Pydoc, breakpoints from box. 
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
let g:pymode_lint_unmodified = 0

" Typescript syntax files for Vim
Plug 'leafgarland/typescript-vim'

" Better Lua syntax highlighting in Vim/NeoVim
Plug 'euclidianAce/BetterLua.vim'

" Initialize plugin system
call plug#end()

" -----------------------
" Color scheme
" -----------------------

" Setting dark mode
set background=dark

" Configuring color scheme
let g:gruvbox_contrast_dark='soft'

" Setting color scheme
colorscheme gruvbox

" -----------------------
" Key mappings
" -----------------------

" Clear search highlight
nmap <silent> <Leader>n :noh<CR>

" -----------------------
" Advanced options
" -----------------------

" Return to last edit position when opening files
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif

" By default, use spaced tabs.
set expandtab

" Display tabs as 4 spaces wide. When expandtab is set, use 4 spaces.
set shiftwidth=4
set tabstop=4

function TabsOrSpaces()
	" Determines whether to use spaces or tabs on the current buffer.
	if getfsize(bufname("%")) > 256000
		" File is very large, just use the default.
		return
	endif

	let numTabs=len(filter(getbufline(bufname("%"), 1, 250), 'v:val =~ "^\\t"'))
	let numSpaces=len(filter(getbufline(bufname("%"), 1, 250), 'v:val =~ "^ "'))

	if numTabs > numSpaces
		setlocal noexpandtab
	endif
endfunction

" Call the function after opening a buffer
autocmd BufReadPost * call TabsOrSpaces()
