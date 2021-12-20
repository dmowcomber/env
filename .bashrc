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
git_current_branch() {
  git branch | grep \* | cut -d ' ' -f2
}
git_track() {
  git branch -u origin/`git_current_branch`
}
alias gt='git_track()'
short_pwd() {
    local pwd_length=${PROMPT_LEN-25};
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

# dcstats and dtop have mostly the same output
dcstats() {
    # docker stats using docker-compose
    docker-compose ps | grep Up | awk '{print $1}' | xargs docker stats
}
dtop() {
    # docker stats formatted the way I like it with optional args
    docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}\t{{.NetIO}}\t{{.BlockIO}}\t{{.PIDs}}\t{{.Container}}" "$@"
    # docker stats docs https://docs.docker.com/engine/reference/commandline/stats/
}
dbuild() {
    docker build -t docker.sendgrid.net/sendgrid/${PWD##*/} .
}
dc() {
    # ex: dc logs -f
    docker-compose "$@"
}
dcupdev() {
    # ex: dcupdev -d --no-dep chaos
    docker-compose -f docker-compose.yml -f docker-compose.dev.yml up "$@"
}
r() { refresh; }
refresh() {
    . ~/.bashrc
}
deploy() {
	~/deploy.sh "$@"
}

export CLICOLOR=1
# export GREP_OPTIONS='--color=always'
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"

export PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$'

# Aliases
alias json='python -mjson.tool'
alias less='less -R'
alias ll='ls -laG'
# search brew for go versions
alias goversions='brew search /^go\(@.*\)$/'

alias dc='docker-compose'
alias now="gdate +'%Y-%m-%d %H:%M %p'"
alias utc="TZ=UTC gdate +'%Y-%m-%d %H:%M %p'"
alias atom='echo running atom with go mod disabled because it slows down go to definition; echo GO111MODULE=off; GO111MODULE=off /Applications/Atom.app/Contents/MacOS/Atom'

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

export PROMPT_COMMAND="echo -ne \"\033]0;\${HOSTNAME}:\${PWD##*/}/\$(parse_git_branch) \$(date_long)\007\""

export EDITOR=vim

# include work stuff
if [ -f ~/.bashrc_work ]; then
    . ~/.bashrc_work
fi
# include secret keys stuff
if [ -f ~/.bashrc_secret ]; then
    . ~/.bashrc_secret
fi

export GIT_SSH=/usr/bin/ssh

if hash chef 2>/dev/null; then
	eval "$(chef shell-init bash)"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
