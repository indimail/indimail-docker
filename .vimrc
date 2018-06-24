set nocompatible
set backspace=indent,eol,start
set history=0
set history=80
set showcmd
set incsearch
set showmatch
set nowrap
set sidescroll=1
set ts=4
set shiftwidth=4
set beautify
set remap
set ruler
set wrapscan
set uc=0
set nobackup
set fileformat=unix
set undolevels=5
map #1 :x
map #2 Ji-llxxJI	
map #3 I/*- A -*/
map #4 ^4x$xxxx
map #5 :w
map #6 cw	/*-A -*/
set cindent
set cinoptions=>2s,e4,n4,f0,{0,}0,^0,:s,=s,ps,ts,c3,+s,(2s,us,)20,*30,gs,hs
set autoindent
set smartindent
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
  augroup END
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")
