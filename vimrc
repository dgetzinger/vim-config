""==============================================================================
""
""  vimrc:	Personalized vimrc file
""
""  Version:	v0.9
""
""  Maintainer:	David C. Getzinger
"" 		<dgetzinger_NOSPAM_777@gmail.com> (delete "_NOSPAM_")
""
""  Last Mod:	Thursday July 21, 2016 13:48:51 China Standard Time
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

"" Source test file showing active highlight groups
command! Hitest :source $VIMRUNTIME/syntax/hitest.vim
cnoreabbrev ht Hitest

" Works only if vim-HiLInkTrace is loaded
nnoremap <C-p> :HLT!<CR>

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
noremap! ;; <ESC>
noremap! ii <ESC>

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
set showmode				" show current editing mode
set showcmd				" show partial commands
set cursorline				" highlight cursor line
set backspace=eol,start,indent		" allow backspace to delete everything
set showmatch
	\ matchpairs=(:),{:},[:],<:>
set listchars+=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set nolist				" don't show unprintables until asked

"" Line numbering ----------------------
set relativenumber			" default
nnoremap <C-n> :call CycleLineNumbering()<CR>
""" i sets absolute numbering, <Esc> sets it back
autocmd BufEnter,InsertLeave * set number relativenumber
autocmd BufLeave,InsertEnter * set number norelativenumber

"" Searching ---------------------------
set ignorecase smartcase		" ignore case absent caps in search pattern
set incsearch hlsearch
set wrapscan		
set gdefault				" substitutions are global by default

""" Remap * and # to search for current selection, not current word
""" VSetSearch function defined below
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-r>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-r>=@/<CR><CR>

""" <C-l> to turn off search results and redraw screen
nnoremap <C-l> :<C-u>nohlsearch<CR><C-l>

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
nnoremap <C-s> :write<CR>
inoremap <C-s> <C-c>:write<CR>
nnoremap <F3> :source %<CR>
nnoremap <S-F3> :bunload<CR>


"" Movements within buffers -----------

""" Jump multiple screen lines and center
nnoremap <C-j> 10gj10<C-e>zz
nnoremap <C-k> 10gk10<C-y>zz

"" Quick visual selection --------------
"" Function definitions follow at bottom
nnoremap c<space> viw
nnoremap c. vis
nnoremap c<CR> vip
nnoremap cx :call SelectEntireFile()<CR>

""" Expand visual selection back one char, word
vnoremap <space>h <Esc>gvoho
vnoremap <space>b <Esc>gvobo

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

""" Leave cursor at end of ...
noremap P gP
noremap p gp
noremap gP P
noremap gp p
nnoremap y y`]
vnoremap y y`]
vnoremap U U`>
vnoremap u u`>

""" ^e and ^y work in insert mode too
inoremap <C-e> <C-x><C-e>
inoremap <C-y> <C-x><C-y>

""" <C-d> delete-forward one character, <C-f> one Word
noremap! <C-d> <Del>
noremap! <C-f> <C-o>dE

""" ␣q, ␣Q autoreformat current paragraph, entire document
nnoremap <localleader>q igqip`^
nnoremap <localleader>Q iggVGgq`^

""" g( and g) jump to first (last) character in sentence
""" g{ and g} jump to first (last) character in paragraph
""" (default (,),{,} jump to last character *around* sentence/paragraph
nnoremap g( vis`<
nnoremap g) vis`>
nnoremap g{ vip`<^
nnoremap g} vip`>

""" Quick-select inside, around sentences and paragraphs
nnoremap <localleader>( vis
nnoremap <localleader>) vas
nnoremap <localleader>{ vip
nnoremap <localleader>} vap

""" ␣O and ␣o open a new para two lines above, below current
nnoremap <localleader>O vip`<OO
nnoremap <localleader>o vip`>oo

""" Quick macro:  qq to record, q to stop, @q to play back
nnoremap Q @q
vnoremap Q :normal! @q<CR>

" gg, G jump to absolute beginning, end of file
nnoremap G G$
nnoremap gg gg0

" insert &nbsp; (U+00A0)
inoremap <leader><space> <C-v>u00A0

" leave cursor at end of visual selection after capitalizing


"}}} General editing


" Plain text autocommands --------------------------------------------------{{{
augroup text_settings
	autocmd!

	" general formatting
	autocmd FileType text,markdown,mail,fountain setlocal formatoptions=nq2

	" soft wrapping
	autocmd FileType text,markdown,mail,fountain setlocal nonumber
	autocmd FileType text,markdown,mail,fountain
		\ setlocal wrap linebreak nolist textwidth=999
		\ wrapmargin=0 showbreak=
	autocmd FileType text,markdown,mail,fountain
		\ setlocal tabstop=5 shiftwidth=5
		\ nosmartindent noautoindent nobreakindent

	" ␣' and ␣" enquote visual selection
	" U+2018, U+2019 are curly single quotes, U+201C & U+201D double
	autocmd FileType text,markdown,mail,fountain xnoremap <buffer> <localleader>' c'+'
	autocmd FileType text,markdown,mail,fountain xnoremap <buffer> <localleader>" c"+"
	
	" Visual selection: <C-b> for bold, <C-i> for italics
	autocmd FileType text,markdown,mail,fountain xnoremap <buffer> <C-i> c*+*
	autocmd FileType text,markdown,mail,fountain xnoremap <buffer> <C-b> c__+__

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


"" Cycle among nonumber, number and relativenumber
function! CycleLineNumbering()
	if (&number == 0) | set number norelativenumber
	elseif (&relativenumber == 0) | set number relativenumber
	else | set nonumber norelativenumber
	endif
endfunction
command! CLN :call CycleLineNumbering()
cnoreabbrev cln CLN


"" Visual select entire file
"" Return cursor to former position: ``
function! SelectEntireFile()
	let l:savedcurpos = getcurpos()
	normal! ggVG
	call setpos("'`", l:savedcurpos)
endfunction


"" Set search string equal to current selection, escaped
function! s:VSetSearch(cmdType)
	let l:saved = @s
	normal! gv"sy
	let @/ = '\V' . substitute(escape(@s, a:cmdType . '\'), '\n', '\\n', 'g')
	let s = l:saved
endfunction


"" Reset textwidth
"" Usage: :tw 80
if exists(':Textwidth') | delcommand Textwidth | endif
command! -nargs=? Textwidth call ResetTextwidth(<f-args>)
cnoreabbrev tw Textwidth

function! ResetTextwidth(...)

	let l:defaultWidth = 9999

	if a:0 < 1 || a:1 < 0			" no arg or negative value supplied
		let l:newWidth = l:defaultWidth
	else
		let l:newWidth = a:1 + 0	" coerce to number
	endif
	
	exec "setlocal textwidth=" . l:newWidth

endfunction "ResetTextwidth

"}}} Functions/commands
