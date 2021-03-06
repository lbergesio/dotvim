" VIM Configuration File
" Description: Optimized for C/C++ development, but useful also for other things.
" Author: Gerhard Gappmeier
" 
"
" Changes on original file
" Description:
"  -Textwidth changed to 80, format options updated to wrap text automatically.
"  -Note on file type plugin configuration to check config overwrite
"  -Highlight long lines
"  -Automatically remove trailing whitespaces when saved
"  -Tab and indent spaces changed to 8
" Author: Leonardo Bergesio <leonardo.bergesio@i2cat.net>
"

filetype plugin on
set nocp

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" disable vi compatibility (emulation of old bugs)
set nocompatible

" use indentation of previous line
set autoindent

" use intelligent indentation for C
set smartindent

" select when using the mouse
set selectmode=mouse

" configure tabwidth and insert spaces instead of tabs
set tabstop=8        " tab width is 8 spaces
set shiftwidth=8     " indent also with 8 spaces
set noexpandtab      " NO expand tabs to spaces

" wrap lines at 80.
" Check that /usr/share/vim/vim73/ftplugin/c.vim does not overwrite
" formatoptions
set tw=80 fo=cqt wm=0

" draw bar at 80 chars
highlight ColorColumn ctermbg=gray
set colorcolumn=80

" turn line numbers on
set number

" highlight matching braces
set showmatch

" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

" Install OmniCppComplete like described on http://vim.wikia.com/wiki/C++_code_completion
" This offers intelligent C++ completion when typing ‘.’ ‘->’ or <C-o>
" Load standard tag files
" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" Install DoxygenToolkit from http://www.vim.org/scripts/script.php?script_id=987
let g:DoxygenToolkit_authorName="Leonardo Bergesio  <leonardo.bergesio@i2cat.net>"

" Enhanced keyboard mappings
"

" in normal mode F2 will save the file
nmap <F2> :w<CR>

" in insert mode F2 will exit insert, save, enters insert again
imap <F2> <ESC>:w<CR>i

" switch between header/source with F4
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" recreate tags file with F5
map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -L .srclist .<CR>

" create doxygen comment
map <F6> :Dox<CR>

" build using makeprg with <F7>
map <F7> :make<CR>

" build using makeprg with <S-F7>
map <S-F7> :make clean all<CR>

" in diff mode we use the spell check keys for merging
if &diff
  " diff settings
  map <M-Down> ]c
  map <M-Up> [c
  map <M-Left> do
  map <M-Right> dp
  map <F9> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg
else
  " spell settings
  ":setlocal spell spelllang=en
  " set the spellfile - folders must exist
  "set spellfile=~/.vim/spellfile.add
  map <M-Down> ]s
  map <M-Up> [s
endif

"
map <Leader>e :Explore<cr>
map <Leader>s :Sexplore<cr>
 
" pressing < or > will let you indent/unident selected lines
vnoremap < <gv
vnoremap > >gv

" Select all.
map <c-a> ggVG
 
" Undo in insert mode.
imap <c-z> <c-o>u

" Remove trailing whitespaces before saving
autocmd BufWritePre *.c :%s/\s\+$//e
autocmd BufWritePre *.java :%s/\s\+$//e
autocmd BufWritePre *.h :%s/\s\+$//e
autocmd BufWritePre *.cc :%s/\s\+$//e

"Highlight colums of more that 80 chars
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Maps for Ctag"
set tags+=tags;
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <F12> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
map <S-F12> :sp <CR>:exec("tag ".expand("<cword>"))<CR>

" Enable Scroll in Byobu
" set mouse=a

" Enable pathogen.vim
execute pathogen#infect()

"Configuration of color schemes. This has to be after pathogen init if some
"color schemes are installed as submodules

" turn syntax highlighting on
"set t_Co=256
syntax on

"let g:solarized_termcolors=256
"set background=dark
"colorscheme solarized
colorscheme tender
