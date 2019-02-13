" plugins {{{
call plug#begin()
" Make sure you use single quotes.

" The best color scheme.
Plug 'tomasr/molokai'

" Map multiple simultaneous key presses.
Plug 'houshuang/vim-arpeggio'

" Nice statusbar + open buffers displayed at top.
Plug 'vim-airline/vim-airline'
" vim-fugitive adds current branch display to vim-airline
Plug 'tpope/vim-fugitive'
" gitv adds gitk style git log browsing to vim it is a fugitive extension
Plug 'gregsexton/gitv', {'on': ['Gitv']}

" Syntax highlighting for solidity .sol files
Plug 'tomlion/vim-solidity'

" Surround text objects with more text
Plug 'tpope/vim-surround'

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'tag': '3.0', 'do': ':UpdateRemotePlugins' }

" Snippet support
Plug 'SirVer/ultisnips'

" Go sources for deoplete
Plug 'zchee/deoplete-go', { 'do': 'make'}

" Language server
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" golang plugins
Plug 'fatih/vim-go', { 'tag': 'v1.16' }

" refactoring support for go files
Plug 'godoctor/godoctor.vim'

" Nice parenthesis
Plug 'kien/rainbow_parentheses.vim'

"Plug 'Shougo/denite.nvim', { 'tag': 'support-python-3.4' }

" Vim overlooks the need to close a buffer without closing a window, this
" plugin provides that functionality. I want this specifically so that if I
" have a window open with a buffer and the quickfix open as well, when I close
" the main buffer I do not want a fullscreen quickfix.
Plug 'moll/vim-bbye'

" fzf plugin from the fzf repo at that location
Plug '/home/piers/programs/fzf'
" the fzf vim plugin which depends on the fzf plugin
Plug 'junegunn/fzf.vim'

" Add plugins to &runtimepath.
call plug#end()
"}}}
"let g:python3_host_prog="/usr/local/bin/python3.5"
"let g:python3_host_prog = "/usr/local/bin/python3.5"
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

" vim will automatially detect changes to files on disk and load them, if you
" have made changes in vim as well then vim will ask before loading the
" changes.
set autoread

" Auto open quickfix window after running grep
autocmd QuickFixCmdPost *grep* cwindow

" Position quickfix window at bottom of screen and take whole width. qf is the
" quickfix filetype
au FileType qf wincmd J
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

" Space key does nothing in insert, it is also easily reachable from both
" hands.
let mapleader = ' '
" Remove the normal space function in normal mode
noremap <Space> <NOP>

" Allow easy editing of init.vim file.
nnoremap <leader>ve :vsplit $MYVIMRC<CR>
" Allow easy sourcing of init.vim file.
nnoremap <leader>vs :write $MYVIMRC<CR>:source $MYVIMRC<CR>


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

" Command to save as sudo
command WRITE execute "w !sudo tee %"

nnoremap <leader>s :<C-u>write<CR>
nnoremap <leader>S :<C-u>WRITE<CR>

" Deletes the current buffer or quits if this is the last buffer.
function! CloseBufferOrQuit()

	" This config lead to buffers with no name being ignored, so starting vim
	" without any arguments and then pressing <leader>c resulted in no effect
	"let currentbuffers = filter(range(1, bufnr('$')), '! empty(bufname(v:val)) && buflisted(v:val)')
	
	" This config at least solves the above issue
	let currentbuffers = filter(range(1, bufnr('$')), 'buflisted(v:val)')
	" Im not really sure what type of buffer would have an empty bufname
	" let currentbuffers = filter(range(1, bufnr('$')), '! empty(bufname(v:val))')
	
	" echom join(currentbuffers, ":")
	
	" If there is only one visible buffer left and it is current  then quit.
	" The check to see if the buffer is current prevents us quitting when
	" closing help with one other buffer open, since help is not listed for
	" some reason.
	if len(currentbuffers) <= 1 && index(currentbuffers, bufnr('%')) >= 0
		"echom "quitting"
		quitall
	else
		"Otherwise delete that buffer.
		"echom "deleting buffer"
		if &buftype ==# ""
			"If this is a normal window dont delete the associated window 
			Bdelete
		else 
			" else delete the buffer and window (for example this would apply
			" to the quickfix window)
			bdelete
		endif
	endif
endfunction

nnoremap <leader>c :<C-u>call CloseBufferOrQuit()<CR>
nnoremap <leader>Q :<C-u>quitall!<CR>

nnoremap <leader>w :<C-u>vsplit<CR>
nnoremap <leader>k :<C-u>close<CR>
nnoremap <leader>i gqk
vnoremap <leader>i gq



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
" Map df to the equivalent of escape for terminal.
Arpeggio tnoremap <silent> df :<C-u>nohlsearch<CR><esc>

" Map fn to equivalient of escape in terminal mode. We can't map df here
" otherwise when we have vim inside a terminal in vim and we escape the df
" would escape the terminal rather than be passed to the vim inside the
" terminal. We also add a search back to first line starting with a dollar
" then remove search highlighting. This stops the cursor appearing at the
" bottom when we escape.
"Arpeggio tnoremap fn <C-\><C-n>G?^\$<CR>:<C-u>nohlsearch<CR>

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
"Arpeggio tnoremap fj <CR>

" Remove the original <CR> key functionality. But not in insert mode since I
" want to use it for UltiSnips. And not in command mode, since it is useful
" for entering commands after using the direction keys.
nnoremap <CR> <NOP>
vnoremap <CR> <NOP>

Arpeggio tnoremap <C-j> <down>
Arpeggio tnoremap <C-k> <up>

" Toggle spell
nnoremap <leader>x  :<C-u>setlocal spell! <CR>

" set quickfix and previewwindow to be unlisted so that bn and bp do not
" navigate to it and so that when I exit these windows do not stop vim from
" closing. 
augroup unlisted_buffers
	autocmd!
	" So we have to use 2 completely different ways of setting options for
	" these windows, don't ask me why but that is just the way that vim does
	" it.
	autocmd FileType qf set nobuflisted
	autocmd WinEnter * if &previewwindow | set nobuflisted | endif
augroup END

" Easy buffer switching, useful with airline tab bar, since you can see where
" you are switching to.
nnoremap <C-u> :<C-u>bp<CR>
nnoremap <C-p> :<C-u>bn<CR>

function QFixToggle()
	let qf = filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "qf"')
	if len(qf) > 0
		cclose
	else
		let curr_win = winnr()
		copen
		:execute curr_win . "wincmd w"
	endif
endfunction

" Easy quickfix closing
nnoremap <leader><Space> :<C-u>call QFixToggle()<CR>

" Remap b for split keyboard
nnoremap m b
nnoremap M B
vnoremap m b
vnoremap M B

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
"set completeopt+=noinsert,menuone

" Disable auto popup menu
"let g:deoplete#disable_auto_complete = 1

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

" airline config {{{

" Enable the tabline
let g:airline#extensions#tabline#enabled = 1

" Set airline to sow a tabline with oipen buffers in a single tab
let g:airline#extensions#tabline#show_buffers = 1

" Set use nice fonts for airline
let g:airline_powerline_fonts = 1

" need to set dict before setting any symbols
let g:airline_symbols = {}
" simply set this symbol to nothing since it was displaying strangely
let g:airline_symbols.maxlinenr = ''

" format the filenames in the tabbar to be filename only, the full path is
" show in the statusline at the bottom.
let g:airline#extensions#tabline#fnamemod = ':t'

"}}}

" UtilSnip config {{{
let g:UltiSnipsExpandTrigger="<CR>"
let g:UltiSnipsJumpForwardTrigger="<CR>"
let g:UltiSnipsJumpBackwardTrigger="<C-H>"
"}}}

" LanguageClient config {{{
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['node', '/home/piers/programs/javascript-typescript-langserver/lib/language-server-stdio'],
    \ 'cpp': ['/home/piers/projects/cquery/build/release/bin/cquery', '--log-file=/tmp/cq.log', '--init={"cacheDirectory":"/home/piers/.config/nvim/cquery_cache"}'],
    \ 'c': ['/home/piers/projects/cquery/build/release/bin/cquery', '--log-file=/tmp/cq.log', '--init={"cacheDirectory":"/home/piers/.config/nvim/cquery_cache"}'],
    \ }

" Unfortunately this seems to conflict with deoplete and causes the completion
" menu to update while cycling through completions.
"    \ 'go': ['go-langserver'],
	

augroup language_client_maps
	autocmd!
	autocmd filetype c,cpp,javascript call ApplyLanguageClientMaps()
augroup END

function! ApplyLanguageClientMaps()
	nnoremap <silent> <buffer> <leader>d :<C-u>call LanguageClient#textDocument_definition()<CR>
	nnoremap <silent> <buffer> <leader>h :<C-u>call LanguageClient#textDocument_hover()<CR>
	nnoremap <silent> <buffer> <leader>u :<C-u>call LanguageClient#textDocument_references()<CR>
	nnoremap <silent> <buffer> <leader>; :<C-u>call LanguageClient#textDocument_documentSymbol()<CR>
	nnoremap <silent> <buffer> <leader>r :<C-u>call LanguageClient_textDocument_rename()<CR>
endfunction
"}}}

" vim-go config {{{

" Dont use the location list
let g:go_list_type = "quickfix"

"Use go imports on save
let g:go_fmt_command = "goimports"

" Exclude protobuf generated files from metalinter.
let g:go_metalinter_excludes = [".*\.pb\.go"]

" Use local godoc server
let g:go_doc_url = 'http://localhost:6060'

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
	let l:file = expand('%')
	if l:file =~# '^\f\+_test\.go$'
		" The first parameter controls whether we jump to the first error or
		" not, 0 jumps. The second controls whether we run or just compile, 1
		" compiles.
		call go#test#Test(1, 1)
	elseif l:file =~# '^\f\+\.go$'
		" The first parameter controls whether we jump to the first error or
		" not, 0 jumps.
		call go#cmd#Build(1)
	endif
endfunction

augroup vimgo_maps
	autocmd!
	autocmd filetype go call ApplyVimGoMaps()
augroup END

function! ApplyVimGoMaps()
	" Automatic write on build
	setlocal autowrite

	" Build both test and non test files with one command
	nnoremap <buffer> <leader>b :<C-u>call <SID>build_go_files()<CR>

	nnoremap <buffer> <leader>t :<C-u>GoTest<CR>

	" Easy doc
	nnoremap <buffer> <leader>q :<C-u>GoDoc<CR>

	" Easy referrers
	nnoremap <buffer> <leader>u :<C-u>GoReferrers<CR>

	" make the jump to def (d for def) shortcut easier.
	nnoremap <buffer> <leader>d :<C-u>GoDef<CR>

	" make the return to start (r for return) shortcut easier.
	nnoremap <buffer> <leader>r :<C-u>GoDefPop<CR>

	" make the go alternate shortcut easier.
	nnoremap <buffer> <leader>a :<C-u>GoAlternate<CR>

	" Map K again in buffer specific mode since it is mapped by go
	" to get the doc.
	nnoremap <buffer> K <C-U>

	" Cycle through errors in the quickfix
	nnoremap <buffer> <C-j> :<C-u>cnext<CR>
	nnoremap <buffer> <C-k> :<C-u>cprevious<CR>

	inoremap <buffer> kl <ESC> :<C-u>call <SID>build_go_files()<CR>
	
endfunction "}}}

"rainbow parenthesis config {{{
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
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
" removed colors
"
"\ ['Darkblue',    'SeaGreen3'],

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"au Syntax * RainbowParenthesesLoadChevrons
" }}}

"denite config {{{
"call denite#custom#map(
"			\ 'insert',
"			\ '<C-j>',
"			\ '<denite:move_to_next_line>',
"			\ 'noremap'
"			\)
"call denite#custom#map(
"			\ 'insert',
"			\ '<C-k>',
"			\ '<denite:move_to_previous_line>',
"			\ 'noremap'
"			\)
"nnoremap <leader>g :<C-u>Denite grep<CR>
"" }}}

"fzf config {{{

nnoremap <leader>o :<C-u>:Files<CR>

" FZF with ripgrep FTW!!!
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
"command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

command! -bang -nargs=* Find
 \ call fzf#vim#grep(
 \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
set grepprg=rg\ --vimgrep

nnoremap <leader>f :<C-u>:Find<CR>


" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

"}}}
