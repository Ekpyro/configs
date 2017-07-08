" ##############################################################################
" NeoVIM general config
" ##############################################################################

set nocompatible

set clipboard=unnamedplus

" Use aliases
let $BASH_ENV = "~/.bash_aliases"

" Set to auto read when a file is changed from the outside
set autoread

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" Cue the magic (regex)
set magic

" Buffers can be hidden (not have to explicitly write, etc...)
set hidden

" Shhh
set visualbell
set noerrorbells

" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on

" Set 5 lines - when moving vertically using j/k
set so=5

" Turn on the WiLd menu (vim cmd auto-complete w/ tab)
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*dist/*,*tmp/*,*build/*,*.DS_Store

" Always show current position
set ruler

" Title terminal with name of file
set title

" Set line num
set number

" Height of the command bar
set cmdheight=1

" Be careful, and you can avoid this backup annoyingness
set nobackup
set nowb
set noswapfile

" Show matching brackets
set showmatch
set mat=2 " tenths of seconds

" Use Unix as the standard file type
set ffs=unix,dos,mac

set diffopt+=vertical

" Disable python 2 support
let g:loaded_python_provider = 1

" ##############################################################################
" Plugins
" ##############################################################################

call plug#begin('~/.nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'idanarye/vim-merginal'
Plug 'benekastah/neomake'
" Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'svermeulen/vim-easyclip'
Plug 'jpalardy/vim-slime'
Plug 'rking/ag.vim'
Plug 'hynek/vim-python-pep8-indent'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Raimondi/delimitMate'
" Plug 'davidhalter/jedi-vim'
Plug 'walkermatt/vim-mapfile'
Plug 'rodjek/vim-puppet'
Plug 'godlygeek/tabular'
Plug 'tell-k/vim-autopep8'
Plug 'vim-scripts/paredit.vim'
Plug 'honza/vim-snippets'
Plug 'bfredl/nvim-ipy'
Plug 'neilagabriel/vim-geeknote'
Plug 'vim-scripts/Solarized'
Plug 'benjie/neomake-local-eslint.vim'
Plug 'leafgarland/typescript-vim'
Plug 'Rykka/riv.vim'
Plug 'Rykka/InstantRst'
Plug 'JamshedVesuna/vim-markdown-preview'
call plug#end()

let g:slime_target = "tmux"

let g:tex_flavor='latex'

let g:neomake_open_list = 2

let g:gitgutter_realtime = 1
" let g:gitgutter_override_sign_column_highlight = 0
" highlight SignColumn ctermbg=002831 " terminal Vim
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green guifg=darkgreen
highlight GitGutterChange ctermfg=yellow guifg=darkyellow
highlight GitGutterDelete ctermfg=red guifg=darkred
highlight GitGutterChangeDelete ctermfg=yellow guifg=darkyellow

let g:jsx_ext_required = 0

let g:SuperTabDefaultCompletionType = "context"
let g:jedi#popup_on_dot = 0

nnoremap <F3> :Gstatus<CR>
nnoremap <F4> :MerginalToggle<CR>
nnoremap <c-p> :FZF<CR>

let notes = { 'Name': 'Notes', 'path': '~/drive/notes',}
let g:riv_projects = [notes]

let vim_markdown_preview_toggle=2
let vim_markdown_preview_github=1
let vim_markdown_preview_hotkey='<c-m>'
let vim_markdown_preview_hotkey='<c-m>'
let vim_markdown_preview_browser='Google Chrome'

let g:EasyClipUseSubstituteDefaults = 1

" ##############################################################################
" Filetype
" ##############################################################################

au BufRead,BufNewFile *.map,*.sym set filetype=mapfile

noremap <F8> :Geeknote<cr>

nnoremap <c-p> :FZF<CR>

" ##############################################################################
" Look
" ##############################################################################

syntax enable
set foldmethod=syntax
set foldlevel=99

set background=dark
colorscheme delek

" Allows transparent background
hi Normal ctermbg=none

" Folding
syntax enable
set foldmethod=syntax
set foldlevel=99
hi Folded ctermfg=250
hi Folded ctermbg=236

" Statusline
set laststatus=2
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ Col:\ %c
set statusline+=\ %{fugitive#statusline()}
set statusline+=\ %#warningmsg#
set statusline+=\ %*

function! MyFoldText()
    let line = getline(v:foldstart)
    return '↸ ' . line
endfunction

set foldtext=MyFoldText()

" ##############################################################################
" Search related
" ##############################################################################

set grepprg=grep\ -nH\ $*

" Ignore case when searching
set ignorecase
" all lower -> insensitive, any upper -> sensitive
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" allows incsearch highlighting for range commands
cnoremap $t <CR>:t''<CR>
cnoremap $T <CR>:T''<CR>
cnoremap $m <CR>:m''<CR>
cnoremap $M <CR>:M''<CR>
cnoremap $d <CR>:d<CR>``

" Rework location list navigation to iterate through list and wrap
function! <SID>LocationPrevious()
  try
    lprev
  catch /^Vim\%((\a\+)\)\=:E553/
    llast
  endtry
endfunction

function! <SID>LocationNext()
  try
    lnext
  catch /^Vim\%((\a\+)\)\=:E553/
    lfirst
  endtry
endfunction

nnoremap <silent> <Plug>LocationPrevious :<C-u>exe 'call <SID>LocationPrevious()'<CR>
nnoremap <silent> <Plug>LocationNext :<C-u>exe 'call <SID>LocationNext()'<CR>
nmap <silent> ,, <Plug>LocationPrevious
nmap <silent> '' <Plug>LocationNext

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
" NOT WORKING - just leaves v?

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction



" ##############################################################################
" Tab behavior
" ##############################################################################

" Use spaces instead of tabs
set expandtab
" 1 tab == 4 spaces
set shiftwidth=4
set softtabstop=4
filetype indent on
set autoindent " Basic auto-indent


" ##############################################################################
" Wrapping
" ##############################################################################

set wrap
set linebreak "Only at linebreak
set nolist  " list disables linebreak
set textwidth=100
set wrapmargin=0


" ##############################################################################
" Key binds
" ##############################################################################

let mapleader=","
let g:mapleader = "," " Global?

" Search, backward search
map <space> /
map <c-space> ?
set pastetoggle=<F2>

" " Ctrl movement keys moves around splits (uneeded with vim-tmux-navigator
map <c-l> <c-w>l
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k

" Disable arrows, must not show weakness
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Swap ; and :  Convenient.
nnoremap ; :
nnoremap : ;

" remap jj to escape in insert mode
inoremap jj <Esc>

" This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" And commands can wrap
set whichwrap+=<,>,h,l

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" ##############################################################################
" Auto commands
" ##############################################################################

" When vimrc is edited, reload it
autocmd! bufwritepost init.vim source %

" Trim whitespace, uh, comment out if estoteric programming...
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

" If you weren't using syntastic...for some reason
"autocmd BufWritePost *.py call Flake8()

" Tab behavior for filetypes
autocmd FileType html,htmldjango,xml,javascript,yaml,css setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Auto save on text changes
" autocmd InsertLeave * if expand('%') != '' | update | endif

" Check syntax on write
autocmd! BufWritePost * Neomake
