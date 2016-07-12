"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
"  Name:	.vimrc - personalized vim run control file
"
"  Author:	David C. Getzinger <dgetzinger|NOSPAM|777@gmail.com> (delete "|NOSPAM|")
"
"  Date:	11 July 2016
"
"  Version:	v0.9
"
"  Usage:	Copy to $VIMFILES as .vimrc then restart vim
"
"  License:	
"
"  NOTES:	Script loads colorscheme "belladonna" if it is installed
"
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setlocal foldmethod=marker

" Gui settings -------------------------------------------------------------{{{
if has('gui_running')

	" All excellent free or open console fonts
	"set guifont=Consolas:h11:cANSI
	"set guifont=Cousine:h11:cANSI
	"set guifont=Fantasque_Sans_Mono:h11:cANSI
	"set guifont=Hack:h11:cANSI
	"set guifont=Inconsolata:h12:cANSI
	"set guifont=InputMono:h11:cANSI
	"set guifont=Menlo:h11:cANSI	(Apple font; Mac only)
	"set guifont=Liberation_Mono:h10:cANSI
	"set guifont=Source_Code_Pro:h11:cANSI

	set guioptions-=T			" drop the toolbar

    if has('gui_win32')			" maximize window on open
		set guifont=Inconsolata:h12:cANSI
        au GUIEnter * simalt ~x
    endif

    if has('gui_macvim')
		set guifont=Hack:h13
		set lines=64
		set columns=200
    endif
endif
"}}}

" Colorscheme --------------------------------------------------------------{{{
" (save colorscheme script to $VIMFILES/colors
set t_Co=256					" 256-color terminal
silent! colorscheme belladonna	" silently ignore if not found
syntax on						" auto syntax highlighting
"}}}

" General behavior ---------------------------------------------------------{{{
set nocompatible				" allow various non-vi options
set modelines=0					" plug security hole (per Steve Losh)
set hidden						" hide buffer when abandoned
set clipboard=unnamed			" use register * for system clipboard
set autowrite					" autosave before switching buffers
set exrc						" read exrc/vimrc from local dirs
set fileformats=unix,dos		" read/write in this format
set encoding=utf-8
set formatoptions=croq			" :help 'fo-table' for list
"}}}

" Filetypes and syntax -----------------------------------------------------{{{
filetype on						" enable auto filetype detection
filetype plugin on				" load plugins for specific file types
filetype plugin indent on		" filetype-specific indentation

autocmd BufNewFile,BufRead *.md,*.markdown,*.mkd,*.mmd set filetype=markdown
autocmd BufEnter * if &filetype == "" | setlocal ft=text | endif
"}}}

" Status line --------------------------------------------------------------{{{
" :help 'statusline'
set laststatus=2			" always show status line

set statusline=b%n:			" buffer number
set statusline+=%-f			" relative path to current file from PWD
set statusline+=\ [%{&ft}]		" filetype
set statusline+=%=			" right-align following
set statusline+=\ +%{&fo}		" filetype options
set statusline+=\ line=%l\/%L		" current line/total lines
set statusline+=\ col=%v/%{&tw}		" current col/textwidth
set statusline+=\ U+%04.4B		" Unicode BMP value of char under cursor (4 digits)
"}}}

" Search options -----------------------------------------------------------{{{
set ignorecase smartcase
set incsearch hlsearch
set wrapscan		
set gdefault	

" 'very magic' mode - enable POSIX regex parsing by default
" Doesn't work with :g and may mess with vim's search history
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/
nnoremap :g/ :g/\v
nnoremap :g// :g//
"}}}

" General editing ----------------------------------------------------------{{{
set number				" auto line numbering
set showmode				" show current editing mode
set showcmd				" show partial commands
set cursorline				" highlight cursor line
set backspace=eol,start,indent		" allow backspace to delete everything
set report=0				" report number of lines changed
set showmatch matchpairs=(:),{:},[:],<:>

" scrolling and cursor movement
set scrolloff=3				" minimum context at top/bottom of screen
set nostartofline			" keep cursor in same col after jumps

" textwidth, indentation, line breaks
set textwidth=0				" prevent wrapping

" Prefer hard tab indentation
set tabstop=8				" # of spaces <Tab> counts for
set shiftwidth=8			" # of spaces to use for each (auto)indent
set noexpandtab				" do not expand <Tab> to spaces

set linebreak				" wrap lines at 'breakat' chars
"set breakat=\ \	!@*-+;:,./?	" break line after <SP> <TAB> etc.
set showbreak+===>			" prefixed to continued lines

set smartindent autoindent breakindent
"}}}

" General mappings ---------------------------------------------------------{{{
" (:help map-special-keys for options)
let mapleader = "\<Space>"
let maplocalleader = "\<Bslash>"
set timeoutlen=700				" ms to wait before acting on ambiguous map

"--------------------------------------------------------------
" Consider remapping CAPS LOCK key to CTRL
"   Windows:  SharpKeys http://http://sharpkeys.codeplex.com/
"   OSX:  System Preferences > Keyboard > Modifier Keys
"--------------------------------------------------------------

nnoremap :g// :g//" Normal mode mappings ---------------------------------------------{{{

" ␣zz toggles typewriter scrolling on/off
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" #<CR> jump straight to line #
nnoremap <CR> G
nnoremap <BS> gg

" Visually select word, Word under cursor
nnoremap <Leader>w viw
nnoremap <Leader>W viW

" Quick-select inside, around brackets
nnoremap <Leader>( vi(
nnoremap <Leader>) va)
nnoremap <Leader>{ vi{
nnoremap <Leader>} va}
nnoremap <Leader>[ vi[
nnoremap <Leader>] va]
nnoremap <leader>< vi<
nnoremap <Leader>> va>

" <F2> quick file save
" <F3> (in vim section below) quick source (vim files only)
" <F4> buffer delete; <Leader><F4> quit
nnoremap <F2> :write<CR>
nnoremap <F4> :bd<CR>
nnoremap <Leader><F4> :q<CR>

" ␣| opens new vertical split and moves to it
nnoremap <Leader><Bar> <C-w>v<C-w>l

" Quicker movements around splits using Ctrl+hjkl keys
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" <C-Right> and <C-Left>: cycle forward (back) through open buffers
" Shadowed by system command on OSX
nnoremap <C-Right> :bn<CR>
nnoremap <C-Left> :bp<CR>
"}}}


" Normal, visual, select mode mappings ------------------------------{{{

" jk^$ operate on screen lines, not logical lines, unless prefixed with g
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap ^ g^
noremap g^ ^
noremap $ g$
noremap g$ $
noremap 0 g0
noremap g0 0

" p, P leave cursor at end of pasted selection unless prefixed with g
noremap P gP
noremap p gp
noremap gP P
noremap gp p

" ␣␣ exits visual mode (;; conflicts with repeat-search cmd)
xnoremap <Space><Space> <Esc>
"}}}


" Insert and command mode mappings ---------------------------------{{{

" ;; exit insert mode (as do <Esc>, <C-[>, and <C-c>)
noremap! ;; <Esc>

" <C-d> delete-forward one character, <C-f> one Word
noremap! <C-d> <Del>
noremap! <C-f> <C-o>dE
"}}}

"}}}

" Plain text autocommands --------------------------------------------------{{{
augroup text_settings
	autocmd!

	" general formatting
	autocmd FileType text,markdown setlocal formatoptions=ant

	" soft wrapping - setting wrapmargin turns it off
	autocmd FileType text,markdown setlocal wrap linebreak nolist textwidth=0 wrapmargin=0
	autocmd FileType text,markdown setlocal nosmartindent noautoindent
	autocmd FileType text,markdown setlocal showbreak= nonumber
	autocmd FileType text,markdown setlocal tabstop=5 shiftwidth=5

	" g( and g) jump to first (last) character in sentence
	" g{ and g} jump to first (last) character in paragraph
	autocmd FileType text,markdown nnoremap <buffer> g( vis`<
	autocmd FileType text,markdown nnoremap <buffer> g) vis`>
	autocmd FileType text,markdown nnoremap <buffer> g{ vip`<^
	autocmd FileType text,markdown nnoremap <buffer> g} vip`>

	" Quick-select inside, around sentences and paragraphs
	autocmd FileType text,markdown nnoremap <buffer> <Leader>( vis
	autocmd FileType text,markdown nnoremap <buffer> <Leader>) vas
	autocmd FileType text,markdown nnoremap <buffer> <Leader>{ vip
	autocmd FileType text,markdown nnoremap <buffer> <Leader>} vap

	" leave cursor at end of selection following yank - allows pppp ...
	autocmd FileType text,markdown noremap y y`]

	" Visual selection: Ʌ␣' and ␣" enquote in curly quotes
	autocmd FileType text,markdown xnoremap <buffer> <Leader>' c‘+’
	autocmd FileType text,markdown xnoremap <buffer> <Leader>" c“+”
	
	" Visual selection: <C-b> for bold, <C-i> for italics
	autocmd FileType text,markdown xnoremap <buffer> <C-i> c*+*
	autocmd FileType text,markdown xnoremap <buffer> <C-b> c__+__

	" ␣O and ␣o open new paragraph two lines above, below current one
	autocmd FileType text,markdown nnoremap <buffer> <Leader>O vip`<OO
	autocmd FileType text,markdown nnoremap <buffer> <Leader>o vip`>oo
augroup END
"}}}

" Vim file editing ----------------------------------------------------------{{{
augroup vim_settings
	autocmd!
	autocmd FileType vim setlocal formatoptions=croq number

	" <F3> quick source current file
	autocmd FileType vim nnoremap <buffer> <F3> :source %<CR>

	" comment out a line
	autocmd FileType vim nnoremap <buffer> <Leader>c I"<Esc>
augroup END
"}}}

" Shell script editing ------------------------------------------------------{{{
augroup sh
	autocmd!
	autocmd FileType sh setlocal number
augroup END
"}}}

" Make editing --------------------------------------------------------------{{{
augroup make_settings
	autocmd!
	autocmd FileType make setlocal number
augroup END
"}}}

" Theme editing ----------------------------------------------------{{{
"
" Useful plugins:
"	vim-HiLinkTrace: show syntax and highlight link stacks for word under cursor
"	HexHighlight: toggle #rrggbb values<->colors with <leader><F2>
"	GuiColorScheme:  convert guifg, guibg colors into cterm equivalents
"
" Other helpful resources:
"	http://vimcasts.org/episodes/creating-colorschemes-for-vim/
"	http://www.drchip.org/astronaut/index.html (for vim-HiLinkTrace plugin)
"
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Function to toggle current syntax and highlight class
" fallback where vim-HiLinkTrace plugin unavailable
function! <SID>SynStack()
  if exists("*synstack")
	  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
  endif
endfunc

" Call :HLT! if plugin loaded, otherwise default to function
" TODO: write function that checks whether HLT loaded; if so calls, otherwise calls SynStack()
nmap <C-S-p> :HLT!<CR>
"nmap <C-S-p> :call <SID>SynStack()<CR>
"}}}

