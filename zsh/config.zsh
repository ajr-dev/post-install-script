setopt NO_BG_NICE
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS
setopt LOCAL_TRAPS
#setopt IGNORE_EOF
setopt PROMPT_SUBST

# history
HISTFILE=~/.zsh_history     # where to save history to disk
HISTSIZE=10000              # how many lines of history to keep in memory
SAVEHIST=10000              # number of history entries to save to disk
setopt APPEND_HISTORY       # append history to the history file (no overwriting)
setopt SHARE_HISTORY        # share history across terminals
setopt INC_APPEND_HISTORY   # immediately append to the history file, not just when a term is killed
setopt HIST_VERIFY
setopt EXTENDED_HISTORY
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_ALL_DUPS

setopt COMPLETE_ALIASES

# make terminal command navigation sane again
bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char

fpath=($ZSH/functions $fpath)
autoload -U $ZSH/functions/*(:t)
