call plug#begin()

" Make sure you use single quotes
Plug 'tomasr/molokai'
Plug 'SirVer/ultisnips' , {'tag': '*' }
Plug 'scrooloose/nerdtree', {'tag': '*' } | Plug 'rking/ag.vim' | Plug 'taiansu/nerdtree-ag'
Plug 'fatih/vim-go', {'tag': '*' }
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' , 'for' : 'go' }
Plug 'kana/vim-arpeggio'
Plug 'easymotion/vim-easymotion', {'tag': '*' }
Plug 'Shougo/deoplete.nvim', {  'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'Valloric/YouCompleteMe', { 'for' : ['c', 'cpp'] }
" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" Add plugins to &runtimepath
call plug#end()

" better completion options for vim commands
set wildmode=longest,list,full
set wildmenu

" To disable a plugin, add it's bundle name to the following list
syntax on
filetype plugin indent on

" Set up shell indentation to not indent cases
if !exists("b:sh_indent_options")
  let b:sh_indent_options = {}
endif

let b:sh_indent_options['case-labels'] = 0

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

"This ensures that the contents of the clipboard are written to the system
"clipboard on leaving vim
autocmd VimLeave * call system("xsel -ib", getreg())
"Disable swap files they are annoying
set noswapfile
"Enable backup - they are useful
set backup
au BufWritePre * let &bex = '-' . strftime("%Y%m%d-%H%M%S") . '.vimbackup'
set backupdir=~/vimtmp,.


"Alter help so that it opens in a full window
command -nargs=1 -complete=help Help help <args> | only

" Setup the following abbreviations to use this approac for reliability
" :cabbrev e <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'E' : 'e')<CR>
cabbrev he Help
cabbrev hel Help
cabbrev help Help
set ruler              " show the cursor position all the time
set number             " line numbers
set relativenumber            " show relative numbers
set showcmd
set incsearch
set hlsearch
"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden
"Stops auto indentation when psting code but also breaks command mappings and
"insert mappings - dont use it!i!!!!
"set paste
"This causes the vim yank/paste to use the X11 copy paste buffer
set clipboard=unnamedplus
"Set tabs to be tabs and set vim to add them automatically while inserting text
set tabstop=4
set shiftwidth=4
set noexpandtab
"this makes sure that there are x lines of context above/below point scrolled to
set scrolloff=8

"statusline
set laststatus=2        "always show the statusline
set statusline=%F       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

" This sets the textwidth automatically for markdown files (README.md)
au BufRead,BufNewFile *.md setlocal textwidth=80

"Ensure quickfix always open at always bottom
autocmd FileType qf wincmd J
"pgup / pgdown move too far to track text easily but ctrl-d and ctrl-u are hard to reach and not comfy
map <PageUp> <C-U>
map <PageDown> <C-D>
nnoremap <C-H> :<C-U>bp<CR>
nnoremap <C-L> :<C-U>bn<CR>
" Easier navigating quickfix
nnoremap <C-n> :cnext<CR>
nnoremap <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

"Align by columns
command Column %!column -t

"load arpeggio
call arpeggio#load()
let g:arpeggio_timeoutlen=100
" having colon is a pain in the arse for most ex commands so use semicolon
nnoremap : ;
vnoremap : ;
nnoremap ; :
vnoremap ; :
Arpeggio inoremap df  <Esc>
"Not really sure that this is necessary in
"since i only go into visual to do specific things
"and those thing end with a yank paste or insert which exits visual
"Arpeggio vnoremap df  <Esc>
Arpeggio cnoremap df  <C-c>
Arpeggio inoremap DF  <Esc>
"Arpeggio vnoremap DF  <Esc>
Arpeggio cnoremap DF  <C-c>
nnoremap <Plug>(arpeggio-default:d) d
nnoremap <Plug>(arpeggio-default:f) f
Arpeggio inoremap jk  <Cr>
Arpeggio cnoremap jk  <Cr>
Arpeggio nnoremap jk  <Cr>
Arpeggio nmap lk 15k
Arpeggio nmap ds 15j



" Dont do this it causes a lot of issues as many keys have esc as part of their key codes
"noremap <Esc> :wincmd w<CR>
" Removing this and replacing with clearer commandss
" Arpeggio nnoremap df :wincmd w <CR> 
" Map the row above hjkl to window movement commands
Arpeggio nnoremap fk :wincmd k <CR> 
Arpeggio nnoremap fj :wincmd j <CR> 
Arpeggio nnoremap fh :wincmd h <CR> 
Arpeggio nnoremap fl :wincmd l <CR> 
Arpeggio nnoremap fm :close <CR> 

"Easymotion mappings
"It seems that we need to use recursive mappins for easymotion commands
"nonrecursive mappings have no effect
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Set keys for easymotion to use for jump targets
let g:EasyMotion_keys = 'abcdefghipqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,.§'
let g:EasyMotion_smartcase = 1
" we need to map s in this way to avoid a clash with ds
nmap <Plug>(arpeggio-default:s) <Plug>(easymotion-s)
"vmap <Plug>(arpeggio-default:s) <Plug>(easymotion-s)
"Map bi directional line motion
Arpeggio nmap fu <Plug>(easymotion-j)
Arpeggio vmap fu <Plug>(easymotion-j)
Arpeggio nmap fi <Plug>(easymotion-k)
Arpeggio vmap fi <Plug>(easymotion-k)
" This means that easymotion jk will stay in current column
let g:EasyMotion_startofline = 0
vmap s <Plug>(easymotion-s)
"End
"

" Open nerd tree if no file
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
noremap <F5> :NERDTreeToggle<CR>
noremap <F6> :NERDTreeFind<CR>


"Got to set this leader before trying to reference <Leader> anywhere
let mapleader = "," 
nmap <Leader>x :<C-u>Explore<CR>
" Golang
" for filetypes matching go set these commands
"au FileType go nmap <F5> :%!goimports<CR>:%!gofmt<CR>
" the <Leader> actually just resolves to the mapleader variable set earlier
"
au FileType go nmap <Leader>d <Plug>(go-doc)
au FileType go nmap <leader>s <Plug>(go-implements)
au Filetype go nmap <leader>i <Plug>(go-info)
au Filetype go nmap <leader>e <Plug>(go-rename)
au Filetype go nmap <Leader>c <Plug>(go-referrers)
au FileType go nmap <leader>o <Plug>(go-coverage)
au FileType go nmap md <Plug>(go-def)
au FileType go noremap <leader>b :w<bar>GoInstall <Cr>
au FileType go noremap <leader>v :w<bar>GoVet <Cr>
au FileType go noremap <Leader>r :w<bar>GoRun<CR>
au FileType go noremap <leader>t :w<bar>GoTest<CR>
au FileType go Arpeggionnoremap ui :w<bar>GoInstall <Cr>
au FileType go noremap <F7> :TagbarToggle<CR>
let g:go_fmt_command = "goimports"
"Set type info for word under cursor to automatically display
let g:go_auto_type_info = 1
let g:go_list_type = "quickfix"
" End

" Colors
colorscheme molokai
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
" End
"
" deoplete config
" This stops deoplete from selecting the first option in the list
" automatically.
set completeopt+=noinsert,menuone
" enable deoplete
let g:deoplete#enable_at_startup = 1
" disable auto popup menu
let g:deoplete#disable_auto_complete = 1
" bind complete to ctrl space. This binding looks simpler than the example
" given by shougo in his deoplete documentation, this  is because he is
" binding TAB which he wishes to behave as TAB if there is nothing to complete
" under the cursor. Note the triple braces are for folding markers for vim.;
"   	inoremap <silent><expr> <TAB>
"   	\ pumvisible() ? "\<C-n>" :
"   	\ <SID>check_back_space() ? "\<TAB>" :
"   	\ deoplete#mappings#manual_complete()
"   	function! s:check_back_space() abort "{{{
"   	let col = col('.') - 1
"   	return !col || getline('.')[col - 1]  =~ '\s'
"   	endfunction"}}}
if has("gui_running")
    inoremap <silent><expr> <Nul> deoplete#mappings#manual_complete()
else
    inoremap <silent><expr> <C-@> deoplete#mappings#manual_complete()
endif

"Close easily
autocmd BufEnter * call CloseVimWhenEditableFilesClosed()
function! CloseVimWhenEditableFilesClosed()
    "echom "BufEnterBegin"
    let windows = winnr('$')
    " more than just nerd tree and quickfix open so return
    if windows > 2
        return
    endif
    let i = 1
    while i <= windows
        "echom "". i .": buftype'". getbufvar(winbufnr(i), '&buftype')."'"
        if getbufvar(winbufnr(i), '&buftype') == ''
            "this is an editable buffer so return
            "echom "BufEnterEnd"
            return
        endif
        let i += 1
    endwhile
    "all buffers uneditable so close
    "echom "BufEnterEnd"
    qa
endfunction

"Add mapping to make ctrl space go to next completion option
"<Nul> is interpreted as ctrl-space
"inoremap <Nul> <C-n>
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>
"Ensure that neopairs is adding parenthesis for methods
"call deoplete#custom#set('_', 'converters', ['converter_auto_paren']) "It
"turns out that neopairs parenthesis is kindk of annoying, doesn't work like
"intellij
"utilsnips
let g:UltiSnipsSnippetDirectories=["bundle/vim-go/gosnippets/UtilSnips"]
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.

" If you want :UltiSnipsEdit to split your window.
inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"Neovim likes this here
set spell spelllang=en_gb


"Rainbow parenthesis
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


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

"au BufRead,BufNewFile *.c,*.cpp,*.h,*.hpp,*.h++ set filetype=c
au FileType cpp nnoremap <Leader>d :<C-u>YcmCompleter GetDoc<CR>
au FileType cpp nnoremap md :<C-u>YcmCompleter GoTo<CR>
au FileType cpp nnoremap mh :<C-u>YcmCompleter GoToInclude<CR>
au Filetype cpp nnoremap <leader>t :<C-u>YcmCompleter GetType<CR>



