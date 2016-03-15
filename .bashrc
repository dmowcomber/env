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

export CLICOLOR=1
export GREP_OPTIONS='--color=always'
export GOPATH="/Users/dustinmowcomber/repos/fortress_development/development_projects/go"
export GOBIN="/Users/dustinmowcomber/repos/fortress_development/development_projects/go/bin"

txtylw='\e[0;33m' # Yellow

export PS1="\$(short_date) \$(hostname -s):\[\e[0;34m\]\$(short_pwd)\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

alias fd='cd ~/repos/fortress_development/development_projects/'
alias fv='cd ~/repos/fortress_development/ && vagrant ssh -- -o ServerAliveInterval=120'
alias json='python -mjson.tool'
alias less='less -R'
alias ll='ls -laG'
alias rvm-restart='rvm_reload_flag=1 source '\''/Users/dustinmowcomber/.rvm/scripts/rvm'\'''

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

export PROMPT_COMMAND="echo -ne \"\033]0;\${PWD##*/}/\$(parse_git_branch) @\${HOSTNAME}\007\""

