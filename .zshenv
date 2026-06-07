# all: 1 of 4
unsetopt global_rcs

[[ -e /etc/zprofile ]] && . /etc/zprofile

eval "$(/opt/homebrew/bin/brew shellenv)"

export ZSH=$HOME/.oh-my-zsh
. ~/.xdgenv

plugins=(bundler macos rake ruby gitfast mise brew direnv ngrok)

FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"

source $ZSH/oh-my-zsh.sh

export GOPATH=~/work/go
PATH=$GOPATH/bin:$PATH

export PGDATABASE=postgres

export RUBYOPT=--enable-frozen-string-literal
export RUBY_DEBUG_BB=1

# OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES fixes "Incomplete response received from application" error
# # Might be related to: https://github.com/rails/rails/issues/38560
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

export RAILS_LOG_LEVEL=debug
export RUBY_YJIT_ENABLE=1
export NO_COVERAGE=1

export HOMEBREW_NO_ENV_HINTS=1

path=(
  ./bin
  $HOME/bin
  $XDG_BIN_HOME
  /opt/homebrew/opt/{gsed,coreutils}/libexec/gnubin
  /opt/homebrew/opt/{llvm@18,postgresql@15}/bin
  $path
)
