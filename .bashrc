# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

short_pwd ()
{
  local pwd_length=${PROMPT_LEN-35}
  local cur_pwd=$(echo $(pwd) | sed -e "s,^$HOME,~,")

  if [ $(echo -n $cur_pwd | wc -c | tr -d " ") -gt $pwd_length ]; then
    echo "...$(echo $cur_pwd | sed -e "s/.*\(.\{$pwd_length\}\)/\1/")"
  else
    echo $cur_pwd
  fi
}

#export short_date="$(date +%a-%H:%M)"
short_date() {
    echo "$(date +%a-%H:%M)"
}

export CLICOLOR=1
export GREP_OPTIONS='--color=always'

txtylw='\e[0;33m' # Yellow
export PS1="\$(short_date) \[\e[00;33m\]Vagrant\[\e[00m\]:\[\e[0;34m\]\$(short_pwd)\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

alias ll='ls -laG'
alias json='python -mjson.tool'
alias go='colorgo'

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

export PROMPT_COMMAND="echo -ne \"\033]0;\${PWD##*/}/\$(parse_git_branch) @\${HOSTNAME}\007\""

