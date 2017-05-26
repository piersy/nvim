call plug#begin()
" Make sure you use single quotes.

" The best color scheme.
Plug 'tomasr/molokai'

" Map multiple simultaneous key presses.
Plug 'kana/vim-arpeggio'

" Handle tags easily
Plug 'xolox/vim-easytags' | Plug 'xolox/vim-misc'

" Find and open files easily.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
"Plug 'junegunn/fzf.vim'

" Autocomplete and semantic highlighting for c and c++.
Plug 'Valloric/YouCompleteMe', { 'for' : ['c', 'cpp'] }

Plug 'tpope/vim-surround'

Plug 'fatih/vim-go'

"Kill buffers without killing windows
Plug 'qpkorr/vim-bufkill'

" Nice parenthesis
Plug 'kien/rainbow_parentheses.vim'

" Add plugins to &runtimepath.
call plug#end()
" Arpeggio needs to be loaded as the init.vim is parsed so that
" it can be used for defining key mappings.
call arpeggio#load()

" Sets the molokai colorscheme without this line you get normal colors.
colorscheme molokai

" Standard vim settings.

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

" The cinoptions control indenting for c
" The option below makes indenting for arguments spread across many lines a
" single tab rather than a doble tab.
" see :help cino-(
set cinoptions=(1s
" This makes sure that there are x lines of context above/below point
" scrolled to, it helps to keep your eyes more central on the screen.
set scrolloff=8


" Standard vim key mappings.

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

" Provide some easy buffer switching
"nnoremap <C-n> :bnext<CR>
"nnoremap <C-m> :bprevious<CR>

" Navigate command line commands with j and k
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>

" I dont ever place marks so I use 'm' as the leader.
let mapleader = 'm'

" Allow easy editing of init.vim file.
nnoremap <leader>ve :vsplit $MYVIMRC<CR>
" Allow easy sourcing of init.vim file.
nnoremap <leader>vs :write $MYVIMRC<CR>:source $MYVIMRC<CR>

" Allow easy window opening.
nnoremap <leader>wh :Hexplore<CR>
nnoremap <leader>wv :Vexplore<CR>

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
" Allow easy terminal opening. In order to pass an expression to a command we
" need to use :execute.
"nnoremap <leader>th :split<CR>:terminal<CR>
"nnoremap <leader>tv :vsplit<CR>:terminal<CR>

nnoremap <leader>s :<C-u>write<CR>
nnoremap <leader>c :<C-u>quit<CR>
nnoremap <leader>C :<C-u>quit!<CR>
" :BD is provided by bufkill it deletes a buffer without closing the window.
nnoremap <leader>b :<C-u>BD<CR>
Arpeggio nnoremap fk :wincmd k <CR>
Arpeggio nnoremap fj :wincmd j <CR>
Arpeggio nnoremap fh :wincmd h <CR>
Arpeggio nnoremap fl :wincmd l <CR>
" Arpeggio standard vim key mappings.

" Map df to esc - no brainer.
Arpeggio inoremap df <esc>
" Map df to the equivalent of escape for commandline.
Arpeggio cnoremap df <C-c>
" Make esc in normal mode clear highlighting.
Arpeggio noremap <silent> df :<C-u>nohlsearch<CR><esc>
" Map fn to equivalient of escape in terminal mode. We can't map df here
" otherwise when we have vim inside a terminal in vim and we escape the df
" would escape the terminal rather than be passed to the vim inside the
" terminal. We alos add a search back to first line starting with a dollar
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

" As with esc we have to map fj instead of jk so that when using vim inside a
" terminal in vim we do not trigger the <CR>  of the terminal.
Arpeggio tnoremap fj <CR>

" Remove the original <CR> key functionality.
inoremap <CR> <NOP>
cnoremap <CR> <NOP>
tnoremap <CR> <NOP>

Arpeggio tnoremap <C-j> <down>
Arpeggio tnoremap <C-k> <up>


" make the jump to def (d for def) shortcut easier.
"nnoremap <buffer> <leader>d <C-]>

" make the return to start (r for return) shortcut easier.
"nnoremap <buffer> <leader>r <C-t>

" help mappings have to be set here otherwise overwritten with more buffer
" specific maps
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

" netrw mappings, this needs to be updated for terminal use, Explore expects
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

"easytags
" async means easytags does not block, only an issue if it takes a long time
"let g:easytags_async = 1
" autorecurse does as expected but really im using it as a workaraound for the
" failiure of "UpdateTags -R" to set the correct paths int the tags files.
" see - https://github.com/xolox/vim-easytags/issues/45
let g:easytags_autorecurse = 0
" easytags is not intuitive this function works around its surprises
function! UpdateTagsRecursive()
	:execute ":UpdateTags -R --tag-relative " expand('%:p:h')
endfunction


" fzf buffer switching
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <leader>f :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>

"ycm
let g:ycm_filetype_whitelist = {
			\ 'C' : 1,
			\ 'c' : 1,
			\ 'cpp' : 1,
			\ 'c++' : 1,
			\ 'cc' : 1,
			\ 'cxx' : 1,
            \ 'h' : 1,
            \ 'hpp' : 1,
            \}

"inoremap	\ pumvisible() ? "\<C-p>" : ":\<C-u>lprevious\<CR>"
"
"au Filetype cpp,c,h,hpp,c++ inoremap <buffer> <C-j> <C-n>
"au Filetype cpp,c,h,hpp,c++ inoremap <buffer> <C-k> <C-p>

" Strips trailing whitespace and makes sure the cursro returns to it's initial
" position.
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

augroup ycm_maps
	autocmd!
	autocmd filetype cpp,c,h,hpp,c++ call ApplyYcmMaps()
	" strip trailing whitespace on save
    "autocmd filetype cpp,c,h,hpp,c++ BufWritePre <buffer> * %s/\s\+$//e
	"autocmd filetype cpp,c,h,hpp,c++ autocmd BufWritePre <buffer> %s/\s\+$//e
	autocmd filetype cpp,c,h,hpp,c++ autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
augroup END

function! ApplyYcmMaps()
	nnoremap <buffer> <leader>t :<C-u>YcmCompleter GetType<CR>
	nnoremap <buffer> <leader>q :<C-u>YcmCompleter GetDoc<CR>
	nnoremap <buffer> <leader>f :<C-u>YcmCompleter FixIt<CR>
	nnoremap <buffer> <leader>i :<C-u>YcmCompleter GoToInclude<CR>
	nnoremap <buffer> <leader>g :<C-u>YcmDiags<CR>
	" Allow selecting autocomplete options with c-j and c-n for ycm.
	inoremap <buffer> <C-j> <C-n>
	inoremap <buffer> <C-k> <C-p>

	" Allow easy navigation of error locations
	nnoremap <buffer> <C-j> :<C-u>lnext<CR>
	nnoremap <buffer> <C-k> :<C-u>lprevious<CR>

	" make the jump to def (d for def) shortcut easier.
	nnoremap <buffer> <leader>d <C-]>

	" make the return to start (r for return) shortcut easier.
	nnoremap <buffer> <leader>r <C-t>
endfunction

augroup vimgo_maps
	autocmd!
	autocmd filetype go call ApplyVimGoMaps()
augroup END

function! ApplyVimGoMaps()
	" make the jump to def (d for def) shortcut easier.
	nnoremap <buffer> <leader>d :<C-u>GoDef<CR>

	" make the return to start (r for return) shortcut easier.
	nnoremap <buffer> <leader>r :<C-u>GoDefPop<CR>

	" Map K again in buffer specific mode since it is mapped by go
	" to get the doc.
	nnoremap <buffer> K <C-U>
endfunction

" fzf buffer switching
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <leader>l :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>


"rainbow parenthesis config
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
"let g:rbpt_colorpairs = [
"    \ ['brown',       'RoyalBlue3'],
"    \ ['Darkblue',    'SeaGreen3'],
"    \ ['darkgray',    'DarkOrchid3'],
"    \ ['darkgreen',   'firebrick3'],
"    \ ['darkcyan',    'RoyalBlue3'],
"    \ ['darkred',     'SeaGreen3'],
"    \ ['darkmagenta', 'DarkOrchid3'],
"    \ ['brown',       'firebrick3'],
"    \ ['gray',        'RoyalBlue3'],
"    \ ['black',       'SeaGreen3'],
"    \ ['darkmagenta', 'DarkOrchid3'],
"    \ ['Darkblue',    'firebrick3'],
"    \ ['darkgreen',   'RoyalBlue3'],
"    \ ['darkcyan',    'SeaGreen3'],
"    \ ['darkred',     'DarkOrchid3'],
"    \ ['red',         'firebrick3'],
"    \ ]

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadChevrons

