"source $HOME/.vimrc
map <F6> :so $HOME/.vimrc:so $HOME/.gvimrc

set guifont=Monaco:h12
"set guifont=Bitstream\ Vera\ Sans\ Mono:h10
set encoding=utf-8
set lines=76
if &diff
  set columns=250
else
  set columns=150
endif
set textwidth=80
set guioptions-=T
set guioptions-=m

map <S-D-Right> gt
map <S-D-Left> gT

set mousefocus
set transp=5
