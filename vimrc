" Pinglin's vimrc
" Ping-Lin Chang <pinglin02@gmail.com>
" Fork me on GITHUB  https://github.com/pinglin/vimrc

" For pathogen.vim: auto load all plugins in .vim/bundle
call pathogen#infect()

"let g:pathogen_disabled = []
"if !has('gui_running')
"   call add(g:pathogen_disabled, 'powerline')
"endif

"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()

" General Settings

set nocompatible  " not compatible with the old-fashion vi mode
set bs=2          " allow backspacing over everything in insert mode
set history=1000  " keep 50 lines of command line history
set ruler         " show the cursor position all the time
set autoread      " auto read when file is changed from outside
set autowrite     " auto write when normal, insert, command, visual modes switched
set cursorline    " highlight current line
set undofile      " save undo history 
set undolevels=1000   " save undo history 
set pastetoggle=<F12> " deal with terminal paste
set backspace=indent,eol,start

" show invisible characters in a line using 'listchars' to define
set listchars=tab:►»,eol:▽,extends:>,precedes:< 
set splitbelow
set splitright
set fillchars=diff:░
set title
set linebreak
set dictionary=/usr/share/dict/words

set colorcolumn=+1
set textwidth=80
set formatoptions+=t
set nowrap

" Backups {{{
"set undodir=~/.vim/tmp/undo//     " undo files
"set directory=~/.vim/tmp/swap//   " swap files
set nobackup                      " disable backups
set noswapfile                    
" }}}

" Folding setting {{{
set foldmethod=marker   " Fold based on indent
set foldnestmax=10      " Deepest fold is 10 levels
set nofoldenable        " Dont fold by default
" }}}

" Don't try to highlight lines longer than 800 characters.
set synmaxcol=800

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc

" Save when losing focus
autocmd FocusLost * :silent! wall

" Resize splits when the window is resized
autocmd VimResized * :wincmd =

syntax on		" syntax highlight
set hlsearch	" search highlighting

set guifont=Monaco\ 12
if has("gui_macvim")
   set guifont=Monaco:h12
elseif has("gui_win32")
   set guifont=Monaco:h12
end

set clipboard=unnamed	" yank to the system register (*) by default
set showmatch		" Cursor shows matching ) and }
set showmode		" Show current mode
set wildchar=<TAB>	" start wild expansion in the command line using <TAB>
set wildmenu        " wild char completion menu
set cot-=preview    "disable doc preview 

" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc

set autoindent		" auto indentation
set incsearch		" incremental search
set copyindent		" copy the previous indentation on autoindenting
set ignorecase		" ignore case when searching
set smartcase		" ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab		" insert tabs on the start of a line according to context

" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" TAB setting{
set tabstop=3
set softtabstop=3
set shiftwidth=3
set shiftround

autocmd FileType Makefile set noexpandtab
"}

" status line {
set laststatus=2
set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \ 
set statusline+=\ \ \ [%{&ff}/%Y] 
set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\ 
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L

function! CurDir()
   let curdir = substitute(getcwd(), $HOME, "~", "")
   return curdir
endfunction

function! HasPaste()
   if &paste
      return '[PASTE]'
   else
      return ''
   endif
endfunction

"}

" CMake syntex and indent {
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in runtime! indent/cmake.vim 
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in setf cmake
autocmd BufRead,BufNewFile *.ctest,*.ctest.in setf cmake
"}

" C/C++ specific settings
autocmd FileType c,cpp,cc,h  set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30
map <F1> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"--------------------------------------------------------------------------- 
" Tip #382: Search for <cword> and replace with input() in all open buffers 
"--------------------------------------------------------------------------- 
fun! Replace() 
  let s:word = input("Replace " . expand('<cword>') . " with:") 
  :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/ge' 
  :unlet! s:word 
endfunction 


"--------------------------------------------------------------------------- 
" USEFUL SHORTCUTS
"--------------------------------------------------------------------------- 

" set leader to ,
let mapleader=","
let g:mapleader=","

" save file
noremap <leader>s <C-C>:w<CR>
inoremap <leader>s <C-O>:w<CR><ESC>

" update vimrc right away
noremap <leader>v <C-C>:source $MYVIMRC <CR>
inoremap <leader>v <C-O>:source $MYVIMRC<CR><ESC>

" map ctrl+; to : for switching normal to command model
nnoremap <C-C> :

" [[ jump out of the tag stack (undo Ctrl-])
map [[ :po<CR>

noremap <silent> <F2> "=strftime('%Y/%m/%d')<C-M>p
inoremap <silent> <F2> <C-R>=strftime('%Y/%m/%d')<C-M>

" make cursor fixed bewteen insert and normal mode switch
"autocmd InsertLeave * :normal `^`

" make search expressions very magic
nnoremap / /\v
vnoremap / /\v

" keep search stuffs with cursor targeted at the middle of screen{
" Don't move on *
"nnoremap * *<c-o>

"  c-\ to do c-] but open it in a new split.
nnoremap <c-\> <c-w>v<c-]>zvzz

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz
"}


" handy edit commands
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

"replace the current word in all opened buffers
map <leader>R :call Replace()<CR>

" open the error console
map <leader>cc :botright cope<CR> 
" move to next error
map <leader>] :cn<CR>
" move to the prev error
map <leader>[ :cp<CR>

" --- move around splits {
" set the min width of a window to 0 so we can maximize others 
"set wmw=0 
" set the min height of a window to 0 so we can maximize others
set wmh=0
" move to and maximize the below split 
map <c-j> <c-w>j<c-w>_
" move to and maximize the above split 
map <c-k> <c-w>k<c-w>_
" move to and maximize the left split 
"map <c-h> <c-w>h<c-w><bar>
" move to and maximize the right split  
"map <c-l> <c-w>l<c-w><bar>

"" move to the below split 
"noremap <c-j> <c-w>j
"" move to the above split 
"noremap <c-k> <c-w>k

"" move to the left split 
nnoremap <C-H> <ESC><C-W>h
inoremap <C-H> <ESC><C-W>h

"" move to the right split  
nnoremap <C-L> <ESC><C-W>l
inoremap <C-L> <ESC><C-W>l

" Maps Alt-[h,j,k,l] to resizing a window split
if bufwinnr(1)
	map <leader>- 10<C-W><
	map <leader>_ 10<C-W>-
	map <leader>+ 10<C-W>+
	map <leader>= 10<C-W>>
endif
" }

" move around tabs. conflict with the original screen top/bottom
" comment them out if you want the original H/L
" go to prev tab 
nnoremap <leader>q gT
inoremap <leader>q <ESC>gT
vnoremap <leader>q <ESC>gT

" go to next tab
nnoremap <leader>w gt
inoremap <leader>w <ESC>gt
vnoremap <leader>w <ESC>gt

" move tab around
nnoremap <leader>e :tabm<CR>
inoremap <leader>e <C-C>:tabm<CR>
vnoremap <leader>e <C-C>:tabm<CR>

" handy alt+<numer> mapping for switching tabs in all modes
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
inoremap <leader>1 <esc>1gt
inoremap <leader>2 <esc>2gt
inoremap <leader>3 <esc>3gt
inoremap <leader>4 <esc>4gt
inoremap <leader>5 <esc>5gt
inoremap <leader>6 <esc>6gt
inoremap <leader>7 <esc>7gt
inoremap <leader>8 <esc>8gt
inoremap <leader>9 <esc>9gt


" new tab
noremap <C-t>t :tabnew<CR>
" close tab
noremap <C-t>w :tabclose<CR> 

" ,/ turn off search highlighting
nmap <leader><space> :nohls<CR>

" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-B>      <LEFT>
cnoremap <C-F>      <RIGHT>
cnoremap <C-H>      <BACKSPACE>
cnoremap <C-L>      <DELETE>
cnoremap <C-K>      <C-U>

" ,p toggles paste mode
nmap <leader>p :set paste!<BAR>set paste?<CR>

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h

"" Writing Restructured Text (Sphinx Documentation) {
"" Ctrl-u 1:    underline Parts w/ #'s
"noremap  <C-u>1 yyPVr#yyjp
"inoremap <C-u>1 <esc>yyPVr#yyjpA
"" Ctrl-u 2:    underline Chapters w/ *'s
"noremap  <C-u>2 yyPVr*yyjp
"inoremap <C-u>2 <esc>yyPVr*yyjpA
"" Ctrl-u 3:    underline Section Level 1 w/ ='s
"noremap  <C-u>3 yypVr=
"inoremap <C-u>3 <esc>yypVr=A
"" Ctrl-u 4:    underline Section Level 2 w/ -'s
"noremap  <C-u>4 yypVr-
"inoremap <C-u>4 <esc>yypVr-A
"" Ctrl-u 5:    underline Section Level 3 w/ ^'s
"noremap  <C-u>5 yypVr^
"inoremap <C-u>5 <esc>yypVr^A
"}

" TabLine labels. A more neat representation. {

if has('gui')
	set guioptions-=e
endif
if exists("+showtabline")
	function! MyTabLine()
		let s = ''
		let t = tabpagenr()
		let i = 1
		while i <= tabpagenr('$')
			let buflist = tabpagebuflist(i)
			let winnr = tabpagewinnr(i)
			let s .= '%' . i . 'T'
			let s .= (i == t ? '%1*' :	'%2*')
			let s .= ' '
			let s .= i . ':'
			let s .=	winnr . '/' . tabpagewinnr(i,'$')
			let s	.=	' %*'
			let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
			let bufnr = buflist[winnr - 1]
			let file = bufname(bufnr)
			let buftype	= getbufvar(bufnr, 'buftype')
			if buftype == 'nofile'
				if file =~ '\/.'
					let file = substitute(file, '.*\/\ze.', '', '')
				endif
			else
				let file = fnamemodify(file, ':p:t')
			endif
			if file == ''
				let file = '[No Name]'
			endif
			let s	.=	file
			let i = i + 1
		endwhile
		let s .= '%T%#TabLineFill#%='
		let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
		return s
	endfunction
	set tabline=%!MyTabLine()
endif

"}



"--------------------------------------------------------------------------- 
" PROGRAMMING SHORTCUTS
"--------------------------------------------------------------------------- 

" ---- Useful external commands' shortcut {{{

cnoremap lll !ls<CR>
cnoremap lla !ls -al<CR>

" }}}

" ---- Makefile shortcut {{{

" Compile mapping
map <c-b> :!make -j8<CR>

" }}}

" ,g generates the header guard
map <leader>g :call IncludeGuard()<CR>
fun! IncludeGuard()
  let basename = substitute(bufname(""), '.*/', '', '')
  let guard = '_' . substitute(toupper(basename), '\.', '_', "H")
  call append(0, "#ifndef " . guard)
  call append(1, "#define " . guard)
  call append( line("$"), "#endif // for #ifndef " . guard)
endfun

" make CSS omnicompletion work for SASS and SCSS
"autocmd BufNewFile,BufRead *.scss             set ft=scss.css
"autocmd BufNewFile,BufRead *.sass             set ft=sass.css

"--------------------------------------------------------------------------- 
" ENCODING SETTINGS
"--------------------------------------------------------------------------- 
set encoding=utf-8                                  
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

fun! ViewUTF8()
  set encoding=utf-8                                  
  set termencoding=utf-8
endfun

fun! UTF8()
  set encoding=utf-8                                  
  set termencoding=utf-8
  set fileencoding=utf-8
  set fileencodings=ucs-bom,big5,utf-8,latin1
endfun

fun! Big5()
  set encoding=big5
  set fileencoding=big5
endfun


"--------------------------------------------------------------------------- 
" PLUGIN SETTINGS
"--------------------------------------------------------------------------- 

" ---- clang_complete - C/C++ autocompletion tool using clang {{{

let g:clang_auto_select=0
let g:clang_complete_auto=0
let g:clang_complete_copen=1
let g:clang_hl_errors=1
let g:clang_periodic_quickfix=0
let g:clang_snippets=1
let g:clang_snippets_engine="clang_complete"
let g:clang_conceal_snippets=1
let g:clang_exec="clang"
let g:clang_user_options=""
let g:clang_auto_user_options="path, .clang_complete"
let g:clang_use_library=1
let g:clang_library_path="/usr/local/lib"
let g:clang_sort_algo="priority"
let g:clang_complete_macros=1
let g:clang_complete_patterns=0
nnoremap <Leader>clang :call g:ClangUpdateQuickFix()<CR>
"
" }}}

" ------- vim-latex - many latex shortcuts and snippets {{{

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash
set grepprg=grep\ -nH\ $*
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

"}}}

" --- AutoClose - Inserts matching bracket, paren, brace or quote {{{
" fixed the arrow key problems caused by AutoClose
if !has("gui_running")	
  set term=linux
  imap OA <ESC>ki
  imap OB <ESC>ji
  imap OC <ESC>li
  imap OD <ESC>hi

  nmap OA k
  nmap OB j
  nmap OC l
  nmap OD h
endif
" }}}

" --- Command-T {{{
let g:CommandTMaxHeight = 15
" }}}

" --- SuperTab {{{
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]
" }}}

" --- EasyMotion {{{
"let g:EasyMotion_leader_key = '<Leader>m' " default is <Leader>w
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
" }}}

" --- TagBar {{{
" toggle TagBar with F7
nnoremap <silent> <F7> :TagbarToggle<CR> 
" set focus to TagBar when opening it
let g:tagbar_autofocus = 1
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
"autocmd BufEnter * nested :call tagbar#autoopen(0)
" }}}

" --- PowerLine {{{
"let g:Powerline_symbols = 'unicode'
" }}}

" --- NERDTree {{{
nnoremap <silent> <F8> :NERDTree<CR>
nnoremap <silent> <F9> :NERDTreeClose<CR>
" }}}

" --- SnipMate {{{
"let g:snipMateAllowMatchingDot = 0
"let g:snips_trigger_key="<c-a>"
"let g:snips_trigger_key_backwards='<c-x>'
" }}}

"highlight CursorLine guibg=#003853 ctermbg=24  gui=none cterm=none
"highlight ColorColumn ctermbg=darkgrey guibg=darkgrey

let base16colorspace=256 " Access colors present in 256 colorspace
set t_Co=256 " 256 color mode

colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark="hard"
