#!/bin/bash

pg() { ps uxp $(pgrep -fi "$1"); }

pd() { open http://php.net/$1; }
pa() { php -a 2>/dev/null; }

kh() { sed -i'' -e"$1d" ~/.ssh/known_hosts; }

gc() { git lc $1...master; }

RLAST=test

r() {
  if [[ "$*" != "" ]]; then
    RLAST=$*
  fi
  rake $RLAST | tapout runtime
}

get_url() {
  if [[ "$branch" == "" ]]; then
    target=''
  else
    target="branches/$branch"
    svn info $root/$target >/dev/null 2>&1
    if [ $? -gt 0 ]; then
      target="tags/$branch"
      svn info $root/$target >/dev/null 2>&1
      if [ $? -gt 0 ]; then
        target=''
        return 1
      fi
    fi
  fi
}

log() {
  days='3'
  soc='--stop-on-copy'
  verbose=''
  while getopts fvd: OPT; do
    case "$OPT" in
      d) days=$OPTARG
      ;;
      f) soc=''
      ;;
      v) verbose='-v'
      ;;
    esac
  done

  shift `expr $OPTIND - 1`

  target=''
  if [[ "$1" != "" ]]; then
    branch=$1
    get_url
  fi

  url=''
  if [[ "$target" == "" ]]; then
    url=$1
  else
    url="$root/$target"
  fi

  date=`gdate --date="$days days ago" +%Y-%m-%d`

  svn log -r{$date}:HEAD $verbose $soc $url
  echo $'\e[1;32m'Log $target since $date$'\e[0m'

  unset OPTSTRING OPTIND OPTARG OPT days soc verbose target date url
}

sw() {
  branch=$1
  target=''
  get_url

  if [[ "$target" == "" ]]; then
    target='trunk'
  fi

  svn sw $root/$target
  if [ $? == 0 ]; then
    echo $'\e[1;32m'Switched to $target$'\e[0m'
  fi
  unset branch target
}

br() {
  sub='branches'

  while getopts tld:r: OPT; do
    case "$OPT" in
      t) sub='tags'
         ;;
      r|d) leaf=$OPTARG
         remove='1'
         ;;
      l) list='1'
         ;;
    esac
  done

  shift `expr $OPTIND - 1`

  if [[ "$remove" == "1" ]]; then
    svn rm $root/$sub/$leaf -m"Removing $leaf from $sub"
    if [ $? == 0 ]; then
      echo $'\e[32m'Removed $leaf from $sub$'\e[0m'
    else
      echo $'\e[31m'Failed to remove $leaf from $sub$'\e[0m'
    fi
  elif [[ "$list" == "1" || "$1" == "" ]]; then
    svn ls $root/$sub
  else
    leaf=$1
    svn cp $root/trunk $root/$sub/$leaf -m"Branching trunk to $sub/$leaf"
    if [ $? == 0 ]; then
      svn sw $root/$sub/$leaf
      if [ $? == 0 ]; then
        echo $'\e[1;32m'Switched to $sub/$leaf$'\e[0m'
      fi
    fi
  fi

  unset OPTSTRING OPTIND OPTARG OPT leaf sub list remove
}

mg() {
  command="merge"
  msg='Merging'

  while getopts lir:c: OPT; do
    case "$OPT" in
      i) opts="$opts --reintegrate"
         ;;
      l) command="mergeinfo --show-revs eligible"
         msg="Eligibles for"
         ;;
      r) opts="$opts -r$OPTARG"
      ;;
      c) opts="$opts -c$OPTARG"
      ;;
    esac
  done

  shift `expr $OPTIND - 1`

  if [[ "$1" == "" || "$1" == "trunk" ]]; then
    # no arg so assume a trunk merge
    echo $'\e[1;32m'$msg trunk$'\e[0m'
    svn $command $opts $root/trunk .
  else
    branch=$1
    get_url
    echo $'\e[1;32m'$msg $target$'\e[0m'
    svn $command $opts $root/$target .
  fi

  unset OPTSTRING OPTIND OPTARG OPT opts command msg branch target
}

function r18 {
  r_comb 1.8 "ruby rb-rubygems"
}

function r19 {
  r_comb 1.9 ruby19
}

function r_comb {
  for i in `port contents $2 | grep /bin/`
  do
    DIR=$(dirname $i)
    FILE=$(basename ${i/[0-9]*/})
    VFILE=${FILE}$1

    pushd $DIR > /dev/null
    if [ ! -L $FILE ]; then
      sudo mv $FILE ${FILE}1.8
    fi
    sudo ln -snf $VFILE $FILE
    popd > /dev/null
  done
}

function portv {
  svn log http://svn.macports.org/repository/macports/trunk/dports/$(port list $1 | cut -c48-)/Portfile
}

function e {
  echo 
}

function h {
  cat $1 | haste | pbcopy
}

function rt {
  if [ "$1" == "" ]; then
    echo Need at least one arg.
    return
  fi

  x=$2
  if [ "$x" == "" ]; then
    x=$(git log -n1 --format=%d --tags=v* | sed "s/.*\(v\([0-9]\+\.*\)\{3\}\).*/\1/")
  fi
  git checkout master
  git pull
  git fetch --tags
  git tag --force $1 $x
  git push --tags --force
  unset x
}

function dnscache {
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
}

reset_db() {
  base_db="peerstreet"
  bup=$1
  root_db="postgres"
  for db in ${base_db} ${base_db}_test; do
    psql -d $root_db -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '$db' AND pid <> pg_backend_pid()"
    psql -d $root_db -c "DROP DATABASE $db"
    psql -d $root_db -c "CREATE DATABASE $db"
    pg_restore -d $db $bup
  done
}

current_git_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
}

current_git_stash() {
  cgs=$(git stash list 2>/dev/null)
  if [[ "$cgs" != "" ]]; then
    cgs=$(echo $cgs | wc -l)
  fi
  echo $cgs
  unset cgs
}
