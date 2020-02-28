# TODO: improve tla
alias tla="grep -E '(=)' ~/.dotfiles/zsh/tmux.zsh | less"  # List formatted aliases and descriptions
alias tls='tmux ls'                      # List tmux sessions
alias ta='tmux attach'                   # Attach to the first session listed
alias tat='tmux attach -t' #<mysession>  # Attach to session with given name <mysession>
alias tns='tmux new-session -s'          # Start new session with given name <mysession>
alias tk='tmux kill-session'             # Kill first session listed
alias tkt='tmux kill-session -t'         # Kill session with given name <mysession>

#alias tkl='tmux ls | grep : | cut -d. -f1 | awk '\"{print substr($1, 0, length($1)-1)}'\" | xargs kill'
