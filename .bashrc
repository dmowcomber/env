# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
if [ -f ~/.bashrc_colors ]; then
    . ~/.bashrc_colors
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
mytime() {
    echo "$(date +%H:%M:%S)"
}
date_short() {
    echo "$(date +%a-%H:%M:%S)"
}
date_long() {
    echo "$(date +%A-%H:%M:%S)"
}
code() {
    /Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron $1 &
}

export CLICOLOR=1
export GREP_OPTIONS='--color=always'
export GOPATH="/Users/dustinmowcomber/fortress_development/development_projects/go"
export GOBIN="/Users/dustinmowcomber/fortress_development/development_projects/go/bin"

export PS1='\[\]\t\[\]`if [ $? = 0 ]; then echo "\[\e[32m\] ✔ "; else echo "\[\e[31m\] ✘ "; fi`\[\e[34m\]$(short_pwd)`[[ $(git status 2> /dev/null) =~ Changes\ to\ be\ committed: ]] && echo "\[\e[33m\]" || echo "\[\e[31m\]"``[[ ! $(git status 2> /dev/null) =~ nothing\ to\ commit,\ working\ .+\ clean ]] || echo "\[\e[32m\]"`$(parse_git_branch "(%s)\[\e[00m\]") \[\e[00m\]\$ '

# Aliases
alias json='python -mjson.tool'
alias less='less -R'
alias ll='ls -laG'
# search brew for go versions
alias goversions='brew search /^go\(@.*\)$/'

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

export PROMPT_COMMAND="echo -ne \"\033]0;\${PWD##*/}/\$(parse_git_branch) @\${HOSTNAME} \$(date_long)\007\""

export EDITOR=vim

# include work stuff
if [ -f ~/.bashrc_work ]; then
    . ~/.bashrc_work
fi
# include secret keys stuff
if [ -f ~/.bashrc_secret ]; then
    . ~/.bashrc_secret
fi
