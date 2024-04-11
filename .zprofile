eval "$(/opt/homebrew/bin/brew shellenv)"

export ZSH=$HOME/.oh-my-zsh
HYPHEN_INSENSITIVE="true"
plugins=(bundler macos rake ruby gitfast asdf)

MANPATH="/usr/local/man"

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

PATH="./bin:$HOME/bin:$PATH"

export LDFLAGS="-L/opt/homebrew/opt/postgresql@15/lib"
export CPPFLAGS="-I/opt/homebrew/opt/postgresql@15/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/postgresql@15/lib/pkgconfig"

export REDIS_URL=redis://localhost:6379
export PGDATABASE=postgres
export PATH MANPATH
