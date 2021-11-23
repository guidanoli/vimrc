" --------------------------------
" Vim configuration file
" Author: Guilherme Dantas
" Contact: guidanoli@hotmail.com
" --------------------------------

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

" Hybrid line numbers
set nu rnu

" Set map leader
let mapleader='\'

" If vim suports persisent undo
if has('persistent_undo')

	" Set directory for undo files
	set undodir=$HOME/.vim/undo

	" Allow persistent undo file storage
	set undofile

endif

" -----------------------
" Plug-ins
" -----------------------

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Syntax highlight for Solidity
Plug 'tomlion/vim-solidity'

" Interactive Coq Proofs
Plug 'whonore/Coqtail'

" Retro groove color scheme
Plug 'morhetz/gruvbox'

" Initialize plugin system
call plug#end()

" -----------------------
" Configure plugins
" -----------------------

" joom/latex-unicoder.vim
let g:unicoder_cancel_normal = 1
let g:unicoder_cancel_insert = 1
let g:unicoder_cancel_visual = 1
nnoremap <C-l> :call unicoder#start(0)<CR>
inoremap <C-l> <Esc>:call unicoder#start(1)<CR>
vnoremap <C-l> :<C-u>call unicoder#selection()<CR>

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
