#!/bin/bash

__package_fig_dir() {
  if [ -x /bin/readlink ]; then
    if [ -z "$1" ]; then
      __package_fig_dir .
    else
      if [ "x$1" == "x/" ]; then
        echo ""
      else
        d=$(/bin/readlink -f "$1")
        if [ -z "$d" ]; then
          echo "" # pwd has gone missing
        else
          if [ -e "$d/package.fig" ]; then
            echo $d
          else
            __package_fig_dir $(dirname "$d")
          fi
        fi
      fi
    fi
  fi
}

__fig_u_ps1() {
  d=$(__package_fig_dir)
  if [ -n "$d" ]; then
    updated_file="$d/.fig_updated"
    if [ -e "$d/.fig/retrieve" ]; then
      updated_file="$d/.fig/retrieve"
    fi
    if [ "$d/package.fig" -nt "$updated_file" ]; then
      echo -n ' [fig -u!]'
    fi
    if [ "$d/../Api/src/Messages/Thrift/Messages.thrift" -nt "$d/generated-sources/.generate-sources" ]; then
      echo -n ' [api!]' 
    fi 
  fi
}

__git_needs_push() {
  if git rev-list master ^origin/master 2> /dev/null | egrep -q '^[0-9a-f]'; then
    echo -n ' {*}'
  fi
}

alias glo='git log --decorate --oneline --graph'
alias gl="git log --graph --format='%Cred%h%Creset %s    %Cblue%an | %ad%Creset %Cgreen%d%Creset' --date=local"
alias gs='git status'
alias go='git checkout'
alias gob='git checkout $(cat .current_release)'

if [ -e /etc/bash_completion.d/git ]; then
  source /etc/bash_completion.d/git
  export GIT_PS1_SHOWDIRTYSTATE=1
  export GIT_PS1_SHOWSTASHSTATE=1
  export PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1 " (%s)")$(__fig_u_ps1)$(__git_needs_push)\$ '
  complete -o bashdefault -o nospace -F _git_checkout go
  complete -o bashdefault -o nospace -F _git_log gl
fi

last_30_branches() {
  git branch --no-color -r | grep RC- | grep -v EEIO | cut -f2- -d/ | sort -r | head -30
}

pick_branch() {
  local fontname='-misc-fixed-medium-r-*-*-20-*-*-*-*-*-*-*'
  last_30_branches | dmenu -fn "$fontname" -p 'branch:' -nb red
}

update_pending_branch() {
  git fetch -t
  remote=$(pick_branch)
  localb=pending
  if [ -n "$1" ]; then
    localb=$1
  fi
  if [ -n "$remote" ]; then
    if git rev-parse origin/$remote 2> /dev/null; then
      echo "Switching '$localb' branch to 'origin/$remote' (^C to abort)..."
      read xyzzy
      git branch -D $localb && git checkout -t -b $localb "origin/$remote"
    else
      echo "No such branch origin/$remote"
    fi
  fi
}

