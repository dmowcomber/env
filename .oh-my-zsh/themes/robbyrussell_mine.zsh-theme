local ret_status="%(?:%{$fg_bold[green]%} 🥃  :%{$fg_bold[red]%} 🔥  )"

PROMPT='%* %{$reset_color%}$(prompt_git_color)$(git_prompt_info)%{$reset_color%}%{$fg[blue]%}$(short_pwd)${ret_status}%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="" # using $(prompt_git_color) as the prefix in $PROMPT
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

prompt_git_color() {
  (( $+commands[git] )) || return
  local dirty
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(git_dirty)
    if [[ -n $dirty ]]; then
      prompt_segment NONE yellow
    else
      prompt_segment NONE green
    fi
  fi
}

prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

git_dirty() {
  local STATUS=''
  local FLAGS
  FLAGS=('--porcelain')
  if [[ "$(command git config --get oh-my-zsh.hide-dirty)" != "1" ]]; then
    if [[ $POST_1_7_2_GIT -gt 0 ]]; then
      FLAGS+='--ignore-submodules=dirty'
    fi
    if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
      FLAGS+='--untracked-files=no'
    fi
    STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  fi
  echo $STATUS
}

short_pwd() {
    local pwd_length=${PROMPT_LEN-25};
    local cur_pwd=$(echo $(pwd) | sed -e "s,^$HOME,~,");
    if [ $(echo -n $cur_pwd | wc -c | tr -d " ") -gt $pwd_length ]; then
        echo "...$(echo $cur_pwd | sed -e "s/.*\(.\{$pwd_length\}\)/\1/")";
    else
        echo $cur_pwd;
    fi
}
