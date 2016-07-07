"==============================================================================
"  .vimrc
"  Last rev 2016-07-06
"==============================================================================


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" gui settings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if has('gui_running')

	" All excellent free or open console fonts
	"set guifont=Consolas:h11:cANSI
	"set guifont=Cousine:h11:cANSI
	"set guifont=Fantasque_Sans_Mono:h11:cANSI
	"set guifont=Hack:h11:cANSI
	"set guifont=Inconsolata:h12:cANSI
	"set guifont=InputMono:h11:cANSI
	"set guifont=Menlo:h11:cANSI
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
		set columns=180
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
set modelines=0					" plug security hole (per Steve Losh)
set hidden						" hide buffer when abandoned
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
set ignorecase					" generally ignore case when searching
set incsearch					" highlight next search term instance
set hlsearch					" underline all instances of last search
set smartcase					" ... except when capitals typed
set wrapscan					" searches wrap around end of buffer
set gdefault					" apply substitutions globally by default

" 'very magic' mode - enable more POSIX-like regex parsing (not portable)
" normal, visual and operator-pending modes only - / is used a lot in command mode
noremap / /\v
noremap ? ?\v


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

" scrolling and cursor movement
set scrolloff=3					" minimum context at top/bottom of screen
set nostartofline				" keep cursor in same col after jumps

" textwidth, indentation, line breaks
set textwidth=0					" prevent wrapping
set tabstop=4					" # of spaces <Tab> counts for
set softtabstop=4				" # of spaces <Tab> appears to count for
set noexpandtab					" do not expand <Tab> to spaces
set shiftwidth=4				" # of spaces to use for each (auto)indent
set linebreak					" wrap lines at 'breakat' chars
set breakat=\ \	!@*-+;:,./?		" break line after <SP> <TAB> etc.
set showbreak+=\\				" preceed continued lines with \
set breakindent


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" global mappings (:help map-special-keys for options)
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let mapleader = "\\"			" single backslash
let maplocalleader = ","		" comma


"""" NORMAL MODE ONLY """"

" \zz toggles typewriter scrolling on/off
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" <M-j> and <M-k>: move down (up) one screen (cf. logical) line
nnoremap <M-j> gj
nnoremap <M-k> gk

" <C-Right> and <C-Left>: cycle forward (back) through open buffers
nnoremap <C-Right> :bn<CR>
nnoremap <C-Left> :bp<CR>

" <C-Down> and <C-Up>: cycle down (up) through open windows
nnoremap <C-Down> j 
nnoremap <C-Up> k


"""" INSERT MODE ONLY """"

" jk exit insert mode (as do <Esc>, <C-[>, and <C-c>). Thanks Steve Losh!
inoremap jk <Esc>

" <C-d> delete-forward one character, <C-f> one Word
inoremap <C-d> <Del>
inoremap <C-f> <C-o>dE


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" global mappings (:help map-special-keys for options)
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let mapleader = "\\"			" single backslash
let maplocalleader = ","		" comma


"~~~~~~~~~~~~
" Consider remapping CAPS LOCK key to CTRL
"   Windows:  SharpKeys (http://http://sharpkeys.codeplex.com/
"   OSX:  System Preferences > Keyboard > Modifier Keys
"~~~~~~~~~~~~


"""" NORMAL MODE MAPPINGS """"

" \zz toggles typewriter scrolling on/off
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" <C-Right> and <C-Left>: cycle forward (back) through open buffers
" Shadowed by system command on OSX
nnoremap <C-Right> :bn<CR>
nnoremap <C-Left> :bp<CR>

" Open new vertical split with ,sp - focus shifts to new window
nnoremap <localleader>sp <C-w>v<C-w>l

" Quicker movements around splits using hjkl keys
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


"""" NORMAL/VISUAL/SELECT MODE ONLY MAPPINGS """"

" jk^$ operate on screen lines, not logical lines, unless prefixed with g
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap ^ g^
noremap $ g$
noremap g^ ^
noremap g$ $


"""" INSERT/COMMAND MODE ONLY MAPPINGS """"

" ;; exit insert mode (as do <Esc>, <C-[>, and <C-c>)
noremap! ;; <Esc>

" <C-d> delete-forward one character, <C-f> one Word
noremap! <C-d> <Del>
noremap! <C-f> <C-o>dE


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" plain text editing
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
augroup text_settings
	autocmd!

	" general formatting
	autocmd FileType text,markdown setl textwidth=64 shiftwidth=5 formatoptions=tamB1

	" g( and g) jump to first (last) character in sentence
	" g{ and g} jump to first (last) character in paragraph
	autocmd FileType text,markdown nnoremap <buffer> g( vis`<
	autocmd FileType text,markdown nnoremap <buffer> g) vis`>
	autocmd FileType text,markdown nnoremap <buffer> g{ vip`<^
	autocmd FileType text,markdown nnoremap <buffer> g} vip`>

	" ,w, ,s and ,p select current word, sentence, paragraph
	autocmd FileType text,markdown nnoremap <buffer> <localleader>w viw
	autocmd FileType text,markdown nnoremap <buffer> <localleader>s vis
	autocmd FileType text,markdown nnoremap <buffer> <localleader>p vip

	" ' and " enclose visual selection in respective quotes
	autocmd FileType text,markdown vnoremap <buffer> ' c'+'
	autocmd FileType text,markdown vnoremap <buffer> " c"+"
	
	" <C-b> for bold, <C-i> for italics
	autocmd FileType text,markdown vnoremap <buffer> <C-i> c*+*
	autocmd FileType text,markdown vnoremap <buffer> <C-b> c__+__

	" ,O and ,o open new paragraph two lines above, below current one
	autocmd FileType text,markdown nnoremap <buffer> <localleader>O vip`<OO
	autocmd FileType text,markdown nnoremap <buffer> <localleader>o vip`>oo
augroup END


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" vimfile editing
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
augroup vim_settings
	autocmd!
	autocmd FileType vim setl formatoptions=croq
	" ,c comment out a line
	autocmd FileType vim nnoremap <buffer> <localleader>c I"<Esc>
augroup END

