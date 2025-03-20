eval "$(/opt/homebrew/bin/brew shellenv)"

export ZSH=$HOME/.oh-my-zsh
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HOMEBREW_AUTO_UPDATE_SECS=86400

plugins=(bundler macos rake ruby gitfast mise brew direnv)

MANPATH="/usr/local/man"
FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

if [ -d /opt/homebrew/opt/coreutils/libexec/gnubin ]; then
  PATH=/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH
	MANPATH=/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH
fi

if [ -d /opt/homebrew/opt/gnu-sed/libexec/gnubin/ ]; then
  PATH=/opt/homebrew/opt/gnu-sed/libexec/gnubin/:$PATH
  MANPATH=/opt/homebrew/opt/gnu-sed/libexec/gnuman:$MANPATH
fi

PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

source $ZSH/oh-my-zsh.sh

export GOPATH=~/work/go
PATH=$GOPATH/bin:$PATH

export PGDATABASE=postgres

export RUBY_GC_HEAP_INIT_SLOTS=1250000
export RUBY_HEAP_SLOTS_INCREMENT=100000
export RUBY_GC_MALLOC_LIMIT=30000000
export RUBY_HEAP_FREE_MIN=12500
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1.2
export RUBY_GC_MALLOC_LIMIT_GROWTH_FACTOR=1.4
export RUBYOPT=--enable-frozen-string-literal

# OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES fixes "Incomplete response received from application" error
# # Might be related to: https://github.com/rails/rails/issues/38560
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

export RAILS_LOG_LEVEL=debug
export RUBY_YJIT_ENABLE=1
export NO_COVERAGE=1

eval "$(/opt/homebrew/bin/brew shellenv)"

PATH="./bin:$HOME/bin:$PATH"
export PATH MANPATH
