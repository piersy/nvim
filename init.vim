" programming notes {{{
"
" A place to collect my learnings about vim because i write vimscript so
" infrequently that I find myself often solving the same issue multipe times.
"
" A great reference for vimscript - https://learnxinyminutes.com/docs/vimscript
"
" Maintaining cursor locations between edit commands:
"
" 	I use getcurpos rather than winsaveview because winsaveview with
" 	winrestview overwrites any messages that may have been echoed. I guess
" 	because it really restores all parts of the window including what is
" 	currently displayed in the statusbar.
"	E.G:
"   let pos = getcurpos()
"	xxxx
"	call setpos('.', pos)
"
"
" }}}

" plugins {{{
call plug#begin()
" Make sure you use single quotes.

" The best color scheme.
Plug 'piersy/molokai'

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

Plug 'guns/xterm-color-table.vim'

" Conquerer of code, ide like plugin with diagnostics and autocomplete with
" lang server support.
"Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'} "{'branch': 'release'} {'tag': 'v0.0.78'}
"Plug 'piersy/coc.nvim', { 'dir': '~/projects/coc.nvim', 'do': 'yarn install --frozen-lockfile' }
" Plug 'neoclide/coc.nvim', {'tag': 'v1.23' } "{'branch': 'release'} {'tag': 'v0.0.78'}
" Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'} "{'tag': 'v0.0.78'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" I took the snippets from vim-go and put them in their own repo
Plug 'piersy/vim-snippets-go', {'branch': 'main'}

" Nice parentheses
Plug 'kien/rainbow_parentheses.vim'

" Vim overlooks the need to close a buffer without closing a window, this
" plugin provides that functionality. I want this specifically so that if I
" have a window open with a buffer and the quickfix open as well, when I close
" the main buffer I do not want a fullscreen quickfix.
Plug 'moll/vim-bbye'

" fzf plugin from the fzf repo at that location
Plug '~/.fzf'
"Plug '~/.nix-profile/share/vim-plugins/fzf/plugin/fzf.vim'
" the fzf vim plugin which depends on the fzf plugin
Plug 'junegunn/fzf.vim'

" fixes the ':w !sudo tee %' problem in neovim with ':w suda://%'
Plug 'lambdalisue/suda.vim'

" Easily comment/uncomment blocks in code
Plug 'tpope/vim-commentary'

" Syntax highliting for sane files
Plug 'https://gitlab.com/bloom42/libs/sane-vim.git'

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

Plug 'piersy/vim-rebase-view'

Plug 'tpope/vim-eunuch'

" Support for rst editing
Plug 'gu-fan/riv.vim'
" Support for rst preview
"Plug 'gu-fan/InstantRst'

Plug 'jiangmiao/auto-pairs'

Plug 'piersy/go-cover-vim'

"" Add plugins to &runtimepath.
call plug#end()
"}}}

" riv-vim{{{
let g:rst_fold_enabled=1
" }}}

" abbreviations {{{
iabbrev netowrk network
iabbrev timout timeout
"}}}

" Arpeggio needs to be loaded as the init.vim is parsed so that
" it can be used for defining key mappings.
call arpeggio#load()


" Sets the molokai colorscheme without this line you get normal colors.
"set termguicolors
colorscheme molokai

" Im not sure when this happened but visual is almoste impossible to see
" Lately
hi Visual ctermbg=241
" Comments became tricky to see as well
hi Comment ctermfg=245
" The highlighting on the current line of coc list was also tricky
hi CursorLine ctermbg=244
" if has("termguicolors")
" 	set termguicolors
" endif
"let g:rehash256 = 1
"let g:molokai_original = 1

" Work around for broken xfce4-terminal stops garbage characters being printed
" in neovim 0.2.2+
set guicursor=

set shortmess-=F

" temp utility functions {{{
" exe "normal! ggHwwi'^[%a'^[" | :%s/\n/ /g
command! RML :g/\s*\/\//d
command! Tracer :%s/\s*\/\/.*// | :execute "normal! gg^wwi'<esc>%a'<esc>" | :%s/\n/ /g
" }}}

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

" Make new windows appear on the right
set splitright

" Make sure wrapping wraps at word boundaries.
set linebreak

"augroup help_setup
"	autocmd!
"	autocmd FileType help setlocal buflisted
"	autocmd filetype help call ApplyHelpSetup()
"augroup END
"
"function! ApplyHelpSetup()
"	autocmd BufEnter <buffer> setlocal conceallevel=2 | echom "enterning"
"endfunction

" Make help buffers be listed as normal buffers and ensure that the
" conceallevel is maintained. I'm not sure why but when setting a help buffer
" to be listed, navigating away from it and back again seems to reset the
" conceallevel and conceal cursor settings.
autocmd! FileType help autocmd BufEnter <buffer> setlocal buflisted | setlocal conceallevel=2 | setlocal concealcursor=nc

" This command calls help and ensures that it uses the only available window,
" we need to use execute since <f-args> are the quoted arguments provided by
" the user and help topics cannot be quoted when calling help. By using
" execute I guess the quoted arg is just bundled into the string unquoted.
command! -nargs=1 -complete=help Help execute 'help ' .  <f-args> . '| only'

" Ensure that help gets expanded to Help onthe commandline
cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'Help' : 'h'
cnoreabbrev <expr> he getcmdtype() == ":" && getcmdline() == 'he' ? 'Help' : 'he'
cnoreabbrev <expr> hel getcmdtype() == ":" && getcmdline() == 'hel' ? 'Help' : 'hel'
cnoreabbrev <expr> help getcmdtype() == ":" && getcmdline() == 'help' ? 'Help' : 'help'


" history options {{{

" Protect changes between writes. Default values of
" updatecount (200 keystrokes) and updatetime
" (4 seconds) are fine
set swapfile

" protect against crash-during-write
set nowritebackup
" but do not persist backup after successful write
set nobackup
" use rename-and-write-new method whenever safe
set backupcopy=auto
" persist the undo tree for each file
set undofile

"}}}

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
nnoremap <F8> :e $MYVIMRC<CR>
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
"command! WRITE execute "w !sudo tee %"
" this is a new version using lambdalisue/suda.vim needed due to a neovim bug
command! WRITE execute ":w suda://%"


nnoremap <leader>s :<C-u>write<CR>
nnoremap <leader>S :<C-u>WRITE<CR>

vnoremap <leader>d :Linediff<CR>


" Close all other buffers
" mq marks the cursor location in buffer q and `q restores that locaiton, the
" rest is a command that closes all other buffers, not sure about how exactly
" it does it but it works.
command! BufOnly silent! execute "normal! mq:%bd|e#|bd#<cr>`q"

nnoremap <leader>a :<c-u>BufOnly<cr>

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
			"Bwipeout totally removes the buffer so it does not become an
			"unlisted buffer.
			Bwipeout
		else
			" else delete the buffer and window (for example this would apply
			" to the quickfix window)
			bwipeout
		endif
	endif
endfunction

nnoremap <leader>c :<C-u>call CloseBufferOrQuit()<CR>
nnoremap <leader>q :<C-u>quitall<CR>
nnoremap <leader><ESC> :<C-u>quitall!<CR>

nnoremap <leader>v :<C-u>vsplit<CR>
nnoremap <leader>k :<C-u>close<CR>

" Format text
nnoremap <leader>j gqk
vnoremap <leader>j gq



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
" Make esc in normal mode clear highlighting. And then execute esc in a
" recursive manner, this means this will work as esc is inteded to within
" contexts where a plugin has rebound esc.
Arpeggio nmap <silent> df :<C-u>nohlsearch<CR><esc>

" Allow escaping from visual mode, even if I don't use this much, not having
" it is very confusing since pressing df will delete the visual selection, so
" I keep it here.
Arpeggio vnoremap df <esc>

" Map fn to equivalient of escape in terminal mode. We can't map df here
" otherwise when we have vim inside a terminal in vim and we escape the df
" would escape the terminal rather than be passed to the vim inside the
" terminal. We also add a search back to first line starting with a dollar
" then remove search highlighting. This stops the cursor appearing at the
" bottom when we escape.
Arpeggio tnoremap fn <C-\><C-n>G?^\$<CR>:<C-u>nohlsearch<CR>

" Remove the original esc key functionality.
" inoremap <esc> <NOP>
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
Arpeggio map jk <CR>
Arpeggio imap jk <CR>
Arpeggio cmap jk <CR>

"
" As with esc we have to map fj instead of jk so that when using vim inside a
" terminal in vim we do not trigger the <CR>  of the terminal.
Arpeggio tnoremap fj <CR>

" Remove the original <CR> key functionality. But not in insert mode since I
" want to use it for completing files. And not in command mode, since it is useful
" for entering commands after using the direction keys.
" nnoremap <CR> <NOP>
" vnoremap <CR> <NOP>

tnoremap <C-j> <down>
tnoremap <C-k> <up>

" Toggle spell
nnoremap <leader>x  :<C-u>setlocal spell! <CR>

" Map s to auto replace the word under cursor with the first spelling, <c-g>u inserts an undo-break so that the change can be undone with u. (not sure the undo break is needed
nnoremap s 1z=

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

" Toggle help filetype, unfortunately tab is also <c-i> and so interferes with
" jumping forwards and back
"nnoremap <expr> <tab> &ft == "help" ? ":set ft=<cr>" : ":set ft=help<cr>"

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

" git rebase buffer key mappings {{{
augroup rebase_keymaps
	autocmd!
	autocmd filetype gitrebase call s:ConfigureRebaseKeymaps()
augroup END

function! s:ConfigureRebaseKeymaps()
	" Map K again in buffer specific mode since it is mapped by vim by default
	" to show the commit uner the cursor, it does this by setting keywordprg
	" to 'git show'
	nnoremap <buffer> K <C-U>
	nnoremap <silent> <buffer> <leader>e :call rebaseview#DisplayCommit('--stat')<CR>
	nnoremap <silent> <buffer> <leader>d :call rebaseview#DisplayCommit('')<CR>
	nnoremap <silent> <buffer> <leader>l :call rebaseview#DisplayLog('--stat')<CR>
endfunction
" end gitrebase keymappings }}}

" end genric key mappings }}}

" generic utility functions {{{

" Strips trailing whitespace and makes sure the cursor returns to it's initial
" position.
function! StripTrailingWhitespaces()
	" Note I use getcurpos rather than winsaveview because winsaveview with
	" winrestview overwrites any messages that may have been echoed. I guess
	" because it really restores all parts of the window including what is
	" currently displayed in the statusbar.
 	let pos = getcurpos()
	%s/\s\+$//e
 	call setpos('.', pos)
endfun

"" Highlight trainling spaces red, its important that this matches '*' since it
"" is applied to window's rather than buffers, so we need to ensure that any
"" open window gets the same treatment. If I wanted to apply this to certain
"" buffers only then I would need to change the events to work on buffers.
"highlight ExtraWhitespace ctermbg=red guibg=red
"autocmd! BufWinEnter * match ExtraWhitespace /\s\+$/
"" This line stops matching trainling whitespace on the line with the cursor.
"" '\%#' matches the cursor and '\@<!' requires the prior token to not match in
"" order for the pattern to match.
"autocmd! InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"autocmd! InsertLeave * match ExtraWhitespace /\s\+$/
"autocmd! BufWinLeave * call clearmatches()

" Set up easy (surround) in visual mode
" `< and `> mark the beginning and end of the last selection. So we esc go to
" the end insert the char go to the other end insert the other char and esc.
" TODO mark the place where we insert the last char and finish there.
vnoremap ` <esc>`>a`<esc>ma`<i`<esc>`al
vnoremap ' <esc>`>a'<esc>ma`<i'<esc>`al
vnoremap " <esc>`>a"<esc>ma`<i"<esc>`al
vnoremap ( <esc>`>a)<esc>ma`<i(<esc>`al
vnoremap ) <esc>`>a)<esc>ma`<i(<esc>`al
vnoremap ] <esc>`>a]<esc>ma`<i[<esc>`al
vnoremap [ <esc>`>a]<esc>ma`<i[<esc>`al

" Search for literal string
command! -nargs=1 S let @/ = escape('<args>', '\')
nnoremap <Leader>F :execute(":S " . input('Regex-off: /'))<CR>

" Map Y (which amazingly isn't mapped to anything by default) to yank the
" current filename + linenumber + line(on a newline)
nnoremap Y :let @+ = expand("%").":".line(".")."\n".getline(".")<CR>

function! s:CloseOtherBuffers()
 	let pos = getcurpos()
	silent! execute "%bd|e#|bd#"
 	call setpos('.', pos)
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

	" Ensures that tabs are expanded to spaces when inserted
	setlocal expandtab
endfunction
"}}}

" solidity file type config {{{
augroup solidity_config
	autocmd!
	autocmd filetype solidity call ConfigureYaml()
augroup END

function! ConfigureSolidity()
	" Set tabs to be represented by 2 spaces;
	setlocal tabstop=4

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
"let g:deoplete#enable_at_startup = 1

" navigate the menu with cj and ck
" inoremap <C-j> <C-n>
" inoremap <C-k> <C-p>

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

" coc nvim config {{{

" coc nvim suggested settings {{{

" Some servers have issues with backup files, see #649
set nowritebackup
set nobackup
" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes
"}}}

" We need to override this as coc vim does some dynamic setting based on the
" color scheme and it doesn't work for molokai
hi! link CocMenuSel PmenuSel

let g:coc_global_extensions = ['coc-vimlsp','coc-snippets','coc-eslint','coc-tsserver','coc-pyright','coc-go','coc-rust-analyzer']


let g:coc_snippet_next='<tab>'
let g:coc_snippet_prev='<s-tab>'

let g:coc_enable_locationlist = 0

" Toggles the first letter of word to be capital or lowercase.
function! ToggleCapital(word)
	" Try to substitute lowercase for initial captial
	let result = substitute(a:word, "^\\u.*", "\\l\\0", "")
	if result != a:word 
		return result
	endif
	" if no change ocurred then word must start with lowercase so return
	" with initial capitalised.
	return substitute(a:word, "^\\U.*", "\\u\\0", "")
endfunction

function! s:CocListToggle()
	" Count existing list buffers
	let lists = len(filter(range(1, bufnr('$')), 'stridx(bufname(v:val), "list://") ==# 0'))
	if lists > 0
		:CocListCancel
	else
		:CocList diagnostics
	endif
endfunction

augroup coc_vim_setup
	autocmd!
	" Setup languages for which coc vim is enabled, also some require language
	" server support in in coc-settings.json (:CocConfig).
	autocmd filetype sh,vim,go,c,cpp,javascript,typescript,python,rust,yaml call ApplyCocVimSetup()
	" autocmd filetype vim,c,cpp,javascript,typescript,python call ApplyCocVimSetup()
	" Organize imports on save
	autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
	" format on save
	autocmd BufWritePre *.go,*.py,*.c,*.cpp,*.h,*.hpp,*.ts,*.js,*.rs,*.yml,*.yaml :call CocAction('format')
	" Update signature help on jump placeholder, this makes the function
	" param help be displayed as you jump between function params when
	" completing.
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	autocmd User CocLocationsChange CocList --no-quit --normal location

	" Adjust the size of the coctree view to be at most 1/2 the screen
	" otherwise the longest line length in the window
	" 
	" This is an example of chaining 2 autocmds I'm not sure why but if we try
	" to apply the second autocmd without the <buffer> option then it doesnt
	" seem to trigger, maybe because it doesn't really make sense ... anyway
	" who knows. So this command basically adds an autocmd to the coctree
	" buffer that will set the winwidth option whenever the text changes and
	" it sets the width to be the smaller of the longest line or 1/2 the total
	" vim instance with.
	" autocmd FileType coctree autocmd TextChanged <buffer> let &winwidth = min([&columns/2, max(map(getline(1,'$'), 'len(v:val)'))])
augroup END

" This is workikng
" autocmd! FileType coctree autocmd TextChanged <buffer> let &winwidth = min([&columns/2, float2nr(max(map(getline(1,'$'), 'len(v:val)')) * 1.2)])

function! ApplyCocVimSetup()
	nmap <silent> <buffer> <leader>d <Plug>(coc-definition)
	nmap <silent> <buffer> <leader>t <Plug>(coc-type-definition)
	nmap <silent> <buffer> <leader>i <Plug>(coc-implementation)
	" u for usages, we save r for rename
	nmap <silent> <buffer> <leader>u <Plug>(coc-references)
	nmap <silent> <buffer> <leader>r <Plug>(coc-rename)
	nmap <silent> <buffer> <leader>h :call CocAction('showIncomingCalls')<CR>
	" h for hierarchy 
	" Toggle from public to private
	nnoremap <buffer> <expr> <leader>m ':call CocAction("rename", "' . ToggleCapital(expand("<cword>")) . '")<cr>'
	" This searches for a string and finds all occurrences and lets us edit
	" them with multiple cursors, can be useful for simple refactors, the
	" trailing space is intended.
	nnoremap <silent> <buffer> <leader>R :CocSearch 

	"Opens the renameable element under the cursor in a separate window with
	"multiple cursors so that it can be renamed whilst watching all the
	"changes. Its not really a refactor though better to use :CocSearch which
	"does the same but for a specific search string so I can find all
	"instantiations of a struct for instance!
	"nmap <silent> <buffer> <leader>u <Plug>(coc-refactor)

	" This will override the LocationListToggle mapping inside coc vim
	" buffers but CocDiagnostics opens the location list so has the same
	" behaviour, once the list is open we are not in a coc vim buffer so
	" LocationListToggle takes over to let us close the location list.
	nnoremap <silent> <buffer> <leader><space> :call <SID>CocListToggle()<cr>
	nnoremap <silent> <buffer> <leader>g :CocList outline<cr>
	nnoremap <silent> <buffer> <leader>w :<c-u>CocList symbols<cr>


	nnoremap <silent> <buffer> <c-l> :<c-u>CocNext<cr>
	nnoremap <silent> <buffer> <c-h> :<c-u>CocPrev<cr>

	nmap <silent> <buffer> <m-.> <Plug>(coc-diagnostic-next-error)
	nmap <silent> <buffer> <m-,> <Plug>(coc-diagnostic-prev-error)

	" ctrl + [ results in <esc> so we can't use these mappings, but i didn't
	" really use them anyway, usually I just browse the list. Leving this here
	" so I don't make the same mistake in the future.
	" nmap <silent> <buffer> <c-]> <Plug>(coc-diagnostic-next)
	" nmap <silent> <buffer> <c-[> <Plug>(coc-diagnostic-next)
	nmap <silent> <buffer> <leader>f <Plug>(coc-fix-current)


	" this is not working for golang
	"nmap <silent> <buffer> <leader>t <Plug>(coc-range-select)

	" Select in function
	xmap if <Plug>(coc-funcobj-i)
	omap if <Plug>(coc-funcobj-i)

	" Select around function
	xmap af <Plug>(coc-funcobj-a)
	omap af <Plug>(coc-funcobj-a)


	" disabled in favour of call hierarchy
	" nnoremap <silent> <buffer> <leader>h :call CocAction('doHover')<CR>
	nnoremap <silent> <buffer> <leader>l :call CocAction('doHover')<CR>

	" Map jk to insert the command wait for a few milliseconds for coc to add
	" the brackets if its a function (not sure how coc does this) and then esc
	" to normal.
	" Arpeggio imap <buffer> <expr> jk pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"

	" coc has its own pop up menu so we need to set our keys for coc here
    Arpeggio imap <buffer> <expr> jk coc#pum#visible() ? coc#_select_confirm() : "\<CR>"
	" Insert <tab> when previous text is space, refresh completion if not.
	inoremap <silent><expr> <c-j> coc#pum#visible() ? coc#pum#next(1) : ""
	inoremap <silent><expr> <c-k> coc#pum#visible() ? coc#pum#prev(1) : ""

	" Map enter to insert the top command and continue in insert.
	"inoremap <buffer> <expr> <cr> pumvisible() ? "\<c-y>\<cmd>sleep 80m\<cr>\<esc>" : "\<c-g>u\<cr>"
	"inoremap <buffer> <expr> <esc> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"

	" So in order to compose the filetype and the CursorHold events we need to
	" use an augroup in an augroup so that we can reliably clear previous
	" autocmds. Without this augroup the cursor hold event is set every time
	" a buffer of the filetypes defined above is entered. This can lead to
	" multiple events being fired for cursor hold which causes flickering.
	augroup coc_vim_cursor_hold
		autocmd!
		" Highlight symbol under cursor on CursorHold
		autocmd CursorHold <buffer> silent call CocActionAsync('highlight')
	augroup END

	" Map ctrl+space to manually open completion, great for completing structs
	" in golang.
	inoremap <silent> <c-space> <C-R>=coc#start()<CR>

	" coc has its own menu now!
	" inoremap <expr><C-J> pumvisible() ? "\<C-n>" : "\<C-J>"
	" inoremap <expr><C-K> pumvisible() ? "\<C-p>" : "\<C-K>"

	inoremap <silent><expr> <TAB>
				\ coc#pum#visible() ? coc#pum#next(1) :
				\ CheckBackspace() ? "\<Tab>" :
				\ coc#refresh()
	inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
	inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
	function! CheckBackspace() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	nmap <buffer> <leader>y <Plug>(coc-codeaction-cursor)
	nmap <buffer> <leader>; <Plug>(coc-codelens-action)

endfunction

""}}}

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


" I spent some time investigating rg vs ag for the find functions, I was using
" the following:
"
"ag --nogroup --column --hidden --all-text --follow --ignore-dir '.git'  '^(?=.)' | awk -F ":" '{print $1}' | sort | uniq > agfiles
"
"rg --column --line-number --no-heading  --ignore-case --no-ignore --hidden --follow --glob '!*.git/*' '' | awk -F ":" '{print $1}' | sort | uniq > rgfiles
"
" It turns out that when you use the all-text option for ag it overrides the
" ignore or ingore-dir flags which really makes it unsuited for what I want to
" do. Performance wise both these commands seemed to take about the same
" amount of time before trying to exclude git, although rg was returning
" results from more files, so is probably a mite faster. Also ag seemed to not
" include some files and I couldn't understand why. So the winner is rg

" consider moving all fzf mappings to use alt (m) so that they are easier to
" remember
nnoremap <m-o> :<C-u>:MyFiles<CR>
nnoremap <m-i> :<c-u>Find<cr>
nnoremap <m-j> :<C-u>:History:<CR>
nnoremap <m-l> :<C-u>:Lines<CR>
nnoremap <m-b> :<c-u>Buffers<cr>


" This command behaves the same as the one I use on the commandline for
" opening files.
command! -nargs=? MyFiles call fzf#run(fzf#wrap({
			\ 'source': 'fd --hidden --type f --exclude .git',
			\ 'options': '--multi --extended --no-sort',
			\ 'down':    '40%',
			\ 'dir': <q-args>}))


" FZF with ripgrep
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
command! -bang -nargs=* Find
			\ call fzf#vim#grep(
			\   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!*.git/*" --color "always" '.shellescape(<q-args>), 1,
			\   <bang>0 ? fzf#vim#with_preview('up:60%')
			\           : fzf#vim#with_preview('right:50%:hidden', '?'),
			\   <bang>0)

" Jump to buffers
command! Buffers call fzf#run({
\ 'source':  reverse(s:all_files()),
\ 'sink':    'edit',
\ 'options': '-m -x +s',
\ 'down':    '40%' })

function! s:all_files()
  return map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)')
endfunction

" Commend to get prs with field and title and then insert the pr
command! Prs call fzf#run(fzf#wrap({
			\ 'source': 'ghapi prs --repo celo-org/celo-blockchain --fields "title:%v ,url:[%v]"',
			\ 'sink':    function('s:insert_line'), 
			\ 'options': '--multi --extended --no-sort',
			\ 'down':    '40%'}))

function! s:insert_line(item)
    let @z=a:item
    norm "zp
endfunction

"}}}

" typescript config {{{

augroup typescript_config
	autocmd!
	autocmd filetype typescript call TypeScriptConfig()
augroup END

function! TypeScriptConfig()
	setlocal tabstop=2
endfunction
"}}}

" javascript config {{{

augroup javascript_config
	autocmd!
	autocmd filetype javascript call JavascriptConfig()
augroup END

function! JavascriptConfig()
	setlocal tabstop=2
endfunction
"}}}

" ArgWrap config {{{
" Add a comma after last wraped argument, this is good for golang
" If I need more flexibility i can define b:argwrap_tail_comma in a buffer
" local ft auto cmd
let g:argwrap_tail_comma = 1
nnoremap <leader>p :<C-u>ArgWrap<CR>
" }}}

" InstantRst config {{{
let g:instant_rst_browser = 'google-chrome'
" }}}

" vim commentary config {{{
" Not sure why but vim registers <c-/> as <c-_> so this is mapping ctrl+/ to
" toggle comments.
	nmap <c-_> <Plug>CommentaryLine
	vmap <c-_> <Plug>Commentary
" }}}

" Vim fugitive mappings {{{

nnoremap <F1> :<C-u>Git blame<CR>

" }}}

" Work diary functions {{{
"
" for *.dir.md files

function! s:IsInt(val)
	return a:val =~# '^\d\+$'
endfunction

" GotoToday jumps to the line in the diary file that corresponds to today,
" it's using the binary diary which I actually built from my work-diary repo
" and moved to my path under the name diary.
function! s:GotoToday()
	" system runs a system command and returns the output, trim removes the
	" trailing newline. %:p expands to the full path :h removes the last path
	" element, :h can be used multiple times.
	let line = trim(system('diary day --year '.strftime('%Y').' --dir '.expand('%:p:h')))
	if !s:IsInt(line)
		echo line
		return
	endif
	if line == -1
		echom "Today not found in file"
		return
	endif
	execute "normal! ".line."gg"
endfunction

augroup diary
  autocmd!
  autocmd BufNewFile,BufRead *.dir.md nnoremap <buffer> <silent> <leader>d :call <SID>GotoToday()<CR>
augroup END

" }}}


command! LogAutocmds call s:log_autocmds_toggle()

function! s:log_autocmds_toggle()
  augroup LogAutocmd
    autocmd!
  augroup END

  let l:date = strftime('%F', localtime())
  let s:activate = get(s:, 'activate', 0) ? 0 : 1
  if !s:activate
    call s:log('Stopped autocmd log (' . l:date . ')')
    return
  endif

  call s:log('Started autocmd log (' . l:date . ')')
  augroup LogAutocmd
    for l:au in s:aulist
      silent execute 'autocmd' l:au '* call s:log(''' . l:au . ''')'
    endfor
  augroup END
endfunction

function! s:log(message)
  silent execute '!echo "'
        \ . strftime('%T', localtime()) . ' - ' . a:message . '"'
        \ '>> /tmp/vim_log_autocommands'
endfunction

" These are deliberately left out due to side effects
" - SourceCmd
" - FileAppendCmd
" - FileWriteCmd
" - BufWriteCmd
" - FileReadCmd
" - BufReadCmd
" - FuncUndefined

let s:aulist = [
      \ 'BufNewFile',
      \ 'BufReadPre',
      \ 'BufRead',
      \ 'BufReadPost',
      \ 'FileReadPre',
      \ 'FileReadPost',
      \ 'FilterReadPre',
      \ 'FilterReadPost',
      \ 'StdinReadPre',
      \ 'StdinReadPost',
      \ 'BufWrite',
      \ 'BufWritePre',
      \ 'BufWritePost',
      \ 'FileWritePre',
      \ 'FileWritePost',
      \ 'FileAppendPre',
      \ 'FileAppendPost',
      \ 'FilterWritePre',
      \ 'FilterWritePost',
      \ 'BufAdd',
      \ 'BufCreate',
      \ 'BufDelete',
      \ 'BufWipeout',
      \ 'BufFilePre',
      \ 'BufFilePost',
      \ 'BufEnter',
      \ 'BufLeave',
      \ 'BufWinEnter',
      \ 'BufWinLeave',
      \ 'BufUnload',
      \ 'BufHidden',
      \ 'BufNew',
      \ 'SwapExists',
      \ 'FileType',
      \ 'Syntax',
      \ 'EncodingChanged',
      \ 'TermChanged',
      \ 'VimEnter',
      \ 'GUIEnter',
      \ 'GUIFailed',
      \ 'TermResponse',
      \ 'QuitPre',
      \ 'VimLeavePre',
      \ 'VimLeave',
      \ 'FileChangedShell',
      \ 'FileChangedShellPost',
      \ 'FileChangedRO',
      \ 'ShellCmdPost',
      \ 'ShellFilterPost',
      \ 'CmdUndefined',
      \ 'SpellFileMissing',
      \ 'SourcePre',
      \ 'VimResized',
      \ 'FocusGained',
      \ 'FocusLost',
      \ 'CursorHold',
      \ 'CursorHoldI',
      \ 'CursorMoved',
      \ 'CursorMovedI',
      \ 'WinEnter',
      \ 'WinLeave',
      \ 'TabEnter',
      \ 'TabLeave',
      \ 'CmdwinEnter',
      \ 'CmdwinLeave',
      \ 'InsertEnter',
      \ 'InsertChange',
      \ 'InsertLeave',
      \ 'InsertCharPre',
      \ 'TextChanged',
      \ 'TextChangedI',
      \ 'ColorScheme',
      \ 'RemoteReply',
      \ 'QuickFixCmdPre',
      \ 'QuickFixCmdPost',
      \ 'SessionLoadPost',
      \ 'MenuPopup',
      \ 'CompleteDone',
      \ 'User',
      \ ]


imap <c-3> 3
