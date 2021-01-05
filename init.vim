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
"Plug 'neoclide/coc.nvim', {'tag': 'v1.23' } "{'branch': 'release'} {'tag': 'v0.0.78'}
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'} "{'tag': 'v0.0.78'}

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

"" Add plugins to &runtimepath.
call plug#end()
"}}}

" riv-vim{{{
let g:rst_fold_enabled=1
" }}}

" abbreviations {{{
iabbrev netowrk network
"}}}

" Arpeggio needs to be loaded as the init.vim is parsed so that
" it can be used for defining key mappings.
call arpeggio#load()


" Sets the molokai colorscheme without this line you get normal colors.
" colorscheme molokai
" if has("termguicolors")
" 	set termguicolors
" endif

" Work around for broken xfce4-terminal stops garbage characters being printed
" in neovim 0.2.2+
set guicursor=

set shortmess-=F

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
command! BufOnly silent! execute "%bd|e#|bd#"

nnoremap <leader>a :<c-u>BufOnly<cr>


" Map jump back to jump back and unlist - doesn't work, unlists everything in
" the end
"nnoremap <c-o> <c-o> \| :setlocal nobuflisted<cr>
"
"Another try I add a varibale to buffers that lets me know if they are listed
"or not.
function! s:PersistNobl()
  if exists('b:persist_nobl')
    setlocal nobuflisted
  elseif !&buflisted
    let b:persist_nobl = 1
  endif
endfunction

augroup persist_nobuflisted
  autocmd!
  autocmd OptionSet buflisted call <SID>PersistNobl()
  autocmd BufEnter * call <SID>PersistNobl()
augroup END

function! s:SetListed()
	unlet b:persist_nobl
    setlocal buflisted
endfunction

nnoremap <leader>n :call <SID>SetListed()<cr>

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

nnoremap <leader>w :<C-u>vsplit<CR>
nnoremap <leader>k :<C-u>close<CR>
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

" {{{ Moving over to location list with coc nvim
" function! QFixToggle()
" 	let qf = filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "qf"')
" 	if len(qf) > 0
" 		cclose
" 	else
" 		let curr_win = winnr()
" 		copen
" 		:execute curr_win . "wincmd w"
" 	endif
" endfunction

" " Easy quickfix closing
" nnoremap <leader><Space> :<C-u>call QFixToggle()<CR>

" " This sets up commands to loop through the quickfix list. Normal
" " behaviour will only acknowledge cnext or cprev if there is more than one
" " quickfix entry.
" command! Cnext try | cnext | catch | cfirst | catch | endtry
" command! Cprev try | cprev | catch | clast | catch | endtry

" " Cycle through entries in the quickfix
" nnoremap <C-l> :<C-u>Cnext<CR>
" nnoremap <C-h> :<C-u>Cprev<CR>
" }}}

" {{{ LocationList config
"function! s:LocationListToggle() abort
"" Try and close the location list and then if the buffer count didn't
"	" change we know it was not open so we open it.
"	"
"    let buffer_count_before = s:BufferCount()
"    lclose

"    if s:BufferCount() == buffer_count_before
"        lopen
"    endif
"endfunction

"function! s:BufferCount() abort
"    return len(filter(range(1, bufnr('$')), 'bufwinnr(v:val) != -1'))
"endfunction

"nmap <silent> <leader><space> :call <SID>LocationListToggle()<cr>
" }}}

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
"
" For refernence these are the filetypes set for git.
" git
" gitconfig
" gitrebase
" gitsendemail
"
"function! s:OutputInGitWindow(cmdline)
"	" Open new vertical window
"	vert new
"	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap filetype=git
"	file "" . a:cmdline
"
"	" Name the buffer with the command we executed.
"	" In order to call file with an argument we need to use execute. This is
"	" becuause file doesn't accept variables as its arguments. We can infer
"	" this from the doc since commands that can interpret variables (eg echo)
"	" use '{expr}' to refer to their arguments whereas file doc simply lists
"	" '{name}'. 
"	silent execute 'file Command: ' . a:cmdline
"
"	"0read makes read insert text below the 0th line
"	silent execute '0read !' . a:cmdline
"	1 " go to first line
"endfunction
"function! s:GetGitSha()
"	" Return first match in current line of 8 hex chars with a space at either
"	" end
"	return trim(matchstr(getline("."),' \x\{7} '))
"endfunction
"
"function! s:GetShaRange()
"	" Return first match in current line of 8 hex chars with a space at either
"	" end
"	"GetGitSha
"	"# Rebase 056af67..ef7b34d onto 056af67 (4 commands)
"	let line=search('\v# Rebase \x{7}\.\.\x{7} onto \x{7} \(\d+ commands\)')
"	return matchstr(getline(line), '\v\x{7}\.\.\x{7}')
"endfunction
"
"function! s:DisplayCommit(options)
"	let commitsha = s:GetGitSha()
"	if commitsha != ""
"		call s:OutputInGitWindow('git show ' . a:options .' '. commitsha)
"	endif
"endfunction

"function! s:DisplayLog(options)
"	let range = s:GetShaRange()
"	if range != ""
"		call s:OutputInGitWindow('git log --reverse ' . a:options . ' ' . range)
"	endif
"endfunction
"

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

"augroup gitrebase_maps
"	autocmd!
"	autocmd filetype gitrebase call s:ConfigureGitRebase()
"augroup END
"
"function! s:ConfigureGitRebase()
"	" Map K again in buffer specific mode since it is mapped by vim by default
"	" to show the commit uner the cursor, it does this by setting keywordprg
"	" to 'git show'
"	nnoremap <buffer> K <C-U>
"	nnoremap <silent> <buffer> <leader>e :call rebaseview#DisplayCommit('--stat')<CR>
"	nnoremap <silent> <buffer> <leader>d :call rebaseview#DisplayCommit('')<CR>
"	nnoremap <silent> <buffer> <leader>l :call rebaseview#DisplayLog('--stat')<CR>
"endfunction


" end gitrebase keymappings }}}

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

"}}}

" netrw buffer key mappings {{{
" Allow easy window opening.

" This needs to be updated for terminal use, Explore expects
" the current file name to be a file, for terminals it is not a file name so
" we need to do something different, I'd suggest opening the explore at the
" same dir that the terminal is in.
"nnoremap <leader>e :call MyExplore()<CR> decided I don't want to use this any
"more now that i can open files with fzf

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
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

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

" coc nvim suggests these settings

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
	autocmd filetype vim,go,c,cpp,javascript,typescript,python call ApplyCocVimSetup()
	" autocmd filetype vim,c,cpp,javascript,typescript,python call ApplyCocVimSetup()
	" Organize imports on save
	autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
	" format on save
	" autocmd BufWritePre *.go,*.py,*.js,*.ts,*.c,*.cpp,*.h,*.hpp :call CocAction('format')
	autocmd BufWritePre *.go,*.py,*.c,*.cpp,*.h,*.hpp :call CocAction('format')
	" Update signature help on jump placeholder, this makes the function
	" param help be displayed as you jump between function params when
	" completing.
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	autocmd User CocLocationsChange CocList --no-quit --normal location
augroup END


function! ApplyCocVimSetup()
	nmap <silent> <buffer> <leader>d <Plug>(coc-definition)
	nmap <silent> <buffer> <leader>t <Plug>(coc-type-definition)
	nmap <silent> <buffer> <leader>i <Plug>(coc-implementation)
	" u for usages, we save r for rename
	nmap <silent> <buffer> <leader>u <Plug>(coc-references)
	nmap <silent> <buffer> <leader>r <Plug>(coc-rename)
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


	nnoremap <silent> <buffer> <c-l> :<c-u>CocNext<cr>
	nnoremap <silent> <buffer> <c-h> :<c-u>CocPrev<cr>

	nmap <silent> <buffer> <m-.> <Plug>(coc-diagnostic-next-error)
	nmap <silent> <buffer> <m-,> <Plug>(coc-diagnostic-prev-error)
	nmap <silent> <buffer> <c-]> <Plug>(coc-diagnostic-next)
	nmap <silent> <buffer> <c-[> <Plug>(coc-diagnostic-next)
	nmap <silent> <buffer> <leader>f <Plug>(coc-fix-current)


	" this is not working for golang
	"nmap <silent> <buffer> <leader>t <Plug>(coc-range-select)

	" Select in function
	xmap if <Plug>(coc-funcobj-i)
	omap if <Plug>(coc-funcobj-i)

	" Select around function
	xmap af <Plug>(coc-funcobj-a)
	omap af <Plug>(coc-funcobj-a)


	nnoremap <silent> <buffer> <leader>h :call CocAction('doHover')<CR>

	" Map jk to insert the command wait for a few milliseconds for coc to add
	" the brackets if its a function (not sure how coc does this) and then esc
	" to normal.
	Arpeggio imap <buffer> <expr> jk pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
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

" consider moving all fzf mappings to use alt (m) so that they are easier to
" remember
nnoremap <m-o> :<C-u>:MyFiles<CR>
nnoremap <m-j> :<C-u>:History:<CR>
nnoremap <m-l> :<C-u>:Lines<CR>
nnoremap <m-b> :<c-u>Buffers<cr>
nnoremap <m-i> :<C-u>:Find<CR>

" This command behaves the same as the one I use on the commandline for
" opening files.
command! -nargs=? MyFiles call fzf#run(fzf#wrap({
			\ 'source': 'fd --hidden --type f',
			\ 'options': '--multi --extended --no-sort',
			\ 'down':    '40%',
			\ 'dir': <q-args>}))


"
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
"

command! -bang -nargs=* Find
			\ call fzf#vim#grep(
			\   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1,
			\   <bang>0 ? fzf#vim#with_preview('up:60%')
			\           : fzf#vim#with_preview('right:50%:hidden', '?'),
			\   <bang>0)
set grepprg=rg\ --vimgrep



" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
			\ call fzf#vim#grep(
			\   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
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


" Command to get prs with field and title and then insert the pr
command! Prs call fzf#run(fzf#wrap({
			\ 'source': 'ghapi prs --repo clearmatics/autonity --fields "title:%v ,url:[%v]"',
			\ 'sink':    function('s:insert_line'), 
			\ 'options': '--multi --extended --no-sort',
			\ 'down':    '40%'}))

function! s:insert_line(item)
    let @z=a:item
    norm "zp
endfunction


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

" Github graphql functions {{{

" Toggles the first letter of word to be capital or lowercase.
function! GetPRs()
	" Try to substitute lowercase for initial captial
	let result = substitute(a:word, "^\\u.*", "\\l\\0", "")
	if result != a:word 
		return result
	endif
	" if no change ocurred then word must start with lowercase so return
	" with initial capitalised.
	return substitute(a:word, "^\\U.*", "\\u\\0", "")
endfunction

" }}}
