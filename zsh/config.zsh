# TODO: most is set in OMZ, commit to nicknisi
# Move forward/backward one word with Ctrl-left Ctrl-right
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word

# Move to beginning/end of line with Alt-left Alt-right
bindkey '^[[1;3D' beginning-of-line
bindkey '^[[1;3C' end-of-line
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line

indkey '^?' backward-delete-char                     # [Backspace] - delete backward
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward
else
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
fi

setopt NO_BG_NICE           # don't run background jobs at lower priority
setopt NO_HUP               # don't kill background jobs when the shell exits
setopt NO_BEEP              # stop the annoying beep
setopt LOCAL_OPTIONS        # remember options when returning from a shell function
setopt LOCAL_TRAPS          # when a signal trap is set inside a function the previous status of
                            # the trap for that signal will be restored when the function exits
setopt PROMPT_SUBST         # parameter expansion, command substitution and arithmetic expansion are performed in prompts
setopt COMPLETE_ALIASES     # don't expand aliases before performing completion. http://bit.ly/2VyqwFk

fpath=($MY_ZSH/functions $fpath)
autoload -U $MY_ZSH/functions/*(:t)
