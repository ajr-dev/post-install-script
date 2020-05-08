alias lza="grep -E '(=)' $MY_ZSH/aliases.zsh | less"  # List ZSH aliases and descriptions

# Recargar la configuración de zsh
alias reload!='RELOAD=1 source ~/.zshrc'

alias autoremove='sudo apt autoremove -y'
alias untar='tar -zxvf'

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi

# Set colors for LS_COLORS in Windows Linux Subsystem
test -r ~/.dircolors  &&  eval "$(dircolors -b ~/.dircolors)"  ||  eval "$(dircolors -b)"

alias lsh="ls -lsh"                 # list files sorted by size
alias ld="ls -l ${colorflag} | grep ^d"  # list directories
alias rmf="rm -rf"
alias df='df -h'                    # show disk free space in gigabytes
alias du='du -h -c'                 # calculate disk usage for a folder

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
