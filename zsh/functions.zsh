function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '→'
}

function get_virtual_env {
  if [ -n "$VIRTUAL_ENV" ];
  then
    echo "[%{$fg[red]%}`basename \"$VIRTUAL_ENV\"`%{$reset_color%}]"
  fi
}

function set_prompt {
PROMPT="
[%{$fg[blue]%}%m%{$reset_color%}] %{$fg[green]%}%~%{$reset_color%}$(git_prompt_info)
%{$fg[red]%}$(prompt_char)%{$reset_color%} "
RPROMPT='$(get_virtual_env)'
}

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function precmd {
    set_prompt
}

