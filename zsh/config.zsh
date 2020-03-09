setopt NO_BG_NICE           # don't run background jobs at lower priority
setopt NO_HUP               # don't kill background jobs when the shell exits
setopt NO_BEEP              # stop the annoying beep
setopt LOCAL_OPTIONS        # remember options when returning from a shell function
setopt LOCAL_TRAPS          # when a signal trap is set inside a function the previous status of
                            # the trap for that signal will be restored when the function exits
setopt PROMPT_SUBST         # parameter expansion, command substitution and arithmetic expansion are performed in prompts

# History file configuration. Already set in OMZ
#[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"     # where to save history to disk
#HISTSIZE=10000              # how many lines of history to keep in memory
#SAVEHIST=10000              # number of history entries to save to disk

# History command configuration
#setopt APPEND_HISTORY       # append history to the history file (no overwriting)
#setopt SHARE_HISTORY        # share history across terminals
#setopt INC_APPEND_HISTORY   # add commands to HISTFILE immediately, not just when a term is killed
#setopt HIST_VERIFY          # show command with history expansion to user before running it
#setopt EXTENDED_HISTORY     # record timestamp of command in HISTFILE
#setopt HIST_REDUCE_BLANKS   # remove any excess blanks from the lines in the history
#setopt HIST_IGNORE_ALL_DUPS # remove duplicated commands from history list

#setopt COMPLETE_ALIASES      # don't expand aliases before performing completion. http://bit.ly/2VyqwFk

fpath=($MY_ZSH/functions $fpath)
autoload -U $MY_ZSH/functions/*(:t)
