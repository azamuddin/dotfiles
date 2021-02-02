" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

if !has('nvim')
  NeoBundle 'tiagofumo/vim-nerdtree-syntax-highlight'
endif

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" END NEOBUNDLE

" vim plugin yang diinstall pake pathogen
execute pathogen#infect()

set splitright

"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
let vimplug_exists=expand('~/.vim/autoload/plug.vim')

let g:vim_bootstrap_langs = "javascript,php,typescript" 
let g:vim_bootstrap_editor = "vim"				
" nvim or vim
" let's not using tsuqoyomi for the sake of coc-vim options for
" tsuquyomi/typescript bro 
"let g:tsuquyomi_completion_detail = 1 set ballooneval autocmd FileType
"typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving insert
" mode
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif


if !filereadable(vimplug_exists) 
	if !executable("curl") 
		echoerr "You have to install curl or first install vim-plug yourself!" 
		execute "q!" 
	endif 
	echo "Installing Vim-Plug..." 
	echo "" silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" 
	let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall 
endif

" Required:
call plug#begin(expand('~/.vim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************

Plug 'npxbr/glow.nvim', {'do': ':GlowInstall'}

Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-commentary' 
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive' 
Plug 'airblade/vim-gitgutter' 
Plug 'vim-scripts/grep.vim' 
Plug 'vim-scripts/CSApprox' 
Plug 'Raimondi/delimitMate' 
Plug 'majutsushi/tagbar'
Plug 'Yggdroot/indentLine' 
Plug 'avelino/vim-bootstrap-updater' 
Plug 'sheerun/vim-polyglot' 
Plug 'tpope/vim-rhubarb' 
" required by fugitive to :Gbrowse 
Plug 'diepm/vim-rest-console'
Plug 'nicwest/vim-http'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'yuttie/comfortable-motion.vim'
Plug 'christoomey/vim-conflicted'
Plug 'davidoc/taskpaper.vim'
Plug 'vifm/vifm.vim'
Plug 'skwp/greplace.vim'
Plug 'nightsense/rusticated'
Plug 'kyledoherty/espresso-colors-vim'
Plug 'StanAngeloff/php.vim'

"if isdirectory('/usr/local/opt/fzf') 
  "Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim' 
"else 
  "Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do':'./install --bin' } 
  "Plug 'junegunn/fzf.vim' 
"endif 

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do':'./install --bin' } 
Plug 'junegunn/fzf.vim' 

Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'skywind3000/quickmenu.vim'


let g:make = 'gmake' 

if exists('make') 
  let g:make = 'make' 
endif 

Plug 'Shougo/vimproc.vim', {'do':g:make}

"" Vim-Session
Plug 'xolox/vim-misc' 
Plug 'xolox/vim-session'

"" Snippets
Plug 'SirVer/ultisnips' 
Plug 'honza/vim-snippets'

"" Color
Plug 'tomasr/molokai'
Plug 'ts-26a/vim-darkspace'
Plug 'artanikin/vim-synthwave84'
Plug 'gkapfham/vim-vitamin-onec'
Plug 'ntk148v/vim-horizon'
Plug 'maksimr/Lucius2'
Plug 'vim-scripts/Ambient-Color-Scheme'
Plug 'scottymoon/vim-chalkboard'
"Plug 'fatih/molokai'
Plug 'fcevado/molokai_dark'
Plug 'acoustichero/simple_dark'
Plug 'jasoncarr0/sidewalk-colorscheme'
Plug 'vim-scripts/darkspectrum'
Plug 'dracula/vim'
Plug 'gosukiwi/vim-atom-dark'
Plug 'nanotech/jellybeans.vim'
Plug 'ParamagicDev/vim-medic_chalk'


""*****************************************************************************
"" Custom bundles
"*****************************************************************************

" javascript
"" Javascript Bundle
Plug 'jelera/vim-javascript-syntax'


" php
"" PHP Bundle
Plug 'arnaud-lb/vim-php-namespace'


" typescript
"Plug 'leafgarland/typescript-vim' 
"Plug 'HerringtonDarkholme/yats.vim' 
"Plug 'peitalin/vim-jsx-typescript'


" vim dash
Plug 'rizzatti/dash.vim'


Plug 'rhysd/git-messenger.vim'
if !has('nvim')
  Plug 'rhysd/vim-healthcheck'
endif

" Emmet 
Plug 'mattn/emmet-vim'
" markdown preview
Plug 'jamshedvesuna/vim-markdown-preview'
Plug 'dart-lang/dart-vim-plugin' 
Plug 'thosakwe/vim-flutter'

" lets not use these in favor for coc-vim
"
Plug 'natebosch/vim-lsc' 
Plug 'natebosch/vim-lsc-dart'

Plug 'severin-lemaignan/vim-minimap'

" using coc-vim Install nightly build, replace ./install.sh with install.cmd
" on windows
"Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
" Or install latest release tag
"Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
" Or build from source code
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" to avoid hook 127 error
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition) 
nmap <silent> gy <Plug>(coc-type-definition) 
nmap <silent> gi <Plug>(coc-implementation) 
nmap <silent> gr <Plug>(coc-references) 
nmap <Leader>gi <Plug>(coc-implementation)
nmap <leader>rn <Plug>(coc-rename) 
nmap <F2> <Plug>(coc-rename)
"*****************************************************************************
"*****************************************************************************

"" Include user's extra bundle
if filereadable(expand("~/.vimrc.local.bundles")) 
  source  ~/.vimrc.local.bundles 
endif

"Plug 'romgrk/barbar.nvim'


if has('nvim')
  Plug 'kyazdani42/nvim-tree.lua'
  "Plug 'numtostr/BufOnly.nvim', { 'on': 'BufOnly' }
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  "Plug 'nvim-lua/lsp-status.nvim'
  "Plug 'neovim/nvim-lsp'
  "Plug 'neovim/nvim-lspconfig'
  "Plug 'glepnir/galaxyline.nvim'
  "Plug 'akinsho/nvim-bufferline.lua'
  " Note: This used to be luvjob, but plenary is required now.
  "Plug 'tjdevries/express_line.nvim'
  "Plug 'glepnir/indent-guides.nvim'
else 
  "Plug 'vim-scripts/BufOnly.vim'
  Plug 'scrooloose/nerdtree' 
  Plug 'jistr/vim-nerdtree-tabs' 
endif

function! g:BuffetSetCustomColors()
    hi! BuffetCurrentBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#0E0E0E guifg=#FFD2A7
    hi! BuffetBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#444444
    hi! BuffetModActiveBuffer cterm=NONE ctermbg=5 ctermfg=8 guifg=green guibg=#444444
    hi! BuffetModCurrentBuffer cterm=NONE ctermbg=5 ctermfg=8 guifg=green guibg=#0e0e0e
    hi! BuffetModBuffer cterm=NONE ctermbg=5 ctermfg=8 guifg=green guibg=#444444
    hi! BuffetTab cterm=NONE ctermbg=5 ctermfg=8 guifg=#FFD2A7 guibg=#444444
endfunction
Plug 'bagrat/vim-buffet'


Plug 'vim-airline/vim-airline' 
Plug 'vim-airline/vim-airline-themes' 


Plug 'jdsimcoe/hyper.vim'
Plug 'habamax/vim-colors-defnoche'
Plug 'plainfingers/black_is_the_color'

Plug 'lewis6991/moonlight.vim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'megantiu/true.vim'
Plug 'jdsimcoe/panic.vim'
Plug 'xdg/vim-darkluma'
Plug 'fielding/vice'
Plug 'wdhg/dragon-energy'
Plug 'mhinz/vim-startify'

Plug 'morhetz/gruvbox'
Plug 'mhinz/vim-janah'
Plug 'ap/vim-css-color'
Plug 'lifepillar/vim-solarized8'
Plug 'vimwiki/vimwiki'
Plug 'michal-h21/vim-zettel'


Plug 'vim-scripts/pyte'
Plug 'vim-scripts/nuvola.vim'

" make sure vim-devicions always last
if has('nvim')
  Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
  Plug 'ryanoasis/vim-devicons' 
else 
  Plug 'ryanoasis/vim-devicons' 
endif 


call plug#end()

"********** END OF PLUG ***********





" Required:
filetype plugin indent on


"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8 
set fileencoding=utf-8 
set fileencodings=utf-8 
set ttyfast

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overridden by autocmd rules
set tabstop=2 
set softtabstop=0 
set shiftwidth=2 
set expandtab

"" Map leader to ,
let mapleader=','

"" Searching
set hlsearch 
set incsearch 
set ignorecase 
set smartcase

set fileformats=unix,dos,mac

if exists('$SHELL') 
    set shell=$SHELL 
  else 
    set shell=/bin/sh 
endif

" session management
let g:session_directory = "~/.vim/session" 
let g:session_autoload = "no" 
let g:session_autosave = "no" 
let g:session_command_aliases = 1

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on 
set ruler 
set number

let no_buffers_menu=1 
silent! colorscheme dragon-energy 
autocmd! BufEnter *.md colorscheme dragon-energy
set background=dark

set mousemodel=popup 
set guioptions=egmrti 
set gfn=Monospace\ 10

if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
  endif
else
  let g:CSApprox_loaded = 1

  " IndentLine
  let g:indentLine_enabled = 0
  let g:indentLine_concealcursor = 0
  let g:indentLine_char = '┆'
  let g:indentLine_faster = 1

  
  if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
  else
    if $TERM == 'xterm'
      set term=xterm-256color
    endif
  endif
  
endif



if &term =~ '256color' 
  set t_ut= 
endif


"" Disable the blinking cursor.
set gcr=a:blinkon0 
set scrolloff=3

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline 
set modelines=10

set title 
set titleold="Terminal" 
set titlestring=%F


" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv 
nnoremap N Nzzzv



"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!  
cnoreabbrev Q! q!  
cnoreabbrev Qall! qall!  
cnoreabbrev Wq wq 
cnoreabbrev Wa wa 
cnoreabbrev wQ wq 
cnoreabbrev WQ wq 
cnoreabbrev W w
cnoreabbrev Q q 
cnoreabbrev Qall qall

"" NERDTree configuration
let g:NERDTreeChDirMode=2 
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$','\.db$', '\.sqlite$', '__pycache__', '\.swp$', '\.swo$'] 
let g:NERDTreeSortOrder=['^__\.py$','\/$', '*', '\.swp$', '\.bak$', '\~$'] 
let g:NERDTreeShowBookmarks=1 
let g:nerdtree_tabs_focus_on_files=1 
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>' 
let g:NERDTreeWinSize = 35 
let g:NERDTreeShowHidden = 1
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite 
"" dont let buffer opened file in NerdTree Window
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
"" prevent quit vim after bd on file opened by NERDTree

" grep.vim
nnoremap <silent> <leader>f :Rgrep<CR> 
let Grep_Default_Options = '-IR' 
let Grep_Skip_Files = '*.log *.db' 
let Grep_Skip_Dirs = '.git node_modules'

" terminal emulation
nnoremap <silent> <leader>sh :vert terminal<CR>

"*****************************************************************************
"" Commands
"*****************************************************************************
"remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e

"*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping') 
  function s:setupWrapping() 
    set wrap set wm=2
    set textwidth=79 
  endfunction 
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart 
  autocmd!  
  autocmd BufEnter * :syntax sync maxlines=200 
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position 
  autocmd!  
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping 
  autocmd!  
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping() 
augroup END

"" make/cmake
augroup vimrc-make-cmake 
  autocmd!  
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake 
augroup END

set autoread

"*****************************************************************************
"" Mappings
"*****************************************************************************

"" Split
noremap <Leader>h :<C-u>split<CR> noremap <Leader>v :<C-u>vsplit<CR>

"" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

" session management
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/"<CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

"" fzf.vim
noremap <leader>bu :Buffers<CR>

set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__,node_modules
let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_preview_window = ['right:60%', 'ctrl-/']

let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
endif

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>


" custom FZF call 
function! FZFTerminalPwd()
   exe "lcd " . getcwd(-1) . " | Files"
endfunction 

" call FZF on terminal pwd
nnoremap <leader>e :call FZFTerminalPwd()<CR> 

function! FZFHere()
   exe "lcd %:p:h | FZF"
endfunction 

" call FZF on the current file directory
nnoremap <leader>l :call FZFHere()<CR> 



"Recovery commands from history through FZF
nmap <leader>y :History:<CR>

" snippets
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-w>"
let g:UltiSnipsJumpBackwardTrigger="<c-o>"
"let g:UltiSnipsEditSplit="vertical"

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif


"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"" Open current line on GitHub
nnoremap <Leader>o :.Gbrowse<CR>

"*****************************************************************************
"" Custom configs
"*****************************************************************************

" javascript
let g:javascript_enable_domhtmlcss = 1

" vim-javascript
augroup vimrc-javascript
  autocmd!
  autocmd FileType javascript setl tabstop=2|setl shiftwidth=2|setl expandtab softtabstop=4
augroup END


" php


" typescript
let g:yats_host_keyword = 1

"*****************************************************************************
"*****************************************************************************

"" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

"*****************************************************************************
"" Convenience variables
"*****************************************************************************

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_theme = 'sierra'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 0
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

if has('nvim')
  let g:airline#extensions#tabline#enabled = 0
  let g:airline#extensions#tabline#formatter = 'jsformatter'
  let g:airline#extensions#tabline#ignore_bufadd_pat =
    \ 'gundo|undotree|vimfiler|tagbar|nerd_tree|startify|!'
else 
  let g:airline#extensions#tabline#enabled = 0
  let g:airline#extensions#tabline#formatter = 'jsformatter'
  let g:airline#extensions#tabline#ignore_bufadd_pat =
    \ 'gundo|undotree|vimfiler|tagbar|nerd_tree|startify|!'
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = ' '
  let g:airline_left_sep          = ''"▶
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = ' · ' "◀
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

 " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif



" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" vim-http split vertical
let g:vim_http_split_vertically=1

" autoload view 
autocmd BufWinLeave *.* mkview 
autocmd BufWinEnter *.* silent! loadview


" remap fast up and down (scroll) via confortable motion
" nnoremap <silent> <C-j> :call comfortable_motion#flick(100)<CR>
" nnoremap <silent> <C-k> :call comfortable_motion#flick(-100)<CR>
:set fillchars+=vert:\ 


nnoremap <leader>vi :Vifm<CR>
nnoremap <C-o> o<Esc>

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set t_Co=256 
set relativenumber


"---------- QUICK MENU

" choose a favorite key to show/hide quickmenu
noremap <silent><leader>m :call quickmenu#toggle(0)<cr>

" enable cursorline (L) and cmdline help (H)
let g:quickmenu_options = "HL"

" section 1, text starting with "#" represents a section (see the screen capture below)
call g:quickmenu#append('# Develop', '')

call g:quickmenu#append('item 1.1', 'echo "1.1 is selected"', 'select item 1.1')
call g:quickmenu#append('item 1.2', 'echo "1.2 is selected"', 'select item 1.2')
call g:quickmenu#append('item 1.3', 'echo "1.3 is selected"', 'select item 1.3')

" section 2
call g:quickmenu#append('# Misc', '')

call g:quickmenu#append('item 2.1', 'echo "2.1 is selected"', 'select item 2.1')
call g:quickmenu#append('item 2.2', 'echo "2.2 is selected"', 'select item 2.2')
call g:quickmenu#append('item 2.3', 'echo "2.3 is selected"', 'select item 2.3')
call g:quickmenu#append('item 2.4', 'echo "2.4 is selected"', 'select item 2.4')

"---------- END QUICK MENU

" related to nvim-treesitter must be outside Plug
if has('nvim')
lua <<EOF

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
EOF
" end
endif

let vim_markdown_preview_github=1
let vim_markdown_preview_browser='Google Chrome'
let vim_markdown_preview_toggle=1
let vim_markdown_preview_temp_file=1

" dart & flutter 
let g:hot_reload_on_save=1 
let g:flutter_hot_reload_on_save=1

" emmet
let g:user_emmet_settings = {
      \'javascript': {
      \     'extends': 'jsx',
      \}
\}

"let g:user_emmet_expandabbr_key='<Tab>'
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

if has('nvim')
  noremap <silent>\\ :LuaTreeToggle<CR>
  noremap <silent>]] :LuaTreeFindFile<CR>
  noremap <silent>gl :Glow<CR>
  noremap <silent>gm :GitMessenger<CR>
  noremap <silent>tele :Telescope git_files<CR>
  nmap <silent>telebu :Telescope buffers<CR>
  " bufferline 
  "noremap <leader>k :BufferLineCycleNext<CR>
  "noremap <leader>j :BufferLineCyclePrev<CR>
  nmap <silent> cbp :BufferLinePick<CR>
  noremap <leader>k :bn<CR>
  noremap <leader>j :bp<CR>
else 
  nnoremap \\ :NERDTreeToggle<CR>
  nnoremap ]] :NERDTreeFind<CR>
  noremap <leader>k :bn<CR>
  noremap <leader>j :bp<CR>
endif

set encoding=UTF-8

noremap <silent>cdf :color defnoche<CR>
noremap <silent>cbc :color black_is_the_color<CR>
noremap <silent>chp :color hyper<CR>


noremap <Leader>vimrc :e ~/.vimrc<CR>


if has('nvim')

lua <<EOF
  --require'bufferline'.setup{
    --options = {
        ----view = "multiwindow" | "default",
        ----numbers = "none" | "ordinal" | "buffer_id",
        ----number_style = "superscript" | "",
        ----mappings = true | false,
        --buffer_close_icon= '',
        --buffer_close_icon = '',
        ----modified_icon = 'm',
        ----close_icon = '',
        ----left_trunc_marker = '',
        ----right_trunc_marker = '',
        --max_name_length = 18,
        --tab_size = 18,
        ----show_buffer_close_icons = true | false,
        ---- can also be a table containing 2 custom separators
        ---- [focused and unfocused]. eg: { '|', '|' }
        ----separator_style = "slant" | "thick" | "thin" | { 'any', 'any' },
        --separator_style = ""
        ----enforce_regular_tabs = false | true,
        ----always_show_bufferline = true | false,
        ----sort_by = 'extension' | 'relative_directory' | 'directory' | function(buffer_a, buffer_b)
          ---- add custom logic
          ----return buffer_a.modified > buffer_b.modified
        ----end
      --}
  --}
EOF
endif

"" Close buffer
noremap <leader>c :bd<CR>

"plug vim-buffet 
nmap <silent><leader>bo :Bonly<CR>
noremap <silent><leader>w :Bw<CR>


if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif


let g:startify_lists = [
      \ { 'type': 'dir',       'header': ['   Recent files in '. getcwd()] },
      \ { 'type': 'files',     'header': ['   Most recent opened files globally']            },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]

hi Pmenu guibg=#303030
hi Identifier guifg=#FFD2A7
hi Directory guifg=orange
hi Title guifg=red
hi Function guifg=#1094C3
hi String guifg=#33ddc8
hi Normal ctermbg=10 guifg=#fefefe guibg=#1b1b1b
hi SignColumn ctermbg=10 guibg=#202020
hi GitGutterAdd guibg=#202020
hi GitGutterChange guibg=#202020
hi GitGutterDelete guibg=#202020
hi Folded guifg=white guibg=#303030

let g:buffet_powerline_separators = 1
let g:buffet_tab_icon = "\uf00a"
let g:buffet_left_trunc_icon = "\uf0a8"
let g:buffet_right_trunc_icon = "\uf0a9"



" diepm/vim-rest-console
let g:vrc_elasticsearch_support = 1


" vim-zettel 
let g:zettel_format = "%file_no-%y%m%d-%H%M-%title"


" 80 column line 
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/
"

" change theme 
noremap <silent> <leader>dark :color dragon-energy<CR>
noremap <silent> <leader>light :color nuvola<CR>
