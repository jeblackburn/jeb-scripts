# bash_prompt
# a mashup of http://stevelosh.com/blog/2009/03/mercurial-bash-prompts/ and 
# http://stackoverflow.com/questions/23399183/bash-command-prompt-with-virtualenv-and-git-branch
# The various escape codes that we can use to color our prompt.
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[1;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[1;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

 # Detect whether the current directory is a git repository.
 function is_git_repository {
   git branch > /dev/null 2>&1
 }

 function set_git_branch {
   # Set the final branch string
   BRANCH=`parse_git_branch`
   local TIME=`fmt_time` # format time for prompt string
 }

 function is_hg_repo {
    hg branch > /dev/null 2>&1
 }

 function hg_branch() {
    hg branch 2> /dev/null | awk '{print $1}'
 }

 function parse_git_branch() {
   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
 }

 function parse_git_dirty() {
   [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
 }

 fmt_time () { #format time just the way I likes it
     datevar=`date +%p`
     if [ -n $datevar ] && [ "$datevar" = "PM" ]; then
#     if [ `date +%p` = "PM" ]; then
         meridiem="pm"
     else
         meridiem="am"
     fi
     date +"%l:%M:%S$meridiem"|sed 's/ //g'
 }

 # Return the prompt symbol to use, colorized based on the return value of the
 # previous command.
 function set_prompt_symbol () {
   if test $1 -eq 0 ; then
       PROMPT_SYMBOL="\$"
   else
       PROMPT_SYMBOL="${LIGHT_RED}\$${COLOR_NONE}"
   fi
 }

 # Determine active Python virtualenv details.
 function set_virtualenv () {
   if test -z "$VIRTUAL_ENV" ; then
       PYTHON_VIRTUALENV=""
   else
       PYTHON_VIRTUALENV="${BLUE}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE} "
   fi
 }

 # Set the full bash prompt.
 function set_bash_prompt () {
   # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the
   # return value of the last command.
   set_prompt_symbol $?

   # Set the PYTHON_VIRTUALENV variable.
   set_virtualenv

   # Set the BRANCH variable.
   if is_hg_repo; then
     BRANCH=${GREEN}`hg_branch`${COLOR_NONE}
  elif is_git_repository; then
     BRANCH=${GREEEN}`set_git_branch`${COLOR_NONE}
#     BRANCH=${GREEEN}XXX${COLOR_NONE}
   else 
     BRANCH=''
   fi

   # Set the bash prompt variable.
   PS1="${PYTHON_VIRTUALENV}${YELLOW}\w${COLOR_NONE} ${BRANCH}${PROMPT_SYMBOL} "
 }

 # Tell bash to execute this function just before displaying its prompt.
 PROMPT_COMMAND=set_bash_prompt
