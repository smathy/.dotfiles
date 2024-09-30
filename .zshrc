if [ $UID -eq 0 ]; then NCOLOR="red"; PR="#"; else NCOLOR="yellow"; PR="$" fi

PROMPT='%F{$NCOLOR}%~ %f'
RPROMPT='%F{$NCOLOR}%p%F{green}$(current_git_branch)%F{#74c7ec}$(current_git_hash)%F{red}$(current_git_stash)%f %*'

ZSH_THEME_GIT_PROMPT_PREFIX="git:"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=" ~"
ZSH_THEME_GIT_PROMPT_CLEAN=""

. ~/.aliases
. ~/.dotfiles/.pop.sh
. ~/.zle
. ~/.secrets
. ~/.namedirs

setopt no_hist_verify extendedglob
unsetopt nomatch

export LESS=$LESS\ -ifR

export EDITOR=nvim
export VISUAL=v

export RIPGREP_CONFIG_PATH=~/.rgrc
export ERL_AFLAGS="-kernel shell_history enabled"

# export ANDROID_HOME=$HOME/Library/Android/sdk
# export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

sauces=(./.aliases ../.aliases "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" "$HOME/.iterm2_shell_integration.zsh" "$HOME/Library/Group Containers/FELUD555VC.group.com.egnyte.DesktopApp/CLI/egcli.inc")
for f in $sauces; do
	[ -f $f ] && . $f
done

. <(fzf --zsh)

. ~/.functions
