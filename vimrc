"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
"  Name:	.vimrc - personalized vim run control file
"
"  Author:	David C. Getzinger
"  		<dgetzinger_NOSPAM_777@gmail.com> (delete "_NOSPAM_")
"
"  Date:	Sunday July 17, 2016 10:53:16 HKT
"
"  Version:	v0.9

"  Usage:	Copy to $VIMFILES as .vimrc then restart vim
"
"  License:	
"
"  NOTES:	Script loads colorscheme "belladonna" if installed
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

	set guioptions-=T		" drop the toolbar

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
set t_Co=256				" 256-color terminal
silent! colorscheme belladonna		" silently ignore if not found
syntax on				" auto syntax highlighting
"}}}

" Status line --------------------------------------------------------------{{{
" :help 'statusline'
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
set nocompatible			" allow various non-vi options
set modelines=0				" plug security hole (per Steve Losh)
set hidden				" hide buffer when abandoned
set clipboard=unnamed			" use register * for system clipboard
set autowrite				" autosave before switching buffers
set exrc				" read exrc/vimrc from local dirs
set fileformats=unix,dos		" read/write in this format
set encoding=utf-8
set number				" auto line numbering
set showmode				" show current editing mode
set showcmd				" show partial commands
set cursorline				" highlight cursor line
set backspace=eol,start,indent		" allow backspace to delete everything
set report=0				" report number of lines changed
set showmatch
	\ matchpairs=(:),{:},[:],<:>

" format options
set formatoptions=croq			" :help 'fo-table' for list
if v:version > 703 || v:version == 703 && has("patch541")
	set formatoptions+=j " Delete comment character when joining commented lines
endif

if &listchars ==# 'eol:$'
	set listchars+=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set nolist

" scrolling and cursor movement
set scrolloff=3				" minimum context at top/bottom of screen
set nostartofline			" keep cursor in same col after jumps

" tabbing
set tabstop=8				" # of spaces <Tab> counts for
set shiftwidth=8			" # of spaces to use for each (auto)indent
set noexpandtab				" do not expand <Tab> to spaces

" line breaking
set textwidth=0				" prevent wrapping
set linebreak				" wrap lines at 'breakat' chars
set breakat=\ \	!@*-+;:,./?		" break line after <SP> <TAB> etc.
set showbreak===>			" prefixed to continued lines

" indentation
set smartindent autoindent breakindent

" kill the fucking beep
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

"}}}

" Filetypes and syntax -----------------------------------------------------{{{

filetype on				" enable auto filetype detection
filetype plugin on			" load plugins for specific file types
filetype plugin indent on		" filetype-specific indentation

"}}}

" Encryption ---------------------------------------------------------------{{{

if v:version > 730 && has("patch399")
	set cryptmethod=blowfish2
else
	set cryptmethod=zip
endif

"}}}

" Search options -----------------------------------------------------------{{{
set ignorecase smartcase		" ignore case absent caps in search pattern
set incsearch hlsearch
set wrapscan		
set gdefault				" substitutions are global by default

nnoremap <localleader>L :set hlsearch<CR>
nnoremap <localleader>l :nohlsearch<CR>

"}}}

" General editing ----------------------------------------------------------{{{

"--------------------------------------------------------------
" Consider remapping CAPS LOCK key to CTRL
"   Windows:  SharpKeys http://http://sharpkeys.codeplex.com/
"   OSX:  System Preferences > Keyboard > Modifier Keys
"--------------------------------------------------------------

" General mappings ---------------------------------------------------------{{{
" (:help map-special-keys for options)
let mapleader		= "\<bslash>"
let maplocalleader	= "\<space>"
set timeoutlen=750			" ms to wait for map completion

noremap! jk <ESC>
noremap! ;; <ESC>
vnoremap .. <ESC>

"}}}

" Normal mode mappings ---------------------------------------------{{{

" \zz toggles typewriter scrolling on/off
nnoremap <leader>zz :let &scrolloff=999-&scrolloff<CR>

" \t prints timestamp in insert or normal modes (note leader = "\")
inoremap <leader>t <C-r>=GetTimeStamp()<CR>
nnoremap <leader>t i<C-r>=GetTimeStamp()<CR><Esc>

function! GetTimeStamp() 		" see http://strftime.net/
	" -> e.g., "Sunday July 17, 2016 08:48:09 HKT"
	return strftime("%A %B %e, %Y %H:%M:%S %Z")
endfunction

" save/quit shortcuts
nnoremap <C-s> :write<CR>
nnoremap <C-s><C-s> :write all<CR>
nnoremap <C-q><C-q> :quit<CR>

" Source/unload shortcuts
nnoremap <F3> :source %<CR>
nnoremap <S-F3> :bunload<CR>

" Move to new split when it opens
nnoremap <C-w>v <C-w>v<C-w>l
nnoremap <C-w>s <C-w>s<C-w>k

" Jump around splits efficiently
nnoremap <localleader><C-h> <C-w>h<CR>
nnoremap <localleader><C-l> <C-w>l<CR>
nnoremap <localleader><C-j> <C-w>j<CR>
nnoremap <localleader><C-k> <C-w>k<CR>

" Cycle between buffers
nnoremap <C-h> :bp<CR>
nnoremap <C-l> :bn<CR>

" Jump multiple screen lines at one time
nnoremap <C-j> 5gj5<C-e>zz
nnoremap <C-k> 5gk5<C-y>zz

" Visually select word, Word under cursor
nnoremap <localleader>w viw
nnoremap <localleader>W viW

" Quick-select inside, around brackets
nnoremap <localleader>( vi(
nnoremap <localleader>) va)
nnoremap <localleader>{ vi{
nnoremap <localleader>} va}
nnoremap <localleader>[ vi[
nnoremap <localleader>] va]
nnoremap <localleader>< vi<
nnoremap <localleader>> va>

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

"}}}


" Insert and command mode mappings ---------------------------------{{{

" <C-d> delete-forward one character, <C-f> one Word
noremap! <C-d> <Del>
noremap! <C-f> <C-o>dE

"}}}

"}}}

" Plain text autocommands --------------------------------------------------{{{
augroup text_settings
	autocmd!

	" general formatting
	autocmd FileType text,markdown setlocal formatoptions=anq2

	" soft wrapping
	autocmd FileType text,markdown setlocal nonumber
	autocmd FileType text,markdown setlocal wrap linebreak nolist textwidth=10000 wrapmargin=0 showbreak=
	autocmd FileType text,markdown setlocal tabstop=5 shiftwidth=5 nosmartindent noautoindent nobreakindent

	" q, Q autoreformat current paragraph, entire document
	autocmd FileType text,markdown nnoremap <buffer> <localleader>q igqip`^
	autocmd FileType text,markdown nnoremap <buffer> <localleader>Q iggVGgq`^

	" autoreformat current paragraph when starting a new one
	autocmd FileType text,markdown inoremap <buffer> <CR><CR> vipgqvip`>a<CR><CR>

	" g( and g) jump to first (last) character in sentence
	" g{ and g} jump to first (last) character in paragraph
	" (default (,),{,} jump to last character *around* sentence/paragraph
	autocmd FileType text,markdown nnoremap <buffer> g( vis`<
	autocmd FileType text,markdown nnoremap <buffer> g) vis`>
	autocmd FileType text,markdown nnoremap <buffer> g{ vip`<^
	autocmd FileType text,markdown nnoremap <buffer> g} vip`>

	" Quick-select inside, around sentences and paragraphs
	autocmd FileType text,markdown nnoremap <buffer> <localleader>( vis
	autocmd FileType text,markdown nnoremap <buffer> <localleader>) vas
	autocmd FileType text,markdown nnoremap <buffer> <localleader>{ vip
	autocmd FileType text,markdown nnoremap <buffer> <localleader>} vap

	" ␣O and ␣o reformat current paragraph, open a new one two lines above, below
	autocmd FileType text,markdown nnoremap <buffer> <localleader>O vipgqvip`<OO
	autocmd FileType text,markdown nnoremap <buffer> <localleader>o vipgqvip`>oo

	" ␣' and ␣" enquote visual selection
	" U+2018, U+2019 are curly single quotes, U+201C & U+201D double
	autocmd FileType text,markdown xnoremap <buffer> <localleader>' c'+'
	autocmd FileType text,markdown xnoremap <buffer> <localleader>" c"+"
	
	" Visual selection: <C-b> for bold, <C-i> for italics
	autocmd FileType text,markdown xnoremap <buffer> <C-i> c*+*
	autocmd FileType text,markdown xnoremap <buffer> <C-b> c__+__

	" leave cursor at end of selection following yank - allows pppp ...
	autocmd FileType text,markdown noremap y y`]

	autocmd FileType text,markdown noremap G G}
	autocmd FileType text,markdown noremap gg gg0

	" insert &nbsp; (U+00A0)
	autocmd FileType text,markdown inoremap <leader><space> <C-v>u00A0

augroup END
"}}}

" Vim file autocommands -----------------------------------------------------{{{
augroup vim_settings
	autocmd!

	" <F3> quick source current file
	autocmd FileType vim nnoremap <buffer> <F3> :source %<CR>

	" comment out a line
	autocmd FileType vim nnoremap <buffer> <localleader>c I"<Esc>

augroup END
"}}}

" Shell script autocommands -------------------------------------------------{{{
augroup sh
	autocmd!
	autocmd FileType sh setlocal number
augroup END
"}}}

" Make autocommands ---------------------------------------------------------{{{
augroup make_settings
	autocmd!
	autocmd FileType make setlocal number
augroup END
"}}}

" Theme autocommands -----------------------------------------------{{{
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
nmap <silent> <C-S-p> :HLT!<CR>
"nmap <C-S-p> :call <SID>SynStack()<CR>
"}}}

