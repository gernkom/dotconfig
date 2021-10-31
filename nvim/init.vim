if &compatible
  set nocompatible
endif
set mouse-=a
set history=100
set ruler
set showcmd
set wildmenu
set ttimeout
set ttimeoutlen=100
set display=truncate
set scrolloff=7
set cc=80
set ts=3
set sw=3
set expandtab
set autoindent
if &term =~# '^screen'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[38;2;%lu;%lu;%lum"
endif
set number

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

augroup vimStartup
  au!
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ | exe "normal! g`\""
    \ | endif
augroup END

call plug#begin()
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'morhetz/gruvbox'
Plug 'rust-lang/rust.vim'
Plug 'vim-airline/vim-airline'
Plug 'cespare/vim-toml', { 'branch': 'main' }
call plug#end()

syntax enable
filetype plugin indent on

let g:gruvbox_contrast_dark='hard'
set bg=dark
if (empty($TMUX))
 if (has("nvim"))
   let $NVIM_TUI_ENABLE_TRUE_COLOR=1
 endif
 if (has("termguicolors"))
   set termguicolors
 endif
endif
autocmd vimenter * ++nested colorscheme gruvbox

