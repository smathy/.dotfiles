call pathogen#runtime_append_all_bundles() 

set nocompatible
behave xterm

set popt=paper:letter
set undofile
set undodir=~/.vim/undo

set fileencodings=ucs-bom,utf-8,latin1,default

set backupskip=/tmp/*,/private/tmp/*
set backupdir=$TEMP,.
set selectmode=mouse
set nobackup
"set sidescrolloff=10 sidescroll=1 nowrap
set wrap

set foldmethod=marker

set wildmenu wildmode=list:longest,list:full

set tags=~/.tags,.tags,../.tags,../../.tags,../../../.tags

set backspace=2
set whichwrap=<,>,[,],b,s

set smarttab expandtab
set tabstop=2 shiftwidth=2
set autoindent cindent

set ignorecase smartcase

set statusline=%<%f\ %h%m%r%=%-30.30{synIDattr(synID(line(\".\")\,col(\".\")\,0)\,\"name\")}%l,%c%V%13.13P
set printheader=%<%t%=Page\ %N

set helpheight=10
set keywordprg=

set cmdheight=2
set formatoptions=crq
set linebreak
set showbreak=^\ 
set ruler

set history=50
set showcmd
set hlsearch incsearch

set hidden

filetype plugin indent on

set viminfo='100,\"50,n~/.viminfo

set modeline

if !exists("g:done_path_adjustment")
  let g:done_path_adjustment = 1
  let &path = &path . "," . substitute( $PATH, ':', ',', 'g')
  let &path = substitute( &path, '\\', '/', 'g')
  let &path = substitute( &path, ' ', '\\ ', 'g')
endif

map <F4> :set ft=
map <S-F4> :set path+=

map <F5> :split $HOME/.vimrc
map <S-F5> :split $HOME/.gvimrc
map <F6> :so $HOME/.vimrc
map <F8> :let ttt=tempname():let smod=&mod:exec ':w! '.ttt:let @*=system('diff -bBu "'.bufname('%').'" "'.ttt.'"'):let @_=system('rm '.ttt):let &mod=smod
map <F11> ivim: set sts=2 sw=2 ts=8 co=90:<Up>
imap <F11> vim: set sts=2 sw=2 ts=8 co=90:
map <F13> :split $VIMRUNTIME/

imap <F13> <Insert>

nmap <S-Tab> 

let macvim_skip_cmd_opt_movement=1
nmap <M-Right> W
nmap <M-Left> B

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

vmap  "xc# {{{}}}P-A 

noremap ]] ][
noremap ][ ]]

map j Jx
map \ :s<Up>
map Y y$

noremap  g
noremap g 
noremap  g
noremap g 

noremap <M-Up> :bn
noremap <M-Down>   :bp
noremap <M-Home>     :br
noremap <M-End>      :bl
noremap <M-BS>      :bd
noremap <M-Del>      :bd
noremap <Del>        :bd
map <M-Insert>   gf
map <M-F15>      :buffers

map <D-Left> :tabprevious
imap <D-Left> :tabprevious
map <D-Right> :tabnext
imap <D-Right> :tabnext

vmap <C-Insert> "+y
vmap <C-Del> "+d
map <S-Insert> "+p

map <C-D> :call Chdir()<CR>

nnoremap <Down> g<Down>
nnoremap <Up> g<Up>

function! Chdir()
	if expand('%:h') != ""
		cd %:h
	endif
	pwd
endfunction

perl << EOF
sub find_bin {
  require FindBin;
  chomp( my $str = shift);

  $str =~ s/^\s*use\s+lib\s*//;
  $str =~ s/;[^;]*$//;

  my @libs = eval $str;
  my $name = VIM::Eval q(fnamemodify( bufname('%'), ':p:s?._Drive.*?D_Drive/Apps/PerlModules?'));
  push @libs => $name if grep /^D:.Apps.PerlModules.?/i => @libs;
  if( @libs)
  {
    VIM::SetOption( 'path+='. join ',' => @libs);
  }
}

sub find_php_libs {
  require Cwd;
  my $cwd = Cwd::getcwd();
  until( -f "${cwd}/config/_apache.conf.erb" || $cwd eq '/' ) {
    $cwd = Cwd::realpath("$cwd/..");
  }

  if( open IN, "${dotdots}config/apache.conf" ) {
    while(<IN>) {
      if( /include_path\s+['"]([^'"]+)/ ) {
        my @dirs = grep /^[^.]/ => split /:/ => $1;
        my(undef, $path) = VIM::Eval '&path';
        VIM::SetOption 'path+='. join ',' => @dirs;
      }
    }
    close IN;
  }
}
EOF

function! P_proc(str)
   perl find_bin a:str
endfunction

function! Add_php_libs()
  perl find_php_libs
  set inex=""
  set sua+=.php
endfunction

function! Add_perl_libs()
  normal mc
  silent! normal ``
  normal mp
  normal gg
  while search( '^\s*use lib', 'W') > 0
    call P_proc( getline('.'))
  endwhile
  normal `p
  normal `c
endfunction

function! Add_history()
  normal mc
  normal gg
  if search( '^[#-]\+ history$', 'W') > 0
    if search( '^\s*$', 'W') > 0
      normal mx
      if search( '^[#-]\+\s\+\d\+\.\d\+', 'bW') > 0
        normal yy
        normal 'x
        if search( '^[#-]\+\s\+\S', 'bW') > 0
          normal p
          normal w
          normal E
          normal 
          normal W
          normal D
perl << EOF
          my($y,$m,$d) = (localtime)[5,4,3];
          $y += 1900; ++$m;
          VIM::DoCommand('s/$/'. sprintf( '%04d%02d%02d' => $y, $m, $d) .'  jk  /');
EOF
          nohlsearch
          normal `c
          normal ``
        endif
      endif
    endif
  endif
endfunction

au BufNewFile,BufRead *.tpl setf smarty
au BufNewFile,BufReadPre *.java imap /** /** *<BS>**/<Up>	
au BufNewFile,BufReadPre *.htm,*.html,*.vbs,*.css set ic
au BufNewFile *.htm,*.html 0read ~/.template.html
au BufReadPost,FileReadPost,FilterReadPost,StdInReadPost,BufWritePost *.pm,*.pl call Add_perl_libs()
au BufReadPost,FileReadPost,FilterReadPost,StdInReadPost,BufWritePost *.php call Add_php_libs()

au FileType ruby,eruby set omnifunc=rubycomplete#Complete

" When starting to edit a file:
"   For *.c and *.h files set formatting of comments and set C-indenting on
"   For other files switch it off
"   Don't change the sequence, it's important that the line with * comes first.
" autocmd BufRead * set formatoptions=tcql nocindent comments&
" autocmd BufRead *.c,*.h set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://

" Enable editing of gzipped files
"    read: set binary mode before reading the file
"          uncompress text in buffer after reading
"   write: compress file after writing
"  append: uncompress file, append, compress file
" autocmd BufReadPre,FileReadPre      *.gz set bin
" autocmd BufReadPost,FileReadPost    *.gz '[,']!gunzip
" autocmd BufReadPost,FileReadPost    *.gz set nobin

" autocmd BufWritePost,FileWritePost  *.gz !mv <afile> <afile>:r
" autocmd BufWritePost,FileWritePost  *.gz !gzip <afile>:r

" autocmd FileAppendPre		    *.gz !gunzip <afile>
" autocmd FileAppendPre		    *.gz !mv <afile>:r <afile>
" autocmd FileAppendPost		    *.gz !mv <afile> <afile>:r
" autocmd FileAppendPost		    *.gz !gzip <afile>:r

function! Make_vimsession()
  execute("mksession! " . g:vimsession)
endfunction

command! SS call Make_vimsession()
command! Q q!

function! Set_vimsession()
  let cwd = getcwd()
  while ! ( isdirectory( cwd . "/.git" )  || cwd == "/" )
    let cwd = simplify( cwd . "/.." )
  endwhile
  let g:vimsession = cwd . "/.git/.vimsession"
endfunction

au VimEnter * call Set_vimsession()
" au VimLeave * call Make_vimsession()
nmap ZZ :xa

command! -nargs=1 T :tab sb <args>

syntax on

set background=dark
colorscheme solarized

let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
nmap <Leader>\ :IndentGuidesToggle<CR>:set invwrap<CR>
