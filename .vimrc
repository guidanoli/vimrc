" --------------------------------
" Vim configuration file
" Author: Guilherme Dantas
" Contact: guidanoli@hotmail.com
" --------------------------------

" -----------------------
" Basic options
" -----------------------

" Turn on syntax highlight
syntax on

" Auto indent
set ai

" Smart indent
set si

" Highlight search
set hls

" Incremental search
set is

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

" Detect indentation
Plug 'ciaranm/detectindent'

" Initialize plugin system
call plug#end()

" -----------------------
" Advanced options
" -----------------------

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
