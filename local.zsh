# Iniciar línea de comandos con tmux abierto
# http://unix.stackexchange.com/questions/43601/how-can-i-set-my-default-shell-to-start-up-tmux
#if command -v tmux>/dev/null; then
#  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && { tmux attach || exec tmux new-session && exit; } # Esto cerraría el terminal al cerrar tmux
#  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && { tmux attach || tmux new-session } # Esto no lo cerraría
#fi

alias night='pkill flux; xflux -l 37 -g 5 -k 2500'
alias morning='pkill flux; xflux -l 27 -g 180 -k 2500'
alias close='xdotool search "" windowkill %@'
