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

export PATH="/opt/homebrew/opt/gpatch/libexec/gnubin:/opt/homebrew/opt/gawk/libexec/gnubin:/opt/homebrew/opt/gnu-tar/libexec/gnubin:/opt/homebrew/opt/findutils/libexec/gnubin:/opt/homebrew/opt/coreutils/libexec/gnubin:/opt/homebrew/opt/llvm@18/bin:/opt/homebrew/opt/make/libexec/gnubin:$PATH"
export PATH="./bin:$HOME/bin:$PATH"
