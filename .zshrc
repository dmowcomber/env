# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# ZSH_THEME="agnoster" # not using a theme anymore.. using powerline-go https://github.com/dmowcomber/powerline-go

plugins=(git kubectl)

source $ZSH/oh-my-zsh.sh

# include work stuff
if [ -f ~/.zshrc_work ]; then
    . ~/.zshrc_work
fi
# include secret keys stuff
if [ -f ~/.bashrc_secret ]; then
    . ~/.bashrc_secret
fi

r() { refresh; }
refresh() {
    REFRESH=true
    . ~/.zshrc
}

kexec() {
  podApp=$1
  podSearch=$2
  kubectl exec -it `anypod -a $podApp -s $podSearch` -- sh
}

anypodUsage() {
  echo "-a App (required)"
  echo "-s Search (optional)"
}

dcr() { dcrmup "$@"; }
dcrmup() {
	export service=$1
	dc kill $service && dc rm -f $service && dc up -d --no-deps $service
}

# fix watch command so it has aliases, functions, etc.
alias watch='watch ". ~/.zshrc 2>/dev/null; $@"'

alias jd='afplay ~/jobs-done.mp3'

kgp() { kg pods $@; }
kgd() { kg deployments $@; }

kg() {
   resource=$1
   appSelector="app=$2"
   remainingArgs=${@:3}
   if  [[ -z $1 ]]; then
     echo "must specify resource. example: kg pods"
     return
   fi
   if  [[ -z $2 ]]; then
     appSelector=""
   fi

   echo kubectl get $resource --selector=$appSelector $remainingArgs
   kubectl get $resource --selector=$appSelector $remainingArgs
}

pv() { kgpv "$@"; }
kgpv() {
  appSelector="app=$1"
  if  [[ -z $1 ]]; then
    appSelector=""
  fi

  kubectl get pods --selector=$appSelector -o "custom-columns=:.metadata.namespace,:.metadata.name,:.spec.containers[*].image,:.status.containerStatuses[*].ready, :.status.containerStatuses[*].state.running"
}

kgpn() { kgpname "$@"; }
kgpname() {
  kgp $1 | awk '{ if ( NR > 1  ) { print } }' | awk '{print $1}'
}

kee() { kexeceach "$@"; }
kexeceach() {
  app=$1
  command=$2
  kgpname $app | xargs -I {} echo "kubectl exec {} -- $command" | sh
}

anypod() {
  # echo "1: $1"
  argsLen=`echo "$1" | awk '{print length}'`
  # echo "argsLen: $argsLen"

  if  [[ -z $1 ]] || [ "$argsLen" -lt "2" ] || [ ${1:0:1} != "-" ]; then
    anypodUsage
    return
  fi

  while getopts ":a:s:" opt; do
    # echo "opt: $opt"
    case $opt in
      a)
        # echo "-$opt was triggered, Parameter: $OPTARG" >&2
        app=$OPTARG
        continue
        ;;
      s)
        # echo "-$opt was triggered, Parameter: $OPTARG" >&2
        search=$OPTARG
        continue
        ;;
      \?)
        echo "Invalid option: -$OPTARG" >&2
        return
        ;;
      :)
        echo "Option -$OPTARG requires an argument." >&2
        return
        ;;
    esac
  done

  pods=`kubectl get pods -l app="$app" -ojsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}'`

  if [ -z $search ]; then
    # $search is not set
    # use the exiting list of pods
    podSearchResults=$pods
  else
    # $search is set
    # grep the pods
    podSearchResults=`echo $pods | egrep "$search" | sed $'s,\x1b\\[[0-9;]*[a-zA-Z],,g'`
  fi

  echo $podSearchResults | tail -1
}

alias atom='echo running atom with go mod disabled because it slows down go to definition; echo GO111MODULE=off; GO111MODULE=off /Applications/Atom.app/Contents/MacOS/Atom'
alias code='/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron'
# jq . sometimes adds extra indentation. the following fixes that somehow
alias jq='jq -c .| jq'

zstyle ':completion:*' special-dirs true

setopt globdots
alias ls='ls -a'
case `uname` in
  Darwin) # (osx/macos)
    alias ll='ls -laG'
  ;;
  Linux)
    alias ll='ls -la --color'
  ;;
esac
alias goversions='brew search /^go\(@.*\)$/'

chrome() {
  /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome "$@"
}
alias dc='docker-compose'
alias bs='git branch-select'

alias now="gdate +'%Y-%m-%d %H:%M %p'"
alias utc="TZ=UTC gdate +'%Y-%m-%d %H:%M %p'"

alias gb='git branch --sort=committerdate'

alias k='kubectl'

# disable zsh auto title
DISABLE_AUTO_TITLE="true"

# precmd will run before the prompt is displayed
precmd() {
  # set the prompt title
  echo -ne "\033]0;:${PWD##*/}/$(parse_git_branch) $(date_long)\007"
}

date_long() {
    echo "$(date +%A-%H:%M:%S)"
}

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
git_current_branch() {
	git branch | grep \* | cut -d ' ' -f2
}
git_track() {
  git branch -vv | grep `git_current_branch`
  git branch -u origin/`git_current_branch`
  git branch -vv | grep `git_current_branch`
}
alias gt='git_track'

git_push_upstream() {
  git branch -vv | grep `git_current_branch`
  git push -u origin `git_current_branch`
  git branch -vv | grep `git_current_branch`
}
alias gpu='git_push_upstream'
alias dockerips="docker ps -q | xargs -n 1 docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} {{ .Name }}' | sed 's/ \// /'"

export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export GO111MODULE='auto'

PATH="$HOME/Library/Python/3.7/bin:$HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/.gem/ruby/2.1.0/bin:/Library/Frameworks/Python.framework/Versions/2.7/bin:${GOPATH}/bin:/Applications/Postgres.app/Contents/Versions/9.5/bin:${PATH}:$HOME/.gem/ruby/2.0.0/bin"
PATH="$HOME/Library/Python/2.7/bin:${PATH}"
PATH="/usr/local/sbin:$PATH"
# add flamegraph script for pprof flame graphs!
PATH="$GOPATH/go/src/github.com/uber/go-torch/FlameGraph:/usr/local/opt/go/libexec/bin:$PATH"
PATH="$GOPATH/bin/:$PATH"
export PATH

unsetopt share_history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

export CLICOLOR=1
alias grep='grep --color'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# fix issue with missing carriage return
stty sane

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


kp() { kubectl_prompt "$@"; }
kubectl_prompt() {
  enable=$1
  if  [[ $enable == "on" ]]; then
    echo "enabling kubectl prompt"
    enable_kubectl_prompt
    return
  fi
  echo "disabling kubectl prompt"
  disable_kubectl_prompt
}

disable_kubectl_prompt() {
  RPS1=''
}

enable_kubectl_prompt() {
  source ~/env/zsh-kubectl-prompt/kubectl.zsh && RPS1='%{$fg[blue]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}'
}

# enable_kubectl_prompt

# powerline-go (this override the theme set way above)
function powerline_precmd() {
  # capture the exit code before doing anything else
  exit_code=$?

  [ -f $GOPATH/bin/powerline-go ] || return

  # -modules string
  #     The list of modules to load, separated by ','
  #     (valid choices: aws, cwd, docker, docker-context, dotenv, duration, exit, git, gitlite, hg, host, jobs, kube, load, newline, nix-shell, node, perlbrew, perms, plenv, root, shell-var, shenv, ssh, svn, termtitle, terraform-workspace, time, user, venv, vgo)
  #     (default "venv,user,host,ssh,cwd,perms,git,hg,jobs,exit,root")

  gitmodule="git"
  # if [ -n "$TMUX" ]; then
  #   gitmodule="gitlite"
  # fi

  if [ -f $GOPATH/bin/powerline-go ]; then
    PS1="$($GOPATH/bin/powerline-go -error $exit_code -shell zsh -hostname-only-if-ssh -modules "ssh,host,time,docker,$gitmodule,cwd,perms,hg,jobs,exit,root")"
  fi
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

function powerInput() {
	system_profiler SPPowerDataType | sed -n '/AC Charger Information/,/Power Events/p'
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi
# eval "$(chef shell-init zsh)"

if uname -a |grep -q steamdeck; then
  # steamos path to vscode
  export PATH=$PATH:~/applications/VSCode-linux-x64/bin/

  # steamdeck distrobox/podman setup
  export PATH=$HOME/.local/bin:$PATH
  export PATH=$HOME/.local/podman/bin:$PATH
  xhost +si:localuser:$USER # enable distrobox gui apps
fi