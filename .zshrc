# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell_mine"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

###
### user definitions:
###

# include work stuff
if [ -f ~/.bashrc_work ]; then
    . ~/.bashrc_work
fi
# include secret keys stuff
if [ -f ~/.bashrc_secret ]; then
    . ~/.bashrc_secret
fi

r() { refresh; }
refresh() {
    . ~/.zshrc
}

alias json='python -mjson.tool'

zstyle ':completion:*' special-dirs true

setopt globdots
alias ls='ls -a'
alias ll='ls -laG'

alias rts='ss rts| egrep "\| rts0"'
alias dc='docker-compose'

alias now="gdate +'%Y-%m-%d %H:%M %p'"
alias utc="TZ=UTC gdate +'%Y-%m-%d %H:%M %p'"

# disable zsh auto title
DISABLE_AUTO_TITLE="true"

# precmd will run before the prompt is displayed
precmd() {
  # set the prompt title
  echo -ne "\033]0;${PWD##*/}/$(parse_git_branch) @$(hostname) $(date_long)\007"
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
	git branch -vv
	git branch -u origin/`git_current_branch`
	git branch -vv
}
alias gt='git_track'

deploy() {
  ~/deploy.sh "$@"
}

export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"

PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${GOPATH}/bin:/Applications/Postgres.app/Contents/Versions/9.5/bin:${PATH}"
export PATH

unsetopt share_history
