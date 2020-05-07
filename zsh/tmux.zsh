# TODO: improve tla to list all aliases of tmux shortcuts
alias lta="grep -E '(=)' $MY_ZSH/tmux.zsh | less"  # list formatted aliases and descriptions
alias tls='tmux ls'                             # list tmux sessions
alias ta='tmux attach'                          # attach to the first session
alias tat='tmux attach -t' #<mysession>         # attach to session with given name <mysession>
alias tns='tmux new-session -s' #<mysession>    # start new session with given name <mysession>
alias tk='tmux kill-session'                    # kill first session listed
alias tkt='tmux kill-session -t' #<mysession>   # kill session with given name <mysession>
#alias tkl='tmux ls | grep : | cut -d. -f1 | awk '\"{print substr($1, 0, length($1)-1)}'\" | xargs kill'
