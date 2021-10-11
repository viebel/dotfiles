" Sources {{{
" vi-improved.org/vimrc.php
" github.com/carlhuda/janus
" github.com/gmarik/vimfiles/blob/master/vimrc
" github.com/durdn/cfg/blob/master/.vimrc
" github.com/factorylabs/vimfiles
" github.com/lukerandall/dotvim/blob/master/vimrc
" github.com/mathiasbynens/dotfiles/blob/master/.vimrc
" viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html
" }}}
" Plugins {{{
" Init vim-plug {{{
call plug#begin(stdpath('data') . '/plugged')
" }}}
" Sane defaults {{{
Plug 'tpope/vim-sensible'
" }}}
" Colors {{{
Plug 'fnune/base16-vim'
" }}}
" Languages {{{
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'p00f/nvim-ts-rainbow'
" Clojure {{{
Plug 'Olical/conjure', { 'for': 'clojure', 'tag': 'develop' }
" }}}
" Python {{{
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
" }}}
" }}}
" }}}
" Everything else {{{
Plug 'kien/ctrlp.vim'
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

Plug 'bkad/CamelCaseMotion'
" Plug 'justinmk/vim-sneak'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-signify'
Plug 'romainl/vim-qf'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'ryanoasis/vim-devicons', { 'on':  'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Pocco81/AutoSave.nvim'
Plug 'tommcdo/vim-exchange'
" }}}

" Finish Init vim-plug {{{
call plug#end()
" }}}
" Options {{{
" set autochdir
" }}}

" Colors {{{
let base16colorspace=256
colorscheme base16-eighties
" }}}
" Spaces {{{
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
" }}}
" Status Line {{{
set signcolumn=auto:2
set shortmess=atI
set noshowmode
" }}}
" Ignored {{{
set wildignore+=*.swp,.git/,*.jpg,*.jpeg,*.png,*.gif,*.psd,*.pdf,\.DS_Store,\.empty
set wildignore+=*.pyc,*.pyo,*.egg,*.egg-info
set wildignore+=*.a,*.o,*.so
set wildignore+=*.class
" }}}
" Keys {{_{
nnoremap <SPACE> <Nop>
let mapleader=" "
let maplocalleader=","
cabbrev vhelp vert help

inoremap jk <Esc>
inoremap jj <Esc>
inoremap fd <Esc>

"Insert single character with Space
" nnoremap <Space> i_<Esc>r

nnoremap j gj
nnoremap k gk

nnoremap <silent> <C-j> <C-W>j
nnoremap <silent> <C-k> <C-W>k
nnoremap <silent> <C-h> <C-W>h
nnoremap <silent> <C-l> <C-W>l

nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>

" move lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" yank buffer name
" relative path (src/foo.txt)
nnoremap <leader>cf :let @+=expand("%")<CR>
" absolute path (/something/src/foo.txt)
nnoremap <leader>cF :let @+=expand("%:p")<CR>
" filename (foo.txt)
nnoremap <leader>ct :let @+=expand("%:t")<CR>
" directory name (/something/src)
nno <leader>ch :let @+=expand("%:p:h")<CR>

" inoremap 1 !
" inoremap 2 @
" inoremap 3 #
" inoremap 4 $
" inoremap 5 %
" inoremap 6 ^
" inoremap 7 &
" inoremap 8 *
" inoremap 9 (
" inoremap 0 )
" inoremap - _

" inoremap ! 1
" inoremap @ 2
" inoremap # 3
" inoremap $ 4
" inoremap % 5
" inoremap ^ 6
" inoremap & 7
" inoremap * 8
" inoremap ( 9
" inoremap ) 0
" inoremap _ -
" }}}
" Searching {{{
set smartcase
set ignorecase
set nohlsearch
set gdefault
set wildmode=list:longest
set wildignorecase
" }}}
" Format {{{
set wrap
set linebreak
set textwidth=79
set relativenumber
set number
set matchtime=3
set nolist
set nosmartindent
set cindent
syntax sync minlines=256
set lazyredraw

nnoremap <silent> <Leader>r :redraw!<CR>

" TODO consider removing
augroup Format-Options
    autocmd!
    autocmd BufEnter * setlocal formatoptions=crqn2l1j
augroup END

" Set color column per file type.
function! ColorColumnPerFileType()
    call clearmatches()
    let langs = ["python"]
    if index(langs, &filetype) >= 0 | call matchadd('ColorColumn', printf('\%%%dv', &textwidth+1), -1) | endif
endfunc

" Set new/old regexp engine per file type.
function! RegExpEnginePerFileType()
    call clearmatches()
    let langs = ["go"]
    if index(langs, &filetype) >= 0 | set regexpengine=1 | else | set regexpengine=0 | endif
endfunc

" Set maximum syntax color column.
function! SynMaxColPerFileType()
    let langs = ["go"]
    if index(langs, &filetype) >= 0 | set synmaxcol=1000 | else | set synmaxcol=3000 | endif
endfunc
" }}}
" Folding {{{
function! FoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2)
    let fillcharcount = windowwidth - len(line)

    return line . repeat(" ", fillcharcount)
endfunction " }}}

set foldenable
set foldmethod=expr
" if &diff | set foldmethod=diff | else | set foldmethod=syntax | endif
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=0
" set foldopen=block,hor,tag,percent,mark,quickfix,search

set foldtext=FoldText()
" }}}
" Backup {{{
set nobackup
set nowritebackup
" }}}
" Mouse {{{
behave xterm
set mouse-=a
set mousehide
" }}}
" Bells {{{
set novisualbell
" }}}
" Misc. {{{
set splitbelow splitright
set hidden
set title
set clipboard=unnamedplus
" }}}
" Languages {{{
" sh,bash,zsh {{{
let g:sh_fold_enabled = 3
let g:zsh_fold_enable = 1
let g:is_bash=1
" }}}
" }}}
" }}}
" Plugin configurations {{{
" Firenvim {{{
if exists('g:started_by_firenvim')
  set guifont=Iosevka:h20
  set laststatus=0
else
  set laststatus=2
endif
" }}}
" UtilsSnip {{{

" }}}
" Airline {{{
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols_ascii = 1
let g:airline#extensions#branch#displayed_head_limit = 15
" }}}
" Camelcase motion {{{
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e
" }}}
" CoC {{{
let g:coc_global_extensions = [
            \ 'coc-diagnostic',
            \ 'coc-json',
            \ ]

highlight! link LineNr StatusLine
highlight! link CocErrorHighlight NONE
highlight! link CocWarningHighlight NONE
highlight! link CocInfoHighlight NONE
highlight! link CocHintHighlight NONE

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <localleader>rn <Plug>(coc-rename)

xmap <localleader>f  <Plug>(coc-format-selected)
nmap <localleader>f  <Plug>(coc-format-selected)

" nnoremap <silent> K :call <SID>show_doc()<CR>
nnoremap <silent><localleader>dh :call <SID>show_documentation()<CR>
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" nnoremap <silent><localleader>gg :call CocAction('jumpDefinition')<CR>
" nnoremap <silent><localleader>gl :call CocAction('jumpDeclaration')<CR>
" nnoremap <silent><localleader>gi :call CocAction('jumpImplementation')<CR>
" nnoremap <silent><localleader>gr <Plug>(coc-references)
nmap <silent><localleader>gg <Plug>(coc-definition)
nmap <silent><localleader>gy <Plug>(coc-type-definition)
nmap <silent><localleader>gi <Plug>(coc-implementation)
nmap <silent><localleader>gr <Plug>(coc-references)

nnoremap <silent><nowait> <localleader>ga  :<C-u>CocFzfList diagnostics<cr>
nmap <silent><localleader>ge <Plug>(coc-diagnostic-info)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" nmap <localleader>qf <Plug>(coc-fix-current)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Other helpful stuff
" nnoremap <silent><localleader>gc :call CocAction('codeAction')<CR>
" nnoremap <silent><localleader>gR :call CocAction('rename')<CR>
" nnoremap <silent><localleader>gq :call CocAction('quickfixes')<CR>
" nnoremap <silent><localleader>,. :call CocActionAsync('format')<CR>
" nnoremap <silent><localleader>gL :CocFzfList<CR>

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Clojure stuff {{{
nnoremap <silent> <localleader>rrc :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'cycle-coll', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> <localleader>rrn :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'clean-ns', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> <localleader>rrp :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'cycle-privacy', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> <localleader>rrf :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'extract-function', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Function name: ')]})<CR>

nnoremap <silent> <localleader>rth :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-first', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> <localleader>rtt :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-last', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> <localleader>rtf :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-first-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> <localleader>rtl :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-last-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> <localleader>rtw :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'unwind-thread', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> <localleader>rta :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'unwind-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>

nnoremap <silent> <localleader>rlm :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'move-to-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>
nnoremap <silent> <localleader>rli :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'introduce-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>
nnoremap <silent> <localleader>rle :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'expand-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>

nnoremap <silent> <localleader>ram :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'add-missing-libspec', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> <localleader>ros :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'inline-symbol', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
" }}}
" }}}
" Conjure {{{
let g:sexp_insert_after_wrap  = v:false
let g:conjure#mapping#def_word = v:false
highlight! link NormalFloat StatusLine
" }}}
" fzf {{{
let g:fzf_command_prefix = 'Fzf'
nnoremap <silent> <Leader>pf :FzfFiles<CR>
nnoremap <silent> <Leader>bb :FzfBuffers<CR>
nnoremap <silent> <Leader>ff :FZF %:p:h<CR>
" }}}
" NERDTree {{{
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let NERDChristmasTree = 1
let NERDTreeShowHidden = 1
let NERDTreeChDirMode = 1
let NERDTreeShowFiles = 1
let NERDTreeMinimalUI = 1
let NERDTreeWinPos = 'right'
let NERDTreeIgnore = [
            \ '.DS_Store', '\.swp$', '\~$', '.empty',
            \ '\.jpg$', '\.jpeg$', '\.png$', '\.gif$', '\.pdf$',
            \ '\.class$',
            \ '\.a$', '\.o$', '\.so$',
            \ '\.pyc$', '\.pyo$',
            \ '\.tags$'
            \ ]

noremap <silent> <Leader>n :NERDTreeToggle<CR>
" }}}
" Quickfix {{{
nmap <Leader>q <Plug>(qf_qf_toggle)
nmap <Leader>l <Plug>(qf_loc_toggle)
" }}}
" Repeat {{{
silent! call repeat#set("\<Plug>.", v:count)
" }}}
" Signify {{{
let g:signify_vcs_list = [ 'git' ]
" }}}
" Sneak {{{
" highlight link SneakPluginTarget Visual

" map ; <Plug>SneakNext

" nmap f <Plug>Sneak_f
" nmap F <Plug>Sneak_F
" xmap f <Plug>Sneak_f
" xmap F <Plug>Sneak_F
" omap f <Plug>Sneak_f
" omap F <Plug>Sneak_F

" nmap t <Plug>Sneak_t
" nmap T <Plug>Sneak_T
" xmap t <Plug>Sneak_t
" xmap T <Plug>Sneak_T
" omap t <Plug>Sneak_t
" omap T <Plug>Sneak_T
" }}}
" Tagbar {{{
nnoremap <silent> <Leader>t :TagbarToggle<CR>

let g:tagbar_sort = 0
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1

let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : 'markdown2ctags',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }
" }}}
" Treesitter {{{
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  -- Modules and its options go here
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    }
  },
  indent = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = false,
    max_file_lines = 4000
  }
}
EOF
" }}}
" Autocmds {{{
" Actions on opening a new buffer {{{
augroup Buf-Win-Enter
    autocmd!
    autocmd BufWinEnter * call ColorColumnPerFileType() | call RegExpEnginePerFileType() | call SynMaxColPerFileType()
augroup END
" }}}
" Filetype actions {{{
augroup FileTypeActions
    autocmd!
    autocmd FileType * set tags=./.tags;,~/.vimtags
    autocmd FileType gitcommit setlocal textwidth=72
    autocmd FileType qf setlocal wrap
augroup END
" }}}
" }}}
" AutoSave {{{
lua << EOF
local autosave = require("autosave")

autosave.setup(
    {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true,
            filename_is_not = {},
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
)
EOF
" }}}
" }}}

