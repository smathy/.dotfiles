## Installation

    cd ~
    git clone git://github.com/smathy/.dotfiles.git
    cd ~/.dotfiles
    git submodule update --init
    cd ~

And then `ln -snf` anything you want to use into your ~ directory.

FWIW - I have the following links in my ~

    14:36:30 ~ $ lla | ack ^l
    lrwxr-xr-x    1 jk      staff   16 Oct 12  2010 .ackrc -> .dotfiles/.ackrc
    lrwxr-xr-x    1 jk      staff   26 Oct 14  2010 .bash_completion -> .dotfiles/.bash_completion
    lrwxr-xr-x    1 jk      staff   28 Oct 14  2010 .bash_completion.d -> .dotfiles/.bash_completion.d/
    lrwxr-xr-x    1 jk      staff   23 Oct 12  2010 .bash_profile -> .dotfiles/.bash_profile
    lrwxr-xr-x    1 jk      staff   16 Oct 12  2010 .digrc -> .dotfiles/.digrc
    lrwxr-xr-x    1 jk      staff   21 Oct 12  2010 .dir_colors -> .dotfiles/.dir_colors
    lrwxr-xr-x    1 jk      staff   20 Apr 12  2012 .gitignore -> .dotfiles/.gitignore
    lrwxr-xr-x    1 jk      staff   12 Oct 12  2010 .gvimrc -> .vim/.gvimrc
    lrwxr-xr-x    1 jk      staff   16 Oct 12  2010 .gvimrc_git -> .vim/.gvimrc_git
    lrwxr-xr-x    1 jk      staff   18 Oct 12  2010 .inputrc -> .dotfiles/.inputrc
    lrwxr-xr-x    1 jk      staff   16 Oct 12  2010 .irbrc -> .dotfiles/.irbrc
    lrwxr-xr-x    1 jk      staff   18 Oct 12  2010 .railsrc -> .dotfiles/.railsrc
    lrwxr-xr-x    1 jk      staff   14 Oct 12  2010 .vim -> .dotfiles/.vim/
    lrwxr-xr-x    1 jk      staff   11 May  4  2011 .vimrc -> .vim/.vimrc
    14:36:33 ~ $ 
