#Courtesy Greg Fast
#git://git.drwholdings.com/gfast/dot-bash.git

if [ -f ~/jeb-scripts/.git_aliases ]; then
	. ~/jeb-scripts/.git_aliases
fi

#Courtesy Greg Fast
#git://git.drwholdings.com/gfast/dot-bash.git
#if [ -f ~/jeb-scripts/git.bash ]; then
#	. ~/jeb-scripts/git.bash
#fi

l() {
if [ -z "$1" ]
then
  filename="apervita_localdev.log"
else
  filename="apervita_$1.log"
fi

tail -F /apervita/logfiles/$filename | awk '
$0 ~ /INFO/ {print "\033[32m" $0 "\033[39m"}
$0 ~ /ERROR/ {print "\033[31m" $0 "\033[39m"}
$0 !~ /INFO|ERROR/ {print $0}
'
}
export -f l

t() {
tail -F $1 | awk '
$0 ~ /INFO/ {print "\033[32m" $0 "\033[39m"}
$0 ~ /ERROR/ {print "\033[31m" $0 "\033[39m"}
$0 !~ /INFO|ERROR/ {print $0}
'
}
export -f t

alias src='cd ~/src/apervita'
alias z=" echo ''; echo '';  echo ''; echo ''; echo ---------------------------------------------------------------------------------; echo ''; echo ''; echo ''; echo ''"
alias ll='ls -la'
alias less='less -R'
alias date='date -R'
t() {
tail  "$@" | sed 's#WARN#\x1b[33m&\x1b[0m#; s#ERROR#\x1b[31m&\x1b[0m#; s#INFO#\x1b[32m&\x1b[0m#'
}
