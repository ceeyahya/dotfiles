export XDG_CONFIG_HOME="$HOME/.config"

autoload -Uz compinit
if [[ ! -f ~/.zcompdump || $(find ~/.zcompdump -mtime +1) ]]; then
  compinit
else
  compinit -C
fi

#== CUSTOM PROMPT ==#
setopt PROMPT_SUBST

# Git info function
git_prompt() {
  local branch status_symbol

  if git rev-parse --git-dir >/dev/null 2>&1; then
    # Get branch name
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

    # Check various git states
    local git_status=$(git status --porcelain 2>/dev/null)
    local staged=$(git diff --cached --name-only 2>/dev/null)

    if [[ -n $(echo "$git_status" | grep "^??") ]]; then
      # Untracked files (nf-fa-question)
      status_symbol=" ?"
    elif [[ -n $(echo "$git_status" | grep "^UU\|^AA\|^DD") ]]; then
      # Merge conflicts (nf-fa-exclamation_triangle)
      status_symbol=" !"
    elif [[ -n $staged ]]; then
      # Staged changes (nf-fa-plus)
      status_symbol=" +"
    elif [[ -n $git_status ]]; then
      # Modified files (nf-fa-pencil)
			status_symbol=" *"
    else
      # Clean repo (nf-fa-check)
      status_symbol=" "
    fi

    echo " %F{magenta}%f %F{yellow}$branch%f %f[%F{red}$status_symbol%F %f]"
  fi
}

# Add empty line before each prompt (except the first one)
precmd() {
  # Only add newline if this isn't the first prompt
  if [[ -n $PROMPT_PRINTED ]]; then
    print
  fi
  PROMPT_PRINTED=1
}

# Set your custom prompt
PS1='%F{blue}%1~%f$(git_prompt)
%F{green}󰘧%f '
#== END CUSTOM PROMPT ==#

#== LOAD ZSH PLUGINS ==#
ZSH_PLUGINS_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins"

source "$ZSH_PLUGINS_DIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
source "$ZSH_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Add completions to fpath
fpath=($ZSH_PLUGINS_DIR/zsh-completions/src $fpath)
#== END LOAD ZSH PLUGINS ==#

#== HISTORY SETTINGS ==#
export HISTSIZE=50000
export SAVEHIST=50000
setopt INC_APPEND_HISTORY EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS SHARE_HISTORY
unsetopt HIST_VERIFY
#== END HISTORY SETTINGS ==#

# Editor
export VISUAL="nvim"
export EDITOR="$VISUAL"

#== FZF CONFIG ==#
export FZF_DEFAULT_OPTS="
    --height=99% 
    --layout=reverse 
    --pointer='█'
    --scrollbar='▌'
    --highlight-line
    --color=hl:#f3be7c
    --color=bg:-1
    --color=gutter:-1
    --color=bg+:#252530
    --color=fg+:#aeaed1
    --color=hl+:#f3be7c
    --color=border:#606079
    --color=prompt:#bb9dbd
    --color=query:#aeaed1:bold
    --color=pointer:#aeaed1
    --color=scrollbar:#aeaed1
    --color=info:#f3be7c
    --color=spinner:#7fa563
    "

export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'
  --with-nth=2.."
#== FZF CONFIG ==#

#== ALIASES ==#
alias vim="nvim"
alias v="nvim"
alias perf='for i in $(seq 1 10); do /usr/bin/time $SHELL -i -c exit; done'
alias nvim-perf='nvim --startuptime ./startup.log +q'
#== END ALIASES ==#

# Simple PATH setup - minimal variable expansion
export PATH="$HOME/Library/pnpm:$HOME/.volta/bin:/opt/homebrew/opt/curl/bin:/usr/local/opt/curl/bin:/opt/homebrew/opt/mysql-client/bin:$HOME/Library/Python/3.9/bin:$HOME/.cache/rebar3/bin:$HOME/go/bin:$PATH"

source <(fzf --zsh)

# Async loading
{
  command -v plow >/dev/null && eval "$(plow --completion-script-zsh)"
  command -v uv >/dev/null && eval "$(uv generate-shell-completion zsh)"
  command -v uvx >/dev/null && eval "$(uvx --generate-shell-completion zsh)"
  [[ -x /usr/libexec/path_helper ]] && eval "$(/usr/libexec/path_helper)"
} &!

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
