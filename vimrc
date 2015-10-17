" ========================================================================
" Vundle stuff
" ========================================================================
set nocompatible " Required by vundle
filetype off     " Required by vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" My bundles
Plugin 'ervandew/supertab'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tomtom/tcomment_vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-ruby/vim-ruby'
Plugin 'wincent/Command-T'

" Colors
Plugin 'nanotech/jellybeans.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Use the colorscheme from above
colorscheme jellybeans

" ========================================================================
" Ruby stuff
" ========================================================================
syntax on                 " Enable syntax highlighting

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml setlocal ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml setlocal path+=lib
  autocmd FileType ruby,eruby,yaml setlocal colorcolumn=80
  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?
augroup END

" Enable built-in matchit plugin
runtime macros/matchit.vim
" ================

let mapleader = ","

map <Leader>h :CommandT<CR>
map <Leader>rd :!bundle exec rspec % --format documentation<CR>
map <Leader>rf :CommandTFlush<CR>:CommandT<CR>
map <Leader>t :w<cr>:call RunCurrentSpecFile()<CR>

" Emacs-like beginning and end of line.
imap <c-e> <c-o>$
imap <c-a> <c-o>^

set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=500		" keep 500 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set autoindent
set showmatch
set nowrap
set backupdir=~/.tmp
set directory=~/.tmp " Don't clutter my dirs up with swp and tmp files
set autoread
set wmh=0
set viminfo+=!
set guioptions-=T
set guifont=Triskweline_10:h10
set et
set sw=2
set smarttab
set noincsearch
set ignorecase smartcase
set laststatus=2  " Always show status line.
set relativenumber
set gdefault " assume the /g flag on :s substitutions to replace all matches in a line
set autoindent " always set autoindenting on
set bg=light

" Set the tag file search order
set tags=./tags;

" Use _ as a word-separator
" set iskeyword-=_

" Use Silver Searcher instead of grep
set grepprg=ag

" Make the omnicomplete text readable
:highlight PmenuSel ctermfg=black

" Fuzzy finder: ignore stuff that can't be opened, and generated files
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"

" Highlight the status line
highlight StatusLine ctermfg=blue ctermbg=yellow

" Format xml files
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.

set nofoldenable " Say no to code folding...

command! Q q " Bind :Q to :q
command! Qall qall
command! QA qall
command! E e


" Disable Ex mode
map Q <Nop>

" Disable K looking stuff up
map K <Nop>

au BufNewFile,BufRead *.txt setlocal nolist " Don't display whitespace

" Better? completion on command line
set wildmenu
" What to do when I press 'wildchar'. Worth tweaking to see what feels right.
set wildmode=list:full

" (Hopefully) removes the delay when hitting esc in insert mode
set noesckeys
set ttimeout
set ttimeoutlen=1

" Turn on spell-checking in markdown and text.
" au BufRead,BufNewFile *.md,*.txt setlocal spell

" Merge a tab into a split in the previous window
function! MergeTabs()
  if tabpagenr() == 1
    return
  endif
  let bufferName = bufname("%")
  if tabpagenr("$") == tabpagenr()
    close!
  else
    close!
    tabprev
  endif
  split
  execute "buffer " . bufferName
endfunction

nmap <C-W>u :call MergeTabs()<CR>


" Squash all commits into the first during rebase
function! SquashAll()
  normal ggj}klllcf:w
endfunction


function! SearchForCallSitesCursor()
  let searchTerm = expand("<cword>")
  call SearchForCallSites(searchTerm)
endfunction

" Search for call sites for term (excluding its definition) and
" load into the quickfix list.
function! SearchForCallSites(term)
  cexpr system('ag ' . shellescape(a:term) . '\| grep -v def')
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Test-running stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Now using thoughtbot/vim-rspec and tpope/dispatch.

let g:rspec_command = "Dispatch rspec {spec}"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

inoremap <Tab> <C-P>

" Let's be reasonable, shall we?
nmap k gk
nmap j gj

let g:CommandTMaxHeight=50
let g:CommandTMatchWindowAtTop=1

" Don't wait so long for the next keypress (particularly in ambigious Leader
" situations.
set timeoutlen=500

" Remove trailing whitespace on save for ruby files.
au BufWritePre *.rb :%s/\s\+$//e

function! OpenFactoryFile()
  if filereadable("test/factories.rb")
    execute ":sp test/factories.rb"
  else
    execute ":sp spec/factories.rb"
  end
endfunction

" Set gutter background to black
highlight SignColumn ctermbg=black

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE (thanks Gary Bernhardt)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <Leader>n :call RenameFile()<cr>

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Make it more obvious which paren I'm on
hi MatchParen cterm=none ctermbg=black ctermfg=yellow

" By default, vim thinks .md is Modula-2.
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Wrap the quickfix window
autocmd FileType qf setlocal wrap linebreak

" ========================================================================
" End of things set by me.
" ========================================================================

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

endif " has("autocmd")
