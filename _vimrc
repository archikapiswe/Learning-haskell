" File: _vimrc             
" Version: 1
" Author: D M Kulkarni
" Derivative_of: the original vimrc claimed to be written by Seth Mason See
"                Credit I have added some settings/commands at the end to 
"                suit my purpose
" Credit: Seth Mason (URL - http://www.slackorama.com/projects/vim/vimrc.html) 
" Created: 19 Nov 2003 10:20:19
" All my Vim commands for the taking

" Use Vim settings, rather then Vi settings (much better!).
set nocompatible

" Turn on the verboseness to see everything vim is doing.
"set verbose=2

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Spaces instead of tabs
set expandtab

" Always  set auto indenting on
set autoindent

" select when using the mouse
set selectmode=mouse


" do not keep a backup files 
set nobackup
set nowritebackup

if has('gui_running')
    " i like about 80 character width lines
    set textwidth=78
    " Set 52 lines for the display
    set lines=52
    " 2 for the status line.
    set cmdheight=2
    " add columns for the Project plugin
    set columns=110
    " enable use of mouse
    set mouse=a
    " for the TOhtml command
    let html_use_css=1
endif


" show the cursor position all the time
set ruler       

" show (partial) commands
set showcmd     

" do incremental searches (annoying but handy);
set incsearch 

" Show  tab characters. Visual Whitespace.
set list
set listchars=tab:>.

" Set ignorecase on
set ignorecase

" smart search (override 'ic' when pattern has uppers)
set scs

" Set 'g' substitute flag on
" set gdefault

" Set status line
set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\ %4l,%02c%2V\ %P%*

" Always display a status line at the bottom of the window
set laststatus=2

" Set vim to use 'short messages'.
" set shortmess=a

" Insert two spaces after a period with every joining of lines.
" I like this as it makes reading texts easier (for me, at least).
set joinspaces

" showmatch: Show the matching bracket for the last ')'?
set showmatch

" allow tilde (~) to act as an operator -- ~w, etc.
set notildeop


" Java specific stuff
let java_highlight_all=1
let java_highlight_debug=1
let java_ignore_javadoc=1
let java_highlight_functions=1
let java_mark_braces_in_parens_as_errors=1

" highlight strings inside C comments
let c_comment_strings=1

" Commenting blocks of code.
 autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
 autocmd FileType sh,ruby,python   let b:comment_leader = '# '
 autocmd FileType conf,fstab       let b:comment_leader = '# '
 autocmd FileType tex              let b:comment_leader = '% '
 autocmd FileType mail             let b:comment_leader = '> '
 autocmd FileType vim              let b:comment_leader = '" '
 noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
 noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>


" Commands for :Explore
let g:explVertical=1    " open vertical split winow
let g:explSplitRight=1  " Put new window to the right of the explorer
let g:explStartRight=0  " new windows go to right of explorer window


if has("gui")
  " set the gui options to:
  "   g: grey inactive menu items
  "   m: display menu bar
  "   r: display scrollbar on right side of window
  "   b: display scrollbar at bottom of window
  "   t: enable tearoff menus on Win32
  "   T: enable toolbar on Win32
  set go=gmr
  set guifont=Courier
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set nohlsearch
endif


" ************************************************************************
" C O M M A N D S
"

"switch to directory of current file
command! CD cd %:p:h

" ************************************************************************
" K E Y   M A P P I N G S
"
map <Leader>e :Explore<cr>
map <Leader>s :Sexplore<cr> 

" pressing < or > will let you indent/unident selected lines
vnoremap < <gv
vnoremap > >gv

" Don't use Ex mode, use Q for formatting
map Q gq

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

" Make tab in v mode work like I think it should (keep highlighting):
vmap <tab> >gv
vmap <s-tab> <gv

" map ,L mz1G/Last modified:/e<Cr>CYDATETIME<Esc>`z
map ,L    :let @z=TimeStamp()<Cr>"zpa
map ,datetime :let @z=strftime("%d %b %Y %X")<Cr>"zpa
map ,date :let @z=strftime("%d %b %Y")<Cr>"zpa

" Map <c-s> to write current buffer.
map <c-s> :w<cr>
imap <c-s> <c-o><c-s>
imap <c-s> <esc><c-s>

"allow j and k to naviagete within a line
nmap j gj
nmap k gk
" Buffer naviation
map <M-Left> :bprevious<CR>
map <M-Right> :bnext<CR>


" Select all.
map <c-a> ggVG

" Undo in insert mode.
imap <c-z> <c-o>u

" Load my color scheme 
"colorscheme slack

set wrap linebreak nolist
filetype plugin on
set nocp 
" ************************************************************************
" B E G I N  A U T O C O M M A N D S
"
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Normally don't automatically format 'text' as it is typed, only do this
  " with comments, at 79 characters.
  au BufNewFile,BufEnter *.c,*.h,*.java,*.jsp set formatoptions-=t tw=79


  " add an autocommand to update an existing time stamp when writing the file 
  " It uses the functions above to replace the time stamp and restores cursor 
  " position afterwards (this is from the FAQ) 
  autocmd BufWritePre,FileWritePre *   ks|call UpdateTimeStamp()|'s


endif " has("autocmd")

" GUI ONLY type stuff.
if has("gui")
  :menu &MyVim.Current\ File.Convert\ Format.To\ Dos :set fileformat=dos<cr> :w<cr>
  :menu &MyVim.Current\ File.Convert\ Format.To\ Unix :set fileformat=unix<cr> :w<cr>
  :menu &MyVim.Current\ File.Remove\ Trailing\ Spaces\ and\ Tabs :%s/[	]*$//g<cr>
  :menu &MyVim.Current\ File.Remove\ Ctrl-M :%s/^M//g<cr>
  :menu &MyVim.Current\ File.Remove\ All\ Tabs :retab<cr>
  :menu &MyVim.Current\ File.To\ HTML :runtime! syntax/2html.vim<cr>
  " these don't work for some reason
  ":amenu &MyVim.Insert.Date<Tab>,date <Esc><Esc>:,date<Cr>
  ":amenu &MyVim.Insert.Date\ &Time<Tab>,datetime <Esc><Esc>:let @z=YDATETIME<Cr>"zpa
  :amenu &MyVim.Insert.Last\ &Modified<Tab>,L <Esc><Esc>:let @z=TimeStamp()<CR>"zpa
  :amenu &MyVim.-SEP1- <nul>
  :amenu &MyVim.&Global\ Settings.Toggle\ Display\ Unprintables<Tab>:set\ list!	:set list!<CR>
  :amenu &MyVim.-SEP2- <nul>
  :amenu &MyVim.&Project :Project<CR>

  " hide the mouse when characters are typed
  set mousehide
endif

" ************************************************************************
" A B B R E V I A T I O N S 
"
abbr #b /************************************************************************
abbr #e  ************************************************************************/

" abbreviation to manually enter a timestamp. Just type YTS in insert mode 
iab YTS <C-R>=TimeStamp()<CR>

" Date/Time stamps
" %a - Day of the week
" %b - Month
" %d - Day of the month
" %Y - Year
" %H - Hour
" %M - Minute
" %S - Seconds
" %Z - Time Zone
iab YDATETIME <c-r>=strftime(": %a %b %d, %Y %H:%M:%S %Z")<cr>


" ************************************************************************
"  F U N C T I O N S
"

" first add a function that returns a time stamp in the desired format 
if !exists("*TimeStamp")
    fun TimeStamp()
        return "Current Time: " . strftime("%d %b %Y %X")
    endfun
endif

" searches the first ten lines for the timestamp and updates using the
" TimeStamp function
if !exists("*UpdateTimeStamp")
function! UpdateTimeStamp() 
   " Do the updation only if the current buffer is modified 
   if &modified == 1 
       " go to the first line
       exec "1" 
      " Search for Last modified: 
      let modified_line_no = search("Last-modified:") 
      if modified_line_no != 0 && modified_line_no < 10 
         " There is a match in first 10 lines 
         " Go to the : in modified: 
         exe "s/Last-modified: .*/" . TimeStamp()
     endif
 endif
 endfunction
endif

" settings by D M Kulkarni

" keep 100000 lines of command line history
set history=10000
" huge undo limit (should work smoothly with today's machines with 
" gigabytes of memory)
" (but in case, it causes memory trouble, change undolevels to a lower value)
set undolevels=10000
set hidden
set autoindent
set nolbr
"uncomment the following if you want to show line numbers
set number
set title                

" shuts up vim, no more beeping and shouting
set visualbell          
set noerrorbells       

" when you have git, why bother vim to do backup?
set nobackup
"set noswapfile

" I like 2 spaces for indenting
set shiftwidth=2

" I like 2 stops
set tabstop=2

"auto indent and automatic insertion of > for lhs (literal haskell) files
autocmd FileType lhaskell setlocal formatoptions+=ro

" Haskell is very space, indent and alignment sensitive
" vim can help you deal with these issues with these settings
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

"some mappings
map ; :

" I still love to use the good old TurboC editor shortcut key to save file
nmap <f2> <esc>:w<cr>
" to insert an empty line without manually entering/exiting insert mode
nmap <f3> o<esc>

" setting to help speed up English typing
" turn on spell check when writing Englsih
" setlocal spell spelllang=en_us

"insert mode shortcuts to speed up typing in certain cases
imap ddb Believe it or not but 
imap ddi Isn't this a fact that 
imap dds Don't we see that 
imap ddt Don't you think that 
imap ltn Linus
imap ftd FIT-dbms
imap fto FIT-os
imap fts FIT-se
imap ftp FIT-phd

" bash like tab completion to help cycle through matching options
" when you press tab on command line
set wildmode=longest,list,full
set wildmenu

