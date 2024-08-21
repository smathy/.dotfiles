if [ $UID -eq 0 ]; then NCOLOR="red"; PR="#"; else NCOLOR="yellow"; PR="$" fi

PROMPT='%F{$NCOLOR}%~ %f'
RPROMPT='%F{$NCOLOR}%p%F{green}$(current_git_branch)%F{cyan}$(current_git_hash)%F{red}$(current_git_stash)%f %*'

ZSH_THEME_GIT_PROMPT_PREFIX="git:"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=" ~"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# See http://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxbxbxbxbxbxbx"
export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=31;40:cd=31;40:su=31;40:sg=31;40:tw=31;40:ow=31;40:"

. ~/.aliases
. ~/.functions
. ~/.dotfiles/.pop.sh
. ~/.zle
. ~/.secrets
. ~/.namedirs

setopt no_hist_verify extendedglob
unsetopt nomatch

eval "$(dircolors ~/.dircolors)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

export LESS=$LESS\ -ifR

export EDITOR=nvim
export VISUAL=v

export RIPGREP_CONFIG_PATH=~/.rgrc
export ERL_AFLAGS="-kernel shell_history enabled"

# export ANDROID_HOME=$HOME/Library/Android/sdk
# export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

. $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
