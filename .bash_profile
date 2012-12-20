# .bashrc:

export EDITOR=$(which vim)
export VISUAL=$(which mvim)
export PAGER=/usr/bin/less
export PATH=~/bin:./node_modules/.bin:./script:./bin:./:$PATH:/opt/local/sbin:/sbin:/usr/sbin
export LANG=en_US.utf-8
export LC_ALL=en_US.utf-8
export LESS=$LESS\ -ifR
export HISTSIZE=20000
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignorespace:erasedups

shopt -s histappend cdspell

current_git_branch() {
  git_exists=`git branch 2>/dev/null | sed -ne'/^\* /s///p'`

  if [[ "$git_exists" != "" ]]; then
    if [[ "$git_exists" == "(no branch)" ]]; then
      git_exists="\e[31m\]$git_exists\e[0m\]"
    fi
    echo "$git_exists "
  fi
  unset git_exists
}

current_git_stash() {
  git_stash=`git stash list 2>/dev/null | /usr/bin/wc -l | sed 's/ *//g'`

  if [[ "$git_stash" != "" && $git_stash > 0 ]]; then
    echo "[$git_stash] "
  fi
  unset git_stash
}

PROMPT_COMMAND=$PROMPT_COMMAND${PROMPT_COMMAND:+;}'PS1="\t \[\e[32m\]$(current_git_branch)\[\e[0m\]\[\e[35m\]$(current_git_stash)\[\e[0m\]\[\e[33m\]\w\[\e[0m\] \[\e[1m\]\$\[\e[0m\] "'
export RI=--format=ansi

export EC2_HOME=/opt/local
export EC2_PRIVATE_KEY=~/.ec2/pk-AXG2P53OPV57GLYFMK2NIJDMT5KD7LB6.pem
export EC2_CERT=~/.ec2/cert-AXG2P53OPV57GLYFMK2NIJDMT5KD7LB6.pem

export ACK_COLOR_MATCH=magenta

export TAG=`date +%Y-%m-%d`

export PHP_ENV=development

alias g-cpan="sudo g-cpan"
alias :q="exit"

func_file=$HOME/bin/functions.bash

alias sf=". $func_file"
alias vf="v $func_file"

alias sb='. ~/.bash_profile'
alias vb='v ~/.bash_profile'
alias vh='sudo mvim /etc/hosts'

alias gh=~/bin/gh.sh
alias lh=~/bin/lh.pl

alias RM=rm\ -rf

alias gt='export TAG=`date +%Y-%m-%d` && git pull && git tag -f $TAG && git push --tags'
alias ss='java -jar ~/work/selenium-server.jar > /dev/null 2>&1 &'

alias sv='sudo mvim'

alias mem='cd ~/personal/memory'
alias ao='cd ~/work/ao'

alias vv='v -S .git/.vimsession'
alias ce="VISUAL=cronvim crontab -e"

gp() { git push --set-upstream origin $(branch.sh); }

source $func_file

tags() {
  dir=$1
  if [[ "$dir" == "" ]]; then
    dir='.'
  fi

  if [[ ! -d $dir ]]; then
    echo $'\e[1;31m'Error: $dir is not a directory.$'\e[0m'
    return 1
  fi

  ctags -Rf "$dir/.tags" "$dir"
}

vd() {
  v ${1/:/ +}
}

md() {
  mkdir --parents $1
  cd $1
}

udevi() { udevinfo -a -p $(udevinfo -q path -n /dev/$1) | egrep 'model|vendor|product'; }
