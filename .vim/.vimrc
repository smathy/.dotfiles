map <F5> :split $HOME/.vimrc
map <S-F5> :split $HOME/.gvimrc
map <F6> :so $HOME/.vimrc
map <F8> :let ttt=tempname():let smod=&mod:exec ':w! '.ttt:let @*=system('diff -bBu "'.bufname('%').'" "'.ttt.'"'):let @_=system('rm '.ttt):let &mod=smod

map <C-D> :call Chdir()<CR>

nnoremap <Down> g<Down>
nnoremap <Up> g<Up>

set viminfofile=~/.vim/.viminfo

function! Chdir()
	if expand('%:h') != ""
		cd %:h
	endif
	pwd
endfunction

command! BB call Copy_file_line()

set diffopt+=vertical
noremap g<Right> :call G_head()<ENTER>
noremap g<Left>  :call G_merge()<ENTER>

function! G_head()
  diffg //2
  diffu
endfunction

function! G_merge()
  diffg //3
  diffu
endfunction

function! Copy_file_line()
  let @* = printf('%s:%d', @%, line('.'))
endfunction

function! Set_vimsession()
  let cwd = getcwd()
  while ! ( isdirectory( cwd . "/.git" )  || cwd == "/" )
    let cwd = simplify( cwd . "/.." )
  endwhile
  let g:vimsession = cwd . "/.git/.vimsession"
endfunction

au VimEnter * call Set_vimsession()
function! Make_vimsession()
  execute("mksession! " . g:vimsession)
endfunction

command! SS call Make_vimsession()

command! -nargs=1 T :tab sb <args>

syntax on

set background=dark
colorscheme solarized
