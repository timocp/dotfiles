set nocompatible

" Plugins
" -------
" https://github.com/junegunn/vim-plug
" run :PlugInstall when making changes

call plug#begin()
Plug 'w0rp/ale'             " async lint engine
Plug 'kien/ctrlp.vim'       " fuzzy path/buffer/tag finder
Plug 'fatih/vim-go'         " Go development
Plug 'tpope/vim-fugitive'   " Git
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'zchee/deoplete-go', { 'do': 'make' }
    let g:deoplete#enable_at_startup = 1
    Plug 'sebdah/vim-delve'     " go debugger
endif
Plug 'Shougo/neosnippet.vim'        " snippets
Plug 'Shougo/neosnippet-snippets'   " large collection of snippets
Plug 'airblade/vim-gitgutter'       " show +/-/~ in gutter
Plug 'scrooloose/nerdcommenter'     " comment functions (,cc ,cu)
Plug 'vim-airline/vim-airline'      " fancy statusline
call plug#end()

" Preferred options
" -----------------
set autoindent
set background=dark
set backspace=2
set backup
set backupdir=~/.vim/backup
set cmdheight=2
set comments&
set directory=~/.vim/swap
set display+=lastline
set errorbells
set expandtab
set formatoptions=tcql
set hlsearch
set ignorecase
set incsearch
set joinspaces
set laststatus=2
set nocindent
set nostartofline
set number
set ruler
set scrolloff=3
set shiftwidth=4
set shortmess=aI
set showmatch
set smartindent
set softtabstop=4
set splitbelow
set viminfo='20,\"50
set visualbell
set wildmenu
set wildmode=longest,list

" More subtle color column
set colorcolumn=80
highlight ColorColumn ctermbg=darkblue guibg=black

" Always syntax highlight
syntax on

" misc
" ----

if has('mouse')
    " enable mouse in all modes
    set mouse=a
endif

if has('nvim')
    " enable interactive search and replace
    set inccommand=split
endif

" use comma as leader
let mapleader = ","

" remove trailing writespace on :w
au BufWritePre * :%s/\s\+$//e

" wrap text
map Q gq

" change to the directory containing current file
com! CD cd %:p:h

" use <C-L> to turn off set highlights
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" reload vimrc file
map <Leader>~ :source ~/.vimrc<CR>

" ale config
" -----------
" https://github.com/w0rp/ale

" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

let g:ale_sign_column_always = 1
map <Leader>n <Plug>(ale_next_wrap)
map <Leader>p <Plug>(ale_previous_wrap)

" Snippet config (using neosnippet)
" --------------
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" Language: C
" -----------
au FileType c set sts=4 sw=4

" Language: Git commits
" ---------------------
au FileType gitcommit setlocal spell
au FileType gitcommit setlocal textwidth=80

" Language: Go
" ------------
" ref: https://hackernoon.com/my-neovim-setup-for-go-7f7b6e805876
au FileType go set noexpandtab shiftwidth=4 softtabstop=4 tabstop=4
au FileType go nmap <Leader>gt :GoDeclsDir<cr>
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

" commands for junmping to corresponding test ("alternate")
au FileType go nmap <Leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <Leader>gah <Plug>(go-alternate-split)

" Toggle view of test coverage
au FileType go nmap <F9> :GoCoverageToggle<cr>

" run test for this file
au FileType go nmap <F10> :GoTest<cr>

if has('nvim')
    let g:go_auto_sameids = 0
    let g:go_auto_type_info = 1
endi

" use goimports to add/remove imports automatically
let g:go_fmt_command = "goimports"

" use neosnippet for vim-go
let g:go_snippet_engine = "neosnippet"

" Language: Perl
au FileType perl set sts=2 sw=2

" Language: Ruby
" --------------
au FileType ruby set sts=2 sw=2

" Load all plugins now
packloadall
" Load all helptags now, after plugins have been loaded
silent! helptags ALL
