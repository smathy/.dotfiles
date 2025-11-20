# interactive: 3 of 4
[[ -e /etc/zshrc ]] && . /etc/zshrc

if [ $UID -eq 0 ]; then NCOLOR="red"; PR="#"; else NCOLOR="yellow"; PR="$" fi

export PROMPT='%F{$NCOLOR}%~ %f'
export RPROMPT='%F{$NCOLOR}%p%F{green}$(current_git_branch)%F{#74c7ec}$(current_git_hash)%F{red}$(current_git_stash)%f %*'

export ZSH_THEME_GIT_PROMPT_PREFIX="git:"
export ZSH_THEME_GIT_PROMPT_SUFFIX=""
export ZSH_THEME_GIT_PROMPT_DIRTY=" ~"
export ZSH_THEME_GIT_PROMPT_CLEAN=""

. ~/.aliases
. ~/.dotfiles/.pop.sh
. ~/.zle
. ~/.secrets
. ~/.namedirs

export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE

MANPATH="/usr/local/man"

if [ -d /opt/homebrew/opt/coreutils/libexec/gnuman ]; then
	MANPATH=/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH
fi

if [ -d /opt/homebrew/opt/gnu-sed/libexec/gnuman ]; then
  MANPATH=/opt/homebrew/opt/gnu-sed/libexec/gnuman:$MANPATH
fi
export MANPATH

export HYPHEN_INSENSITIVE="true"
export HOMEBREW_AUTO_UPDATE_SECS=86400

setopt extendedglob
setopt no_hist_verify extended_history inc_append_history share_history hist_expire_dups_first hist_ignore_dups hist_ignore_all_dups hist_find_no_dups hist_ignore_space hist_save_no_dups
unsetopt nomatch

export LESS=-ifR

export EDITOR=nvim
export VISUAL=v

export RIPGREP_CONFIG_PATH=~/.rgrc
export ERL_AFLAGS="-kernel shell_history enabled"

# export ANDROID_HOME=$HOME/Library/Android/sdk
# export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

sauces=(./.aliases ../.aliases "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh")
for f in $sauces; do
	[ -f $f ] && . $f
done

. <(fzf --zsh)

. ~/.functions
