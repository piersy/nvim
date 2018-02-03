" plugins {{{
call plug#begin()
" Make sure you use single quotes.

" The best color scheme.
Plug 'tomasr/molokai'

" Map multiple simultaneous key presses.
Plug 'houshuang/vim-arpeggio'

" Syntax highlighting for solidity .sol files
Plug 'tomlion/vim-solidity'

" Surround text objects with more text
Plug 'tpope/vim-surround'

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'tag': '3.0', 'do': ':UpdateRemotePlugins' }

" Go sources for deoplete
Plug 'zchee/deoplete-go', { 'do': 'make'}

" Language server
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" golang plugins
Plug 'fatih/vim-go', { 'tag': 'v1.13' }

" Nice parenthesis
Plug 'kien/rainbow_parentheses.vim'

" Add plugins to &runtimepath.
call plug#end()
"}}}

" Arpeggio needs to be loaded as the init.vim is parsed so that
" it can be used for defining key mappings.
call arpeggio#load()


" Sets the molokai colorscheme without this line you get normal colors.
colorscheme molokai

" Work around for broken xfce4-terminal stops garbage characters being printed
" in neovim 0.2.2+
set guicursor=
" generic vim options {{{

" Permanently display line numbers at the side of the screen.
set number

" Don't ask to save when changing buffers (i.e. when jumping to a type definition).
set hidden

" This causes the vim yank/paste to use the X11 copy paste buffer.
set clipboard=unnamedplus

" Set tabs to be represented by 4 spaces, the default is 8.
set tabstop=4

" The shiftwidth controls the indent usded for autoindenting
" setting it to 0 makes it follow the tabstop setting.
set shiftwidth=0

" The cinoptions control indenting for c (and other languages)
" The option below makes indenting for arguments spread across many lines a
" single tab rather than a double tab.
" see :help cino-(
set cinoptions=(1s

" This makes sure that there are x lines of context above/below point
" scrolled to, it helps to keep your eyes more central on the screen.
set scrolloff=8

" show a bit of info regarding selected blocks
set showcmd

" allow folding using '{{{' and '}}}'
set foldmethod=marker
"}}}

" generic vim key mappings {{{
" go to beginning of line.
noremap H 0
" go to end of line not including carriage return.
noremap L g_

" pgup/pgdown move too far to track text easily but ctrl-d and
" ctrl-u are hard to reach and not comfy. I tried mapping this
" with arpeggio, but it turns out that trying to repeatedly press
" two keys together, for example when scrolling down a large
" document is not very comfortable. Best to keep arpeggio mappings
" for operations that are not repeated in quick succession.
nnoremap <PageUp> <C-U>
nnoremap <PageDown> <C-D>

" This overwrites the default mapping of K which opens the man
" page for the word under the cursor
nnoremap K <C-U>
nnoremap J <C-D>
vnoremap K <C-U>
vnoremap J <C-D>

" Open man page for word under cursor '<C-R><C-W>' expands to the word under
" the cursor
nnoremap M :Man <C-R><C-W> <CR>
vnoremap M :Man <C-R><C-W> <CR>

" Navigate command line commands with ctrl+j and ctrl+k
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>

" I dont ever place marks so I use 'm' as the leader.
let mapleader = 'm'

" Allow easy editing of init.vim file.
nnoremap <leader>ve :vsplit $MYVIMRC<CR>
" Allow easy sourcing of init.vim file.
nnoremap <leader>vs :write $MYVIMRC<CR>:source $MYVIMRC<CR>

" netrw buffer key mappings {{{
" Allow easy window opening.

" This needs to be updated for terminal use, Explore expects
" the current file name to be a file, for terminals it is not a file name so
" we need to do something different, I'd suggest opening the explore at the
" same dir that the terminal is in.
nnoremap <leader>e :call MyExplore()<CR>
" if the file is not a terminal then use normal explore
" otherwise explore the cwd.
function! MyExplore()
	let l:fname = expand("%")
	if l:fname =~ "^term:\/\/"
		:execute ":Explore" getcwd()
	else
		:Explore
	endif
endfunction

nnoremap <leader>wh :Hexplore<CR>
nnoremap <leader>wv :Vexplore<CR>

augroup netrw_maps
	autocmd!
	autocmd filetype netrw call ApplyNetrwMaps()
augroup END

function! ApplyNetrwMaps()
	nnoremap <buffer> <leader>c :<C-u>quit<CR>
	" In this case netrw has mapped <CR> to some other command
	" so we need a recursive mapping.
	Arpeggio nmap <buffer> jk <CR>
endfunction
"}}}

" Allow easy zooming of current window.
nnoremap <leader>z :call ZoomToggle()<CR>
let g:zoomed_in = 0
function! ZoomToggle()
	if g:zoomed_in
		let g:zoomed_in = 0
		:execute ":normal! \<C-w>="
	else
		let g:zoomed_in = 1
		:execute ":normal! \<C-w>|\<C-w>_"
	endif
endfunction

nnoremap <leader>s :<C-u>write<CR>
nnoremap <leader>c :<C-u>quit<CR>
nnoremap <leader>C :<C-u>quit!<CR>

" Arpeggio standard vim key mappings.
Arpeggio nnoremap fk :wincmd k <CR>
Arpeggio nnoremap fj :wincmd j <CR>
Arpeggio nnoremap fh :wincmd h <CR>
Arpeggio nnoremap fl :wincmd l <CR>

" Map df to esc - no brainer.
Arpeggio inoremap df <esc>
" Map df to the equivalent of escape for commandline.
Arpeggio cnoremap df <C-c>
" Make esc in normal mode clear highlighting.
Arpeggio noremap <silent> df :<C-u>nohlsearch<CR><esc>

" Map fn to equivalient of escape in terminal mode. We can't map df here
" otherwise when we have vim inside a terminal in vim and we escape the df
" would escape the terminal rather than be passed to the vim inside the
" terminal. We also add a search back to first line starting with a dollar
" then remove search highlighting. This stops the cursor appearing at the
" bottom when we escape.
Arpeggio tnoremap fn <C-\><C-n>G?^\$<CR>:<C-u>nohlsearch<CR>

" Remove the original esc key functionality.
inoremap <esc> <NOP>
cnoremap <esc> <NOP>
noremap <esc> <NOP>

" Map jk to <CR> for insert and commandline mode.
Arpeggio inoremap jk <CR>
Arpeggio cnoremap jk <CR>
Arpeggio nnoremap jk <CR>

" As with esc we have to map fj instead of jk so that when using vim inside a
" terminal in vim we do not trigger the <CR>  of the terminal.
Arpeggio tnoremap fj <CR>

" Remove the original <CR> key functionality.
inoremap <CR> <NOP>

Arpeggio tnoremap <C-j> <down>
Arpeggio tnoremap <C-k> <up>

" Toggle spell
nnoremap <leader>x  :<C-u>setlocal spell! <CR>

" help buffer key mappings {{{
" help mappings have to be set here otherwise they are overwritten with more
" buffer specific maps
augroup help_maps
	autocmd!
	autocmd filetype help call ConfigureHelp()
augroup END

function! ConfigureHelp()
	" make the jump to def (d for def) shortcut easier.
	nnoremap <buffer> <leader>d <C-]>

	" make the return to start (r for return) shortcut easier.
	nnoremap <buffer> <leader>r <C-t>
endfunction
"}}}


" end genric key mappings }}}

" generic utility functions {{{

" Strips trailing whitespace and makes sure the cursor returns to it's initial
" position.
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
"}}}

" yaml file type config {{{
augroup yaml_config
	autocmd!
	autocmd filetype yml,yaml call ConfigureYaml()
augroup END

function! ConfigureYaml()
	" Set tabs to be represented by 2 spaces;
	setlocal tabstop=2

	" The shiftwidth controls the indent usded for autoindenting
	" setting it to 0 makes it follow the tabstop setting.
	setlocal shiftwidth=0
	
	" Ensures that tabs are expanded to spaces when inserted
	setlocal expandtab
endfunction
"}}}

" android_manifest file type config {{{
augroup android_manifest_config
	autocmd!
	autocmd BufRead AndroidManifest.xml call ConfigureAndroidManifest()
augroup END

function! ConfigureAndroidManifest()
	" Set tabs to be represented by 2 spaces;
	setlocal tabstop=4

	" The shiftwidth controls the indent usded for autoindenting
	" setting it to 0 makes it follow the tabstop setting.
	setlocal shiftwidth=0
	
	" Ensures that tabs are expanded to spaces when inserted
	setlocal expandtab
endfunction
"}}}

" deoplete config {{{

" enable deoplete
let g:deoplete#enable_at_startup = 1

" This stops deoplete from selecting the first option in the list
" automatically.
set completeopt+=noinsert,menuone

" Disable auto popup menu
let g:deoplete#disable_auto_complete = 1

" Set ctrl+space to show completion menu.
inoremap <expr><C-Space> deoplete#mappings#manual_complete()

" Allow selecting autocomplete options with c-j and c-k.
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

"}}}

" deoplete go config {{{

" Set path to gocode binary, this is recommended for performance reasons
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
"}}}

" vim go config {{{

" Dont use the location list
let g:go_list_type = "quickfix"

augroup vimgo_maps
	autocmd!
	autocmd filetype go call ApplyVimGoMaps()
augroup END

function! ApplyVimGoMaps()
	" Automatic write on build
	setlocal autowrite

	" The exclamation mark stops the command jumping to the
	" first error.
	nnoremap <buffer> <leader>b :<C-u>GoBuild!<CR>

	" Easy doc
	nnoremap <buffer> <leader>q :<C-u>GoDoc<CR>

	" Easy referrers
	nnoremap <buffer> <leader>u :<C-u>GoReferrers<CR>

	"Use go imports on save
	let g:go_fmt_command = "goimports"

	" make the jump to def (d for def) shortcut easier.
	nnoremap <buffer> <leader>d :<C-u>GoDef<CR>

	" make the return to start (r for return) shortcut easier.
	nnoremap <buffer> <leader>r :<C-u>GoDefPop<CR>

	" Map K again in buffer specific mode since it is mapped by go
	" to get the doc.
	nnoremap <buffer> K <C-U>

	" Cycle through errors in the quickfix
	nnoremap <C-n> :cnext<CR>
	nnoremap <C-m> :cprevious<CR>
	
	" goto file in vertical split
	nnoremap <buffer> <leader>v :<C-u>vsplit<CR>:exec("GoDef ".expand("<cword>"))<CR>
	" goto file in horizontal split
	nnoremap <buffer> <leader>h :<C-u>split<CR>:exec("GoDef ".expand("<cword>"))<CR>

endfunction "}}}

"rainbow parenthesis config {{{
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"au Syntax * RainbowParenthesesLoadChevrons
" }}}

