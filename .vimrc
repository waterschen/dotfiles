"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Brief:
"
" Section #1 ~#7 are basic configs and no plugins are required.
" Section #8 includes my favorite plugins. I use [vim-plug]
" (https://github.com/junegunn/vim-plug) to install them.
"
" Qinshui Chen<qinshui.c@gmail.com>
" 2019-06-04
"
" Sections:
"
" #1 General
" #2 Languages and files
" #3 Appearance
" #4 Editing
" #5 Searching
" #6 Moving around, windows, tabs and buffers
" #7 Helper functions
" #8 Plugins
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #1 General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" How many lines of history to remember
set history=700

" Map leader for extra key combinations
let mapleader=","
let g:mapleader=","

" Change directory to the open buffer's
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" quit vim
noremap <leader>q :q<cr>
noremap <leader>x :wq<cr>

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" No redraw when executing macros
set lazyredraw 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #2 Languages and files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Standard encoding and language
set encoding=utf8
let $LANG='en' 
set langmenu=en

" Avoid garbled characters in Chinese language
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" Enable filetype plugins
filetype plugin on
filetype indent on

" automatically show type info at the interval of 100ms
let g:go_auto_type_info = 1
set updatetime=100

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

" Turn backup off
set nobackup
set nowb
set noswapfile
set autowrite


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #3 Appearance
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable    " Enable syntax highlighting

set so=7         " 7 lines to the cursor
set cmdheight=2  " Height of the command bar

set ruler        " Always show current position
set number       " Always show line number

set foldcolumn=1 " Extra margin to the left

set showmatch    " Highlight matching brackets
set matchtime=5  " How long showing matching brackets (1/10 second)

" Linebreak on 500 characters
set lbr
set tw=500

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set background=light
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Show wildmenu when <tab> completing
set wildmenu 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #4 Editing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto read when a file is changed from the outside
set autoread

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saving, useful for handling the permission-denied error
"command W w !sudo tee % > /dev/null

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

set expandtab    " Use spaces instead of tabs
set smarttab     " Be smart when using tabs ;)
set shiftwidth=4 " 4 spaces for 1 tab
set tabstop=4

" 2-space tab for YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

set ai           " Auto indent
set si           " Smart indent
set wrap         " Wrap lines

" Wrap a word with double/single quotes or <space>
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
nnoremap <leader><space> viw<esc>a<space><esc>hbi<space><esc>lel

" Remove the Windows ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" C11 syntax support
au BufNewFile,BufRead *.cpp set syntax=cpp11
setlocal cindent cino=j1,(0,ws,Ws


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #5 Searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Press <space> or ctrl-<space> to search/backward-search
map <space> /
map <c-space> ?

set ignorecase " Ignore case when searching
set smartcase  " Be smart about cases when searching
set hlsearch   " Highlight search results
set incsearch  " Makes search act like search in modern browsers
set magic      " For regular expressions turn magic on

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #6 Moving around, windows, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines, useful when moving around in them
map j gj
map k gk

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \     exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" Moving between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

map <leader>bd :Bclose<cr>     " Close the current buffer
map <leader>ba :1,1000 bd!<cr> " Close all the buffers

" Press F4 to list buffers and type a number to open the choosed one
nnoremap <F4> :buffers<CR>:buffer<Space>

" Specify the behavior when switching between buffers 
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" A buffer becomes hidden when it is abandoned
set hid

" Jump between locations
function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction
nmap <Leader>jj :call GotoJump()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #7 Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("Ack \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction
augroup filetype
    autocmd! BufRead,BufNewFile BUILD set filetype=blade
augroup end


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #8 Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'haya14busa/incsearch.vim'
Plug 'junegunn/vim-easy-align'
Plug 'majutsushi/tagbar'
Plug 'micbou/a.vim'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'valloric/youcompleteme'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

" => airline-theme
let g:airline_powerline_fonts = 1
let g:airline_theme           = 'badwolf'

" => colorscheme
colorscheme gruvbox
hi Normal ctermbg=none

" => easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase  = 1
nmap s <Plug>(easymotion-overwin-f)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" => vim-gitgutter
set updatetime=100
let g:gitgutter_enabled = 0
nnoremap <silent> <leader>d :GitGutterToggle<cr>

" => nerdtree
let g:NERDTreeWinPos   = "left"
let NERDTreeShowHidden = 0
let NERDTreeIgnore     = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize  = 35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

" => tagbar
nmap <F8> :TagbarToggle<CR>

" => a.vim
" Plug 'vim-scripts/a.vim' comflicts with YouCompleteMe and cases an error of
" `UltiSnips#SnippetsInCurrentScope( 1 )`, use 'micbou/a.vim' instead.
" Refer to: https://github.com/Valloric/YouCompleteMe/issues/2791
map <leader>a :A<cr>

" => vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" => vim-commentary
" Use `gc` to comment/uncomment selected code lines.
autocmd FileType c,cpp,java setlocal commentstring=//\ %s

" => youcompleteme
" ./install.py --clang-completer --go-completer
let g:ycm_confirm_extra_conf         = 0
let g:ycm_add_preview_to_completeopt = 0
set completeopt-=preview

" => fzf
nmap <C-p> :Files<CR>
nmap <C-e> :Buffers<CR>
let g:fzf_action = { 'ctrl-e': 'edit' }

" => vim-go
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
"nnoremap <leader>a :cclose<CR>
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
"let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
"let g:go_metalinter_autosave = 1
"let g:go_metalinter_deadline = "5s"
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
autocmd FileType go nmap <Leader>i <Plug>(go-info)
autocmd FileType go nmap<Leader>d <Plug>(go-def)
let g:go_auto_sameids = 1
