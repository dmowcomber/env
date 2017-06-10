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
    local pwd_length=${PROMPT_LEN-35};
    local cur_pwd=$(echo $(pwd) | sed -e "s,^$HOME,~,");
    if [ $(echo -n $cur_pwd | wc -c | tr -d " ") -gt $pwd_length ]; then
        echo "...$(echo $cur_pwd | sed -e "s/.*\(.\{$pwd_length\}\)/\1/")";
    else
        echo $cur_pwd;
    fi
}

short_date() {
    echo "$(date +%a-%H:%M)"
}

# colors! (the brackets fix the terminal word wrap issue)
RED="\\[$(tput setaf 1)\\]"
GREEN="\\[$(tput setaf 2)\\]"
YELLOW="\\[$(tput setaf 3)\\]"
BLUE="\\[$(tput setaf 4)\\]"
GREY="\\[$(tput setaf 7)\\]"
# backgroup colors
RED_BG="\\[$(tput setab 1)\\]"
BLUE_BG="\\[$(tput setab 4)\\]"
GREY_BG="\\[$(tput setab 7)\\]"
# no color
NO_COLOR="\\[$(tput sgr0)\\]"
BOLD="\\[$(tput bold)\\]"

export CLICOLOR=1
export GREP_OPTIONS='--color=always'
export GOPATH="/Users/dustinmowcomber/fortress_development/development_projects/go"
export GOBIN="/Users/dustinmowcomber/fortress_development/development_projects/go/bin"

#export PS1="$YELLOW$BOLD\$(short_date)$NO_COLOR \$(hostname -s):$BLUE\$(short_pwd)$RED\$(parse_git_branch) $GREEN$ $NO_COLOR"
export PS1="$YELLOW\$(short_date)$NO_COLOR \$(hostname -s):$BLUE\$(short_pwd)$RED\$(parse_git_branch) $GREEN$ $NO_COLOR"

alias fd='cd ~/fortress_development/development_projects/'
alias fv='cd ~/fortress_development/ && vagrant ssh -- -o ServerAliveInterval=120'
alias json='python -mjson.tool'
alias jump='ssh dmowcomber@jump.sendgrid.net'
alias less='less -R'
alias ll='ls -laG'
alias rvm-restart='rvm_reload_flag=1 source '\''/Users/dustinmowcomber/.rvm/scripts/rvm'\'''
alias sgg='cd ~/fortress_development/development_projects/go/src/github.com/sendgrid'
alias hc='cd ~/fortress_development/development_projects/go/src/github.com/sendgrid/healthchecker; ./bin/run'

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

export PROMPT_COMMAND="echo -ne \"\033]0;\${PWD##*/}/\$(parse_git_branch) @\${HOSTNAME}\007\""

eval $(docker-machine env)

