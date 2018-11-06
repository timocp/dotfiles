set nocompatible

" Plugins
" -------
" https://github.com/junegunn/vim-plug
" run :PlugInstall when making changes

call plug#begin()

Plug 'airblade/vim-gitgutter'       " show +/-/~ in gutter
Plug 'fatih/vim-go'                 " Go development
Plug 'fenetikm/falcon'
Plug 'Quramy/vim-js-pretty-template'
Plug 'scrooloose/nerdcommenter'     " comment functions (,cc ,cu)
Plug 'Shougo/neosnippet-snippets'   " large collection of snippets
Plug 'Shougo/neosnippet.vim'        " snippets
Plug 'tpope/vim-commentary'         " comments
Plug 'tpope/vim-fugitive'           " Git
Plug 'tpope/vim-rails'              " Ruby on rails editing
Plug 'tpope/vim-surround'           " surrounding text
Plug 'vim-airline/vim-airline'      " fancy statusline
Plug 'w0rp/ale'                     " async lint engine

if has('nvim')
    "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'sebdah/vim-delve'
    "Plug 'zchee/deoplete-go', { 'do': 'make' }
endif

if isdirectory($HOME . '/.fzf')
    " fzf instead of ctrlp
    Plug 'junegunn/fzf.vim'
    set rtp+=~/.fzf
    nmap <C-P> :FZF<CR>
else
    Plug 'kien/ctrlp.vim'               " fuzzy path/buffer/tag finder
endif

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
highlight ColorColumn ctermbg=darkblue guibg=darkblue

" Always syntax highlight
syntax on

" Override falcon for some small things
highlight Comment gui=italic

" F2 opens explorer
" F3 split-opens explorer
nmap <F2> :Explore<CR>
nmap <F3> :Sexplore<CR>
" ; Open buffers list
nmap ; :Buffers<CR>

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

if has('nvim')
    " ESC escapes terminal mode; ALT-hjkl navigate in all modes
    " (from :h terminal)
    :tnoremap <Esc> <C-\><C-n>
    :tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
    :tnoremap <A-h> <C-\><C-N><C-w>h
    :tnoremap <A-j> <C-\><C-N><C-w>j
    :tnoremap <A-k> <C-\><C-N><C-w>k
    :tnoremap <A-l> <C-\><C-N><C-w>l
    :inoremap <A-h> <C-\><C-N><C-w>h
    :inoremap <A-j> <C-\><C-N><C-w>j
    :inoremap <A-k> <C-\><C-N><C-w>k
    :inoremap <A-l> <C-\><C-N><C-w>l
    :nnoremap <A-h> <C-w>h
    :nnoremap <A-j> <C-w>j
    :nnoremap <A-k> <C-w>k
    :nnoremap <A-l> <C-w>l
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

" use netrw tree style listing
let g:netrw_liststyle=3

" ale config
" -----------
" https://github.com/w0rp/ale

" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#branch#displayed_head_limit = 20

let g:ale_sign_column_always = 1
map <Leader>n <Plug>(ale_next_wrap)
map <Leader>p <Plug>(ale_previous_wrap)

" F9 to toggle linting
nmap <F9> :ALEToggle<cr>

" Default highlight is unlegible, and I don't like falcon's underlines
highlight ALEWarning ctermbg=DarkBlue guibg=#330000
highlight ALEError ctermbg=DarkBlue guibg=#660000

" fixers
let g:ale_linters = {
\ 'javascript': ['standard'],
\}
let g:ale_fixers = {
\ 'javascript': ['standard'],
\ 'ruby': ['rubocop'],
\}
nmap <F8> <Plug>(ale_fix)

" deoplete config
let g:deoplete#enable_at_startup = 1

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
au FileType go nmap <F7> :GoCoverageToggle<cr>

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

" Language: Javascript
au FileType javascript set sts=2 sw=2

" Language: Perl
au FileType perl set sts=2 sw=2

" Language: Ruby
" --------------
au FileType ruby set sts=2 sw=2
au FileType eruby set sts=2 sw=2

" Language: YAML
" --------------
au FileType yaml set sts=2 sw=2

" Load all plugins now
packloadall
" Load all helptags now, after plugins have been loaded
silent! helptags ALL
