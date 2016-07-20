""==============================================================================
""
""  vimrc:	Personalized vimrc file
""
""  Version:	v0.9
""
""  Maintainer:	David C. Getzinger
"" 		<dgetzinger_NOSPAM_777@gmail.com> (delete "_NOSPAM_")
""
""  Last Mod:	Wednesday July 20, 2016 16:38:21 China Standard Time
""
""  Usage:	Copy to $VIMFILES as .vimrc then restart vim
""
""  License:	Vim license	
""
""  Notes:	Script loads colorscheme "belladonna""if installed
""
""==============================================================================


setlocal foldmethod=marker


" Filetypes and syntax ------------------------------------------------------{{{
filetype on				" enable auto filetype detection
filetype plugin on			" load plugins for specific file types
filetype plugin indent on		" filetype-specific indentation
"}}}


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

	if has('gui_win32')
		set guifont=Inconsolata:h12:cANSI
		autocmd GUIEnter * simalt ~x
	endif

	if has('gui_macvim')
		set guifont=Hack:h13
		set lines=64
		set columns=240
	endif
endif
"}}}


" Colorscheme --------------------------------------------------------------{{{
"" (save colorscheme script to $VIMFILES/colors

set t_Co=256				" 256-color terminal
silent! colorscheme belladonna		" silently ignore if not found
syntax on				" auto syntax highlighting

"}}}


" Status line --------------------------------------------------------------{{{

set laststatus=2			" always show status line

set statusline=
set statusline+=b%n:			" buffer number
set statusline+=%t			" relative path to current file from PWD
set statusline+=\ %y			" filetype
set statusline+=\ (%l\/%L,\ %v/%{&tw})	" (line:col)
"set statusline+=\ U+%04.4B		" Unicode BMP value of char under cursor (4 digits)
set statusline+=\ %{strlen(&fo)?&fo:''}	" format options
set statusline+=%=			" right-align following
set statusline+=\ %-{getcwd()}		" current working directory

"}}}


" General behavior ---------------------------------------------------------{{{

"" Alternatives to <Esc> --------------
noremap! jk <ESC>
noremap! jj <ESC>

"" Mapping ----------------------------
"" Consider remapping CAPS LOCK key to CTRL
""   Windows:  SharpKeys http://http://sharpkeys.codeplex.com/
""   OSX:  System Preferences > Keyboard > Modifier Keys

let mapleader		= "\<bslash>"
let maplocalleader	= "\<space>"
set timeoutlen=750			" ms to wait for map completion

"" Format options ---------------------
set formatoptions=croq			" :help 'fo-table' for list

"" Settings ---------------------------
set nocompatible			" allow various non-vi options
set modelines=0				" plug security hole (per Steve Losh)
set hidden				" hide buffer when abandoned
set clipboard=unnamed			" use register * for system clipboard
set autowrite				" autosave before switching buffers
set exrc				" read exrc/vimrc from local dirs
set fileformats=unix,dos		" read/write in this format
set encoding=utf-8
set relativenumber			" auto line numbering relative to cursor
set showmode				" show current editing mode
set showcmd				" show partial commands
set cursorline				" highlight cursor line
set backspace=eol,start,indent		" allow backspace to delete everything
set showmatch
	\ matchpairs=(:),{:},[:],<:>
set listchars+=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set nolist				" don't show unprintables until asked

"" Searching ---------------------------
set ignorecase smartcase		" ignore case absent caps in search pattern
set incsearch hlsearch
set wrapscan		
set gdefault				" substitutions are global by default

""" <C-l> to turn off search results
nnoremap <C-l> <C-u>:nohlsearch<CR><C-l>

"" Scrolling ---------------------------
set scrolloff=3				" minimum context at top/bottom of screen
set nostartofline			" keep cursor in same col after jumps

""" Toggle 'typewriter-like' scrolling with ␣zz
nnoremap <leader>zz :let &scrolloff=999-&scrolloff<CR>

"" Tabbing -----------------------------
set tabstop=8				" # of spaces <Tab> counts for
set shiftwidth=8			" # of spaces to use for each (auto)indent
set noexpandtab				" do not expand <Tab> to spaces

" Wrapping -----------------------------
set textwidth=0				" prevent wrapping
set linebreak				" wrap lines at 'breakat' chars
set breakat=\ \	!@*-+;:,./?		" break line after <SP> <TAB> etc.
set showbreak===>			" prefixed to continued lines

"" Indentation ------------------------
set smartindent autoindent breakindent

"" Encryption -------------------------
set cryptmethod=blowfish2		" :X to encrypt

"" Kill that fucking beep -------------
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

"" Filetype discovery -----------------
autocmd BufRead,BufNewFile *.fountain,*.ftn set filetype=fountain

"}}}


" General editing ----------------------------------------------------------{{{

"" Pane actions -----------------------

""" Automatically jump to new pane
nnoremap <leader><bar> <C-w>v<C-w>l
nnoremap <leader>_ <C-w>s<C-w>k
nnoremap <C-w>v <C-w>v<C-w>l
nnoremap <C-w>s <C-w>s<C-w>k

""" ␣<C-x> jump around panes
nnoremap <localleader><C-h> <C-w>h<CR>
nnoremap <localleader><C-l> <C-w>l<CR>
nnoremap <localleader><C-j> <C-w>j<CR>
nnoremap <localleader><C-k> <C-w>k<CR>


"" Buffer actions ---------------------

""" Automatically jump to directory of current file
autocmd BufEnter * lcd %:p:h

""" Cycle through buffers
nnoremap <S-Right> :bn<CR>
nnoremap <S-Left> :bp<CR>
"""" <C-^> = toggle between buffers

""" Save, source, unload
"""" normal mode
nnoremap <leader>s :write<CR>
inoremap <leader>s <C-c>:write<CR>
nnoremap <leader>q :quit<CR>
nnoremap <F3> :source %<CR>
nnoremap <S-F3> :bunload<CR>


"" Movements within buffers -----------

""" Jump multiple screen lines and center
nnoremap <C-j> 10gj10<C-e>zz
nnoremap <C-k> 10gk10<C-y>zz

""" Quick macro:  qq to record, q to stop, @q to play back
nnoremap Q @q
vnoremap Q :normal! @q<CR>

""" Operate on screen lines, not logical lines
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

""" Leave cursor at end of pastes
noremap P gP
noremap p gp
noremap gP P
noremap gp p

""" ^e and ^y work in insert mode too
inoremap <C-e> <C-x><C-e>
inoremap <C-y> <C-x><C-y>


"" Quick visual selection --------------
nnoremap <localleader>w viw
nnoremap <localleader>W viW
nnoremap <localleader>( vi(
nnoremap <localleader>) va)
nnoremap <localleader>{ vi{
nnoremap <localleader>} va}
nnoremap <localleader>[ vi[
nnoremap <localleader>] va]
nnoremap <localleader>< vi<
nnoremap <localleader>> va>


"" Editing commands -------------------

""" <C-d> delete-forward one character, <C-f> one Word
noremap! <C-d> <Del>
noremap! <C-f> <C-o>dE

"}}} General editing


" Plain text autocommands --------------------------------------------------{{{
augroup text_settings
	autocmd!

	" general formatting
	autocmd FileType text,markdown,mail,fountain setlocal formatoptions=nq2

	" soft wrapping
	autocmd FileType text,markdown,mail,fountain setlocal nonumber
	autocmd FileType text,markdown,mail,fountain call ResetTextwidth()
	autocmd FileType text,markdown,mail,fountain
		\ setlocal wrap linebreak nolist
		\ wrapmargin=0 showbreak=
	autocmd FileType text,markdown,mail,fountain
		\ setlocal tabstop=5 shiftwidth=5
		\ nosmartindent noautoindent nobreakindent

	" ␣q, ␣Q autoreformat current paragraph, entire document
	autocmd FileType text,markdown,mail,fountain nnoremap <buffer> <localleader>q igqip`^
	autocmd FileType text,markdown,mail,fountain nnoremap <buffer> <localleader>Q iggVGgq`^

	" g( and g) jump to first (last) character in sentence
	" g{ and g} jump to first (last) character in paragraph
	" (default (,),{,} jump to last character *around* sentence/paragraph
	autocmd FileType text,markdown,mail,fountain nnoremap <buffer> g( vis`<
	autocmd FileType text,markdown,mail,fountain nnoremap <buffer> g) vis`>
	autocmd FileType text,markdown,mail,fountain nnoremap <buffer> g{ vip`<^
	autocmd FileType text,markdown,mail,fountain nnoremap <buffer> g} vip`>

	" Quick-select inside, around sentences and paragraphs
	autocmd FileType text,markdown,mail,fountain nnoremap <buffer> <localleader>( vis
	autocmd FileType text,markdown,mail,fountain nnoremap <buffer> <localleader>) vas
	autocmd FileType text,markdown,mail,fountain nnoremap <buffer> <localleader>{ vip
	autocmd FileType text,markdown,mail,fountain nnoremap <buffer> <localleader>} vap

	" ␣O and ␣o open a new para two lines above, below current
	autocmd FileType text,markdown,mail,fountain nnoremap <buffer> <localleader>O vip`<OO
	autocmd FileType text,markdown,mail,fountain nnoremap <buffer> <localleader>o vip`>oo

	" ␣' and ␣" enquote visual selection
	" U+2018, U+2019 are curly single quotes, U+201C & U+201D double
	autocmd FileType text,markdown,mail,fountain xnoremap <buffer> <localleader>' c'+'
	autocmd FileType text,markdown,mail,fountain xnoremap <buffer> <localleader>" c"+"
	
	" Visual selection: <C-b> for bold, <C-i> for italics
	autocmd FileType text,markdown,mail,fountain xnoremap <buffer> <C-i> c*+*
	autocmd FileType text,markdown,mail,fountain xnoremap <buffer> <C-b> c__+__

	" leave cursor at end of selection following yank - allows pppp ...
	autocmd FileType text,markdown,mail,fountain noremap y y`]

	" gg, G jump to absolute beginning, end of file
	autocmd FileType text,markdown,mail,fountain noremap G G$
	autocmd FileType text,markdown,mail,fountain noremap gg gg0

	" insert &nbsp; (U+00A0)
	autocmd FileType text,markdown,mail,fountain inoremap <leader><space> <C-v>u00A0

	" capitalize last word
	autocmd FileType text,markdown,mail,fountain inoremap <leader>c <Esc>viwU<Esc>ea


augroup END
"}}} Plain text


" User-defined functions and commands ---------------------------------------{{{


"" Return timestring in format 'Sunday July 07, 2016 08:48:09 HKT'
"" see http://strftime.net/ for C99 format builder
"" Note: Windows strftime() does not conform to C99 so not all
"" format codes implemented (e.g., %e, %T, %z
function! TimeStamp()
	let timestr = strftime("%A %B %d, %Y %H:%M:%S %Z")
	return timestr
endfunction
noremap! <leader>t <C-r>=TimeStamp()<CR>
nnoremap <leader>t C<C-r>=TimeStamp()<CR><Esc>`[


"" Quick visual select entire file
"" Current cursor position saved in '`
function! SelectEntireFile()
	let l:savedcurpos = getcurpos()
	normal! ggVG
	call setpos("'`", l:savedcurpos)
endfunction
nnoremap <leader>a :call SelectEntireFile()<CR>


"" Reset textwidth and reformat entire document in one command
"" Usage: :tw 80
if exists(':Textwidth') | delcommand Textwidth | endif
command! -nargs=? Textwidth call ResetTextwidth(<f-args>)
cnoreabbrev tw Textwidth

function! ResetTextwidth(...)

	let l:defaultWidth = 10000

	if a:0 < 1 || a:1 < 0			" no arg or negative value supplied
		let l:newWidth = l:defaultWidth
	else
		let l:newWidth = a:1 + 0	" coerce to number
	endif
	
	" Reset textwidth and reformat
	let l:savedcurpos = getcurpos()
	exec "setlocal textwidth=" . l:newWidth
	normal! ggVGgq
	call setpos('.', l:savedcurpos)

endfunction "ResetTextwidth

"}}} Functions/commands
