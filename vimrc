"==============================================================================
"  .vimrc_common.vim
"  Sourced by .vimrc. Copy to $HOME.
"  Last rev 2016-07-05
"==============================================================================


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" gui settings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if has('gui_running')

	" All good console fonts, system should have at least one
	set guifont=Consolas:h11:cANSI
	set guifont=Inconsolata:h12:cANSI
	set guifont=Cousine:h11:cANSI
	set guifont=Hack:h11:cANSI
	set guifont=Akkurat_Mono_Pro:h10:cANSI

	set guioptions-=T			" drop the toolbar
    if has('gui_win32')			" maximize window on open
        au GUIEnter * simalt ~x
    endif
endif


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Set colors. Save relevant colorscheme to $VIMFILES/colors.
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set t_Co=256					" 256-color terminal
colorscheme author
syntax on						" auto syntax highlighting


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" general behavior
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set nocompatible				" allow various non-vi options
"set hidden						" hide buffer when abandoned
set clipboard=unnamed			" use register * for system clipboard
set autowrite					" autosave before switching buffers
set exrc						" read exrc/vimrc from local dirs
set fileformats=unix,dos		" read/write in this format
set encoding=utf-8


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" filetypes and syntax
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
filetype on						" enable auto filetype detection
filetype plugin on				" load plugins for specific file types
filetype plugin indent on		" filetype-specific indentation

autocmd BufNewFile,BufRead *.md,*.markdown,*.mkd,*.mmd set filetype=markdown
autocmd BufEnter * if &filetype == "" | setlocal ft=text | endif


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" default format options
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set formatoptions=croq			" :help 'fo-table' for list


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Status line (:help statusline for options)
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"set statusline=%-t\ %m\ [b%n]\ [ft=%{&ft}]\ [fo=%{&fo}]\ [line=%-l\/%L]\ [col=%v]\ [ASCII=%03.3b/HEX=%03.3B]
set statusline=b%n:%-f\ %{&ft}\ +%{&fo}\ line=%l\/%L\ col=%v/%{&tw}\ U+%04.4B
set laststatus=2				" always show status line


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" search options
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set incsearch					" highlight next search term instance
set hlsearch					" underline all instances of last search
set ignorecase					" generally ignore case when searching
set smartcase					" ... except when capitals typed
set wrapscan					" searches wrap around end of buffer


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" general editing
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set number						" auto line numbering
set showmode					" show current editing mode
set showcmd						" show partial commands
set backspace=eol,start,indent	" allow backspace to delete everything
set report=0					" report number of lines changed
set showmatch					" briefly jump to matching paren
set matchpairs=(:),{:},[:],<:>	" pairs for showmatch option
set nostartofline				" keep cursor in same col after jumps

" formatting and indentation
set textwidth=0					" prevent wrapping
set tabstop=4					" # of spaces <Tab> appears as
set noexpandtab					" do not expand <Tab> to spaces
set shiftwidth=4				" # of spaces to use for each (auto)indent
set linebreak					" wrap lines at 'breakat' chars
set breakat=\ \	!@*-+;:,./?		" break line after <SP> <TAB> etc.
set showbreak+=\\				" preceed continued lines with \
set breakindent


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" global mappings (:help map-special-keys for options)
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"""" NORMAL MODE """"

" <M-j> and <M-k>: move down (up) one screen (cf. logical) line
nnoremap <M-j> gj
nnoremap <M-k> gk

" <C-Right> and <C-Left>: cycle forward (back) through open buffers
nnoremap <C-Right> :bn<CR>
nnoremap <C-Left> :bp<CR>

" <C-Down> and <C-Up>: cycle down (up) through open windows
nnoremap <C-Down> j 
nnoremap <C-Up> k


"""" INSERT MODE """"

" jk exit insert mode (as do <Esc>, <C-[>, and <C-c>). Thanks Steve Losh!
inoremap jk <Esc>

" <M-x> forward-delete one character, <M-d> one Word
inoremap <C-d> <Del>
inoremap <M-d> <C-o>dE


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" plain text editing
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
autocmd FileType text,markdown setlocal textwidth=64 shiftwidth=0 formatoptions=cqtan2 breakindent


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" abbreviations
" ^V in insert mode to quote special keys
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iabbrev #d #define
iabbrev #i #include
iabbrev #-- 0C#-------------------------------------------------------------------------------
iabbrev #== 0C#===============================================================================
iabbrev /** 0C/*******************************************************************************
iabbrev **/ 0C ******************************************************************************/

