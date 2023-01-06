set nocompatible

" Plugins
" -------
" https://github.com/junegunn/vim-plug
" run :PlugInstall when making changes

call plug#begin()

Plug 'Asheq/close-buffers.vim'
Plug 'Quramy/vim-js-pretty-template'
Plug 'Shougo/neosnippet-snippets'   " large collection of snippets
Plug 'Shougo/neosnippet.vim'        " snippets
Plug 'dag/vim-fish'
Plug 'fatih/vim-go'                 " Go development
Plug 'fenetikm/falcon'
Plug 'knsh14/vim-github-link'
Plug 'mhinz/vim-grepper'
Plug 'mhinz/vim-signify'            " vcs changes in gutter
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdcommenter'     " comment functions (,cc ,cu)
Plug 'tpope/vim-commentary'         " comments
Plug 'tpope/vim-fugitive'           " Git
Plug 'tpope/vim-rails'              " Ruby on rails editing
Plug 'tpope/vim-surround'           " surrounding text
Plug 'vim-airline/vim-airline'      " fancy statusline
Plug 'w0rp/ale'                     " async lint engine

if has('nvim')
    Plug 'sebdah/vim-delve'
    Plug 'neovim/nvim-lspconfig'
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
set signcolumn=yes
set smartindent
set softtabstop=4
set splitbelow
set termguicolors
set viminfo='20,\"50
set visualbell
set wildmenu
set wildmode=longest,list

" More subtle color column
set colorcolumn=80,120
highlight ColorColumn ctermbg=darkblue guibg=darkblue

" Always syntax highlight
syntax on

" Override falcon for some small things
colorscheme falcon
"highlight Comment gui=italic

" F2 opens explorer
" F3 split-opens explorer
nmap <F2> :Explore<CR>
nmap <F3> :Sexplore<CR>
" ; Open buffers list
nmap ; :Buffers<CR>

" Open gitk on the current file
nmap <F6> :exe "!gitk " . shellescape(expand("%")) . " &"<CR>

" don't ask
nmap <F12> :!pkill -9 ruby2.4<CR>

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
au BufWritePre *.rb,*.erb :%s/\s\+$//e

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

" split into a git blame
map <Leader>b :Git blame<CR>

" close hidden buffers
map <Leader>h :Bdelete hidden<CR>

" use netrw tree style listing
let g:netrw_liststyle=3

" delete hidden netrw buffers
autocmd FileType netrw setl bufhidden=delete

" ale config
" -----------
" https://github.com/w0rp/ale

" aliases by filetype (TODO: not working?)
let g:ale_linter_alias = {
    \ 'xsd': ['xml'],
    \ 'xslt': ['xml']
    \ }

" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#branch#displayed_head_limit = 20

let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_eruby_ruumba_executable = 'bundle'

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
\ 'javascript': ['eslint'],
\}
let g:ale_fixers = {
\ 'javascript': ['eslint'],
\ 'ruby': ['rubocop'],
\}
nmap <F8> <Plug>(ale_fix)

" deoplete config
let g:deoplete#enable_at_startup = 1

" Snippet config (using neosnippet)
" --------------
" imap <C-k> <Plug>(neosnippet_expand_or_jump)
" smap <C-k> <Plug>(neosnippet_expand_or_jump)
" xmap <C-k> <Plug>(neosnippet_expand_target)

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
autocmd BufRead,BufNewFile *.es6 set filetype=javascript
au FileType javascript set sts=2 sw=2

" Language: Perl
au FileType perl set sts=2 sw=2

" Language: Ruby
" --------------
au FileType ruby set sts=2 sw=2
au FileType eruby set sts=2 sw=2
au FileType ruby setlocal spell
au FileType eruby setlocal spell

" macro @s converts old hash syntax to new
au FileType ruby let @s='xeplxxx'
au FileType eruby let @s='xeplxxx'
" macro @t converts single quotes to double (as long as no internal quotes)
au FileType ruby let @t='r"f''r"'
au FileType eruby let @t='r"f''r"'

" Language: Rust
" --------------
let g:rustfmt_autosave = 1
"let g:ale_rust_cargo_use_clippy = 1     why can't i use both...?

if has('nvim')
lua <<EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
endif

" Language: YAML
" --------------
au FileType yaml set sts=2 sw=2

" Load all plugins now
packloadall
" Load all helptags now, after plugins have been loaded
silent! helptags ALL
