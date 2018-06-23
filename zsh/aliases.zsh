# Recargar la configuración de zsh
alias reload!='RELOAD=1 source ~/.zshrc'

# tmux aliases
alias ta='tmux attach'
alias tls='tmux ls'
alias tat='tmux attach -t'
alias tns='tmux new-session -s'
alias tk='tmux kill-session'
#alias tkl='tmux ls | grep : | cut -d. -f1 | awk '\"{print substr($1, 0, length($1)-1)}'\" | xargs kill'

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi

alias vim="nvim"
alias hc="hashcat"

# Alias del sistema de archivo
alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias ls="ls ${colorflag}"
alias l="ls -lah ${colorflag}"
alias la="ls -AF ${colorflag}"
alias ll="ls -lFh ${colorflag}"
alias lld="ls -l | grep ^d"
alias rmf="rm -rf"

# Funciones de ayuda
alias grep='grep --color=auto'
alias df='df -h' # disco libre en Gigabytes, no en bytes
alias du='du -h -c' # calcular el uso del disco de una cartpeta

# Direcciones IP
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# Limpiar caché del Directorio de Servicio
alias flush="dscacheutil -flushcache"

# Ver tráfico HTTP
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Recortar nuevas líneas y copiar al portapapeles
alias trimcopy="tr -d '\n' | pbcopy"

# Borrar ficheros `.DS_Store` recursivamente
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# Tamaño de archivo
alias fs="stat -f \"%z bytes\""

# Codificado ROT13 para texto. Funciona para decodificar en inglés también
alias rot13='tr a-zA-Z n-za-mN-ZA-M'

# Vaciar la papelera de todos los volúmenes montados y del disco duro
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; rm -rfv ~/.Trash"

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
    alias "$method"="lwp-request -m '$method'"
done

# My custom alias for CS50 By Harvard University
mk() {
    echo cc -ggdb -std=c99 -Wall -Werror .c -lcrypt -lcs50 -lm -o;
    cc -ggdb -std=c99 -Wall -Werror .c -lcrypt -lcs50 -lm -o argv-2;
}
