# all: 1 of 4
unsetopt global_rcs

[[ -e /etc/zprofile ]] && . /etc/zprofile

eval "$(/opt/homebrew/bin/brew shellenv)"

export ZSH=$HOME/.oh-my-zsh

plugins=(bundler macos rake ruby gitfast mise brew direnv)

FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

PATH="/opt/homebrew/opt/make/libexec/gnubin:/opt/homebrew/opt/postgresql@15/bin:$PATH"

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

path=(
  ./bin
  $HOME/bin
  /opt/homebrew/opt/{gpatch,gawk,gnu-tar,findutils,coreutils}/libexec/gnubin
  /opt/homebrew/opt/llvm@18/bin
  $path
)
