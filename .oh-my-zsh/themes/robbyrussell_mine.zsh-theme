# local ret_status="%(?:%{$fg_bold[green]%}🍪 :%{$fg_bold[red]%}🔥 )"
local ret_status="%(?:%{$fg_bold[green]%} 🍺  :%{$fg_bold[red]%} 🔥  )"
# local ret_status="%(?:%{$fg_bold[green]%}$ :%{$fg_bold[red]%}🔥 )"

# PROMPT='%{$fg[blue]%}%c%{$reset_color%} $(git_prompt_info)${ret_status}%{$reset_color%} '
# PROMPT='${ret_status}%{$reset_color%} %{$fg[blue]%}%c%{$reset_color%} $(git_prompt_info)%{$reset_color%}'
PROMPT='%{$reset_color%}$(git_prompt_info)%{$reset_color%}%{$fg[blue]%}%c${ret_status}%{$reset_color%}'

# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[grey]%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) %{$fg[green]%}✔"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}%{$fg[grey]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} ✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ✔"
