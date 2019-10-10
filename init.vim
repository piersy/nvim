" plugins {{{
call plug#begin()
" Make sure you use single quotes.

" The best color scheme.
Plug 'tomasr/molokai'

" Map multiple simultaneous key presses.
Plug 'piersy/vim-arpeggio'

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
Plug 'Shougo/deoplete.nvim', { 'tag': '5.0', 'do': ':UpdateRemotePlugins' }
Plug 'nixprime/cpsm', { 'do': 'bash install.sh' }

Plug 'guns/xterm-color-table.vim'

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" Add automatic parentheses to completion (only works with deoplete)
"Plug 'Shougo/neopairs.vim'

" Snippet support
"Plug 'SirVer/ultisnips'

" Go sources for deoplete
Plug 'zchee/deoplete-go', { 'do': 'make'}

" Language server
Plug 'autozimu/LanguageClient-neovim', {
			\ 'branch': 'next',
			\ 'do': 'bash install.sh',
			\ }

" golang plugins
"Plug 'fatih/vim-go', { 'tag': 'v1.19' }
Plug 'fatih/vim-go'

" refactoring support for go files
Plug 'godoctor/godoctor.vim' "doesn't play well with 2 gopaths

" Nice parentheses
Plug 'kien/rainbow_parentheses.vim'

"Plug 'Shougo/denite.nvim', { 'tag': 'support-python-3.4' }

" Vim overlooks the need to close a buffer without closing a window, this
" plugin provides that functionality. I want this specifically so that if I
" have a window open with a buffer and the quickfix open as well, when I close
" the main buffer I do not want a fullscreen quickfix.
Plug 'moll/vim-bbye'

" fzf plugin from the fzf repo at that location
Plug '/home/piers/projects/fzf'
" the fzf vim plugin which depends on the fzf plugin
Plug 'junegunn/fzf.vim'

" fixes the ':w !sudo tee %' problem in neovim with ':w suda://%'
Plug 'lambdalisue/suda.vim'

Plug 'tpope/vim-commentary'

" Syntax highliting for sane files
Plug 'bloom42/sane-vim'

" Syntax highliting for typescript
Plug 'leafgarland/typescript-vim'

" Preview markdown files in browser
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" See all your edits in a tree :UndotreeToggle
Plug 'mbbill/undotree'

" diff blocks of text with :Linediff on selected blocks
Plug 'AndrewRadev/linediff.vim'

" Wrap arguments on functions with :ArgWrap
Plug 'FooSoft/vim-argwrap'

" Add plugins to &runtimepath.
call plug#end()
"}}}
if isdirectory($HOME . "/.config/nvim/plugged")

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
set errorbells

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

" history options {{{

" Protect changes between writes. Default values of
" updatecount (200 keystrokes) and updatetime
" (4 seconds) are fine
set swapfile

" protect against crash-during-write
set writebackup
" but do not persist backup after successful write
set nobackup
" use rename-and-write-new method whenever safe
set backupcopy=auto
" persist the undo tree for each file
set undofile

"}}}

" Auto open quickfix window after running grep
autocmd! QuickFixCmdPost *grep* cwindow

" Position quickfix window at bottom of screen and take whole width. qf is the
" quickfix filetype
au FileType qf wincmd J
"}}}

" generic vim key mappings {{{

" go to beginning of line.
noremap H ^
" go to end of line not including carriage return.
noremap L g_

" pgup/pgdown move too far to track text easily but ctrl-d and ctrl-u are hard
" to reach and not comfy. I tried mapping this with arpeggio, but it turns out
" that trying to repeatedly press two keys together, for example when
" scrolling down a large document is not very uncomfortable. Best to keep
" arpeggio mappings for operations that are not repeated in quick succession.
nnoremap <PageUp> <C-U>
nnoremap <PageDown> <C-D>

" This overwrites the default mapping of K which opens the man page for the
" word under the cursor and the default mapping of <C-h> in visual mode which
" is the same as backspace.
nnoremap K <C-U>
nnoremap J <C-D>
vnoremap K <C-U>
vnoremap J <C-D>

" Move a few lines J and K scroll half a screen each this is for finer
" movements.

nnoremap <C-j> 5j
nnoremap <C-k> 5k
vnoremap <C-j> 5j
vnoremap <C-k> 5k
onoremap <C-j> 5j
onoremap <C-k> 5k

" Open man page for word under cursor '<C-R><C-W>' expands to the word under
" the cursor
nnoremap M :Man <C-R><C-W> <CR>
vnoremap M :Man <C-R><C-W> <CR>

" Navigate command line commands with ctrl+j and ctrl+k
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>

" Space key does nothing in insert, it is also easily reachable from both
" hands.
let mapleader = "\<Space>"
" Remove the normal space function in normal mode
nnoremap <Space> <NOP>

" Allow easy editing of init.vim file.
nnoremap <leader>ve :e $MYVIMRC<CR>
" source the vimrc on save, we also need to call AirlineRefresh otherwise the
" airline display borks
autocmd! BufWritePost $MYVIMRC source $MYVIMRC | AirlineRefresh

" Unfortunately the keycodes for tab and ctrl+i are the same, so this
" overrides default ctrl+i functionality.
"nnoremap <Tab> :<C-u>%s/

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
command! WRITE execute "w !sudo tee %"

nnoremap <leader>s :<C-u>write<CR>
nnoremap <leader>S :<C-u>WRITE<CR>

vnoremap <leader>d :Linediff<CR>

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
nnoremap <leader>q :<C-u>quitall<CR>
nnoremap <leader><ESC> :<C-u>quitall!<CR>

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

" If I could map DF to <esc> followed by disabling caps then I would, but vim
" cannot detect caps lock! So it is safer to not have this mapping and just
" mess up in insert mode a bit.
" Arpeggio inoremap DF <esc>

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

" This rings the bell, unfortunately we cannot execute it with silent because
" that prevents the bell char from reaching the terminal, so instead we use
" another <CR> to close the output window and return to where we were. Now I
" need to find a way to attach this to keys I shouldn't use too much.
Arpeggio nnoremap po :<C-u>!echo -ne '\007'<CR><CR>

" Map jk to <CR> for insert and commandline mode. And also make it insert
" entries from autocomplete. This gets annoying if you have your min pattern
" length set to one and you want to just insert a newline.
"Arpeggio inoremap <expr>jk pumvisible() ? "\<C-n>" : "<CR>"
Arpeggio inoremap jk <CR>
Arpeggio cnoremap jk <CR>
Arpeggio nnoremap jk <CR>
"
" As with esc we have to map fj instead of jk so that when using vim inside a
" terminal in vim we do not trigger the <CR>  of the terminal.
Arpeggio tnoremap fj <CR>

" Remove the original <CR> key functionality. But not in insert mode since I
" want to use it for UltiSnips. And not in command mode, since it is useful
" for entering commands after using the direction keys.
nnoremap <CR> <NOP>
vnoremap <CR> <NOP>

tnoremap <C-j> <down>
tnoremap <C-k> <up>

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

function! QFixToggle()
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

" This sets up commands to loop through the quickfix list. Normal
" behaviour will only acknowledge cnext or cprev if there is more than one
" quickfix entry.
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry

" Cycle through entries in the quickfix
nnoremap <C-l> :<C-u>Cnext<CR>
nnoremap <C-h> :<C-u>Cprev<CR>

" Remap b for split keyboard
nnoremap m b
nnoremap M B
vnoremap m b
vnoremap M B

" Repeat last command made easy, \ is the only unused key on the keyboard in
" normal mode with the default bindings see ':help index' for a full list of
" keys and their default bindings.
nnoremap \ @:

" ctrl backspace to delete a word in insert mode.
" I had to use crtl+v in insert mode to find the keycode for ctrl+backspace.
inoremap  <C-W>

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
function! StripTrailingWhitespaces()
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

" ignore the around source which adds random complete words from around the
" cursor into the complete options, this is for a later version
call deoplete#custom#option({
			\ 'ignore_sources': { 'go': ['around', 'buffer'] },
			\ 'refresh_always': v:false,
			\ 'camel_case'    : v:true,
			\ 'smart_case'    : v:false,
			\ 'min_pattern_length' : 1,
			\})
call deoplete#custom#source('_',  'max_menu_width', 0)
call deoplete#custom#source('_',  'max_abbr_width', 0)
call deoplete#custom#source('_',  'max_kind_width', 0)

"\ 'smart_case'    : v:true, // when you want to search for ccccCCCC smart
"case becomes annoying where camel case shouldn't

" skip_chars stop completion when entered except if the skip char adds to a
" word that makes it a perfect match eg skip char n and the completion is sign
" and you are at sig and you type sign. Otherwise completion stops with a
" skipChar the defualt value is brackets

" converter_remove_overlap will truncate the inserted candidate in the case
" that the the text following the cursor position
"
" When inserting a candidate if the text following the cursor position matches
" the tail of the candidate the candidate will be truncated to remove that
" tail, such that you end up with just the required candidate rather than
" duplicating the tail.

"call deoplete#custom#source('_', 'converters',
"		\ ['converter_auto_paren','remove_overlap'])

"call deoplete#custom#source('_', 'converters',
"		\ ['converter_auto_delimiter', 'remove_overlap'])

"call deoplete#custom#source('_', 'converters',
"\ ['converter_auto_delimiter'])



"	call deoplete#custom#filter('attrs_order', {
"	\ 'javascript': {
"	\    		'kind': [
"	\			'Function',
"	\			'Property'
"	\			]
"	\ },
"	\})

"call deoplete#custom#option('sources', {
"\ '_': ['file'],
"\ 'min_pattern_length' : 1,
"\})



"call deoplete#custom#option('candidate_marks',
"      \ ['A'])
"inoremap <expr>A       deoplete#insert_candidate(0)

" Auto insert parentheses
"let g:neopairs#enable = 1
"call deoplete#custom#source('_', 'converters', ['converter_auto_paren', 'converter_remove_overlap'])

" This seems to be the best of the bunch, changed my mind on this, it doesn't
" give good suggestions.
"call deoplete#custom#source('_', 'matchers', ['matcher_cpsm'])
"call deoplete#custom#source('_', 'sorters', [])

" Set ctrl+space to show completion menu.
"inoremap <expr><C-Space> deoplete#mappings#manual_complete()

" This auto expands snippets when the completion menu closes.
let g:neosnippet#enable_complete_done = 1

" This sets neosnippet to complete functions in completion menu. Unfortunately
" it breaks down when used with functions that return functions in go, which
" is very annoying.
"let g:neosnippet#enable_completed_snippet = 1

" Allow selecting autocomplete options/snippet segments with c-j Plugin
" key-mappings.
" Note: You must use "imap" and "smap" for the Plug commands.

" navigate the menu with cj and ck
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

"Causes the first entry to be selected by default in the popup menu.
"set completeopt+=noinsert
"Unfortunately the above this does not play well with deoplete
"deoplete-go and airline-vim, the three plugins together plus this cause
"problems.
"
"For now I will mimic noinsert with the below
" 1. when pumvisible & entry selected, which is a snippet, <CR> triggers snippet expansion,
" 2. when pumvisible & entry selected, which is not a snippet, <CR> only closes pum
" 3. when pumvisible & no entry selected, <CR> closes pum and inserts newline
" 4. when pum not visible, <CR> inserts only a newline
"function! s:ExpandSnippetOrClosePumOrReturnNewline()
"    if pumvisible()
"        if !empty(v:completed_item)
"            let snippet = UltiSnips#ExpandSnippet()
"            if g:ulti_expand_res > 0
"                return snippet
"            else
"                return "\<C-y>"
"            endif
"        else
"            return "\<C-y>\<CR>"
"        endif
"    else
"        return "\<CR>"
"    endif
"endfunction

" map enter to select insert the first entry if none selected or the selected
" entry otherwise and esc.
inoremap <expr><CR> pumvisible() && empty(v:completed_item)? "\<c-n>\<c-y>\<ESC>" : "\<c-y>\<ESC>"
" I thought this binding would be useful but actually its a bit of a pain to
" use c-j to skipp snippet sections, tab is much easier and requires one hand.
"imap <expr><C-j> pumvisible() ? "\<C-n>" : "\<Plug>(neosnippet_jump)"

" This binds TAB to jump to the next snippet jump point if there is one or
" otherwise if ther is a menu visible insert the first entry if none selected
" or the selected entry otherwise, and otherwise insert a tab.
imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : pumvisible() ? empty(v:completed_item)? "\<c-n>\<c-y>" : "\<c-y>" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : pumvisible() ? empty(v:completed_item)? "\<c-n>\<c-y>" : "\<c-y>" : "\<TAB>"

" this prevents the weird markers being displayed
if has('conceal')
	set conceallevel=2 concealcursor=niv
endif


" Let dot trigger completion - causes problems when you actually just want to
" enter a dot.
"inoremap <expr>. pumvisible() && empty(v:completed_item) ? "\<C-n>." : "."

" Let comma trigger completion, this is causing a lot of problems when
" inputting parameters. So disabled
" inoremap <expr>, pumvisible() && empty(v:completed_item) ? "\<C-n>," : ","

"}}}

" airline config {{{

" Enable the tabline
let g:airline#extensions#tabline#enabled = 1

" Set airline to sow a tabline with oipen buffers in a single tab
let g:airline#extensions#tabline#show_buffers = 1

" Set use nice fonts for airline
let g:airline_powerline_fonts = 1

" need to set dict before setting any symbols, also need to avoid overwriting
" the dictionary if we are reloading our vimrc
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" simply set this symbol to nothing since it was displaying strangely
let g:airline_symbols.maxlinenr = ''

" format the filenames in the tabbar to be filename only, the full path is
" shown in the statusline at the bottom.
let g:airline#extensions#tabline#fnamemod = ':t'

"}}}

" UtilSnip config {{{
let g:UltiSnipsExpandTrigger="<CR>"
let g:UltiSnipsJumpForwardTrigger="<CR>"
let g:UltiSnipsJumpBackwardTrigger="<C-H>"
"}}}

" LanguageClient config {{{
let g:LanguageClient_serverCommands = {
			\ 'javascript': ['node', '/home/piers/projects/javascript-typescript-langserver/lib/language-server-stdio', '-l', '/dev/null'],
			\ 'typescript': ['node', '/home/piers/projects/javascript-typescript-langserver/lib/language-server-stdio', '-t', '-l', '/dev/null'],
			\ 'cpp': ['/home/piers/projects/cquery/build/cquery', '--log-file=/tmp/cq.log', '--init={"cacheDirectory":"/home/piers/.config/nvim/cquery_cache"}'],
			\ 'c': ['/home/piers/projects/cquery/build/cquery', '--log-file=/tmp/cq.log', '--init={"cacheDirectory":"/home/piers/.config/nvim/cquery_cache"}'],
			\ }

" Unfortunately this seems to conflict with deoplete and causes the completion
" menu to update while cycling through completions.
"    \ 'go': ['go-langserver'],


augroup language_client_maps
	autocmd!
	autocmd filetype c,cpp,javascript,typescript call ApplyLanguageClientMaps()
augroup END

function! ApplyLanguageClientMaps()
	nnoremap <silent> <buffer> <leader>d :<C-u>call LanguageClient#textDocument_definition()<CR>
	nnoremap <silent> <buffer> <leader>h :<C-u>call LanguageClient#textDocument_hover()<CR>
	nnoremap <silent> <buffer> <leader>u :<C-u>call LanguageClient#textDocument_references()<CR>
	nnoremap <silent> <buffer> <leader>g :<C-u>call LanguageClient#textDocument_documentSymbol()<CR>
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
let g:go_metalinter_command = "golangci-lint run"

" Use local godoc server
let g:go_doc_url = 'http://localhost:6060'

" Increase timeout
let g:go_test_timeout = '20s'

" run :GoBuild or :GoTestCompile based on the go file
function! BuildGoFiles()
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


" Go back to beginning of current identifier and insert/delete the star *
function! ToggleStar()
	" Save current position
	let save_pos = getpos(".")

	" Move to just before beginning of word including dots as word chars
	set iskeyword+=.
	normal! bh
	set iskeyword-=.

	" Check if we have a star and if so delete
	if getline(".")[col(".")-1] == '*'
		normal! x
		" Modify save_pos to account for the removed char
		let save_pos[2] = save_pos[2]-1
	else
		normal! a*
		" Modify save_pos to account for the added char
		let save_pos[2] = save_pos[2]+1
	endif

	" Restor postion
	call setpos('.', save_pos)
endfunction


" Executed on a line with a function will propulate godoc for the line above
" leaveing you in insert mode.
function! PopulateGodoc()
	" go to beginning of line then go foward a word
	normal! ^w
	" if the current char is a bracket then goto the next bracket and then to
	" the next word
	if getline(".")[col(".")-1] == '('
		normal! %w
	endif
	" we need to use execute here so that we can use ^[ as escape to be able
	" to print. Yank the to the end of the word open a line above add the
	" comment followed by a space, print the word and append 2 spaces.
	execute ":normal! yeO// pa  "
	" leve the caller in insert mode
	startinsert
endfunction


function! ApplyVimGoMaps()
	" Automatic write on build
	setlocal autowrite

	" set the text width for comment formatting
	"set textwidth=90

	" Build both test and non test files with one command
	nnoremap <buffer> <leader>b :<C-u>call BuildGoFiles()<CR>

	nnoremap <buffer> <leader>t :<C-u>GoTest<CR>

	" Easy doc, rebinding this to quitall for now, i don't seem to use this
	" binding much.
	"nnoremap <buffer> <leader>q :<C-u>GoDoc<CR>

	" Easy referrers
	nnoremap <buffer> <leader>u :<C-u>GoReferrers<CR>

	" make the jump to def (d for def) shortcut easier.
	nnoremap <buffer> <leader>d :<C-u>GoDef<CR>

	" make the return to start (r for return) shortcut easier.

	" make the go alternate shortcut easier.
	nnoremap <buffer> <leader>a :<C-u>GoAlternate<CR>

	" Map K again in buffer specific mode since it is mapped by go
	" to get the doc.
	nnoremap <buffer> K <C-U>

	Arpeggio inoremap <buffer> kl <ESC>:<C-u>call BuildGoFiles()<CR>
	Arpeggio nnoremap <buffer> kl :<C-u>call BuildGoFiles()<CR>

	nnoremap <buffer> <leader>g :<C-u>GoDecls<CR>
	nnoremap <buffer> <leader>p :<C-u>ArgWrap<CR>

	nnoremap <buffer> 88 :<C-u>call ToggleStar()<CR>

	nnoremap <buffer> <F6> :<C-u>call PopulateGodoc()<CR>

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
nnoremap <leader>j :<C-u>:History:<CR>
nnoremap <leader>l :<C-u>:BLines<CR>

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

" typescript config {{{

" The problem with this approach is that when you reload the buffer
" TypeScriptConfig is called again and the autocommands it defines get stacked
" up.
"
" There is also this approach ':%!prettier --write --use-tabs --parser typescript'
" This suffers from losing the cursor position as does the existing solution
" and there doesn't seems to be any way to simply fix that.
"
"function! FormatAndReloadBuffer()
"	!prettier --write --use-tabs --parser typescript %
"	edit
"endfunction

augroup typescript_config
	autocmd!
	autocmd filetype typescript call TypeScriptConfig()
augroup END

function! TypeScriptConfig()
	" For this to work you need to have prettier
	" 'npm install --global prettier'
	setlocal formatprg=prettier\ --use-tabs\ --parser\ typescript tabstop=2
	setlocal tabstop=2
	" This applies this autocmd just to the buffer that triggered the filetype
	" call to TypeScriptConfig we use normal with an exclamation mark since
	" that means we use the default key mapping the mx places a mark and the
	" `x moves us back to that mark. The middle part just fromats the whold
	" file. The problem with the mark is after formatting you don't always
	" move back to the exact same spot.
	"autocmd BufWritePost <buffer> silent :normal! mxgggqG`x
	"autocmd! BufWritePost <buffer> :call FormatAndReloadBuffer()

	" This doesn't work cant chain os commands with vim commands using bar
	"autocmd BufWritePost <buffer> :!prettier --write --use-tabs --parser typescript % | e
endfunction
"}}}


" ArgWrap config {{{
" Add a comma after last wraped argument, this is good for golang
" If I need more flexibility i can define b:argwrap_tail_comma in a buffer
" local ft auto cmd
let g:argwrap_tail_comma = 1
" }}}

endif

inoremap <c-j> <C-n>
