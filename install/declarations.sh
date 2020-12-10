#!/bin/bash

mkdir -p ~/tmp && cd ~/tmp

command_exists() {
    command -v "$1" > /dev/null 2>&1
}

DELAY=10
DOTFILES=$HOME/.dotfiles
INSTALL=$HOME/.post-install/install

# Desktop environment https://unix.stackexchange.com/questions/116539/how-to-detect-the-desktop-environment-in-a-bash-script
DESKTOP=$DESKTOP_SESSION
#if [ "$XDG_CURRENT_DESKTOP" = "" ]; then
#  DESKTOP=$(echo "$XDG_DATA_DIRS" | sed 's/.*\(kde\|xfce\|cinnamon\|mate\|gnome\).*/\1/')
#else
#  DESKTOP=$XDG_CURRENT_DESKTOP
#fi

DESKTOP="$(echo "$DESKTOP" | tr '[:upper:]' '[:lower:]')"

# Machine architecture 64 or 32 bits
ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')

# Distribution and version
#DISTRO=$(grep '\n' /etc/issue | awk '{print $1,$2}')
if [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    OS=Debian  # XXX or Ubuntu??
    VER=$(cat /etc/debian_version)
elif [ -f /etc/redhat-release ]; then
    # TODO add code for Red Hat and CentOS here
    ...
else
    OS=$(uname -s)
    VER=$(uname -r)
fi
OS="$(echo "$OS" | tr '[:upper:]' '[:lower:]')"

RAM=$(awk '/MemTotal/ {print $2}' /proc/meminfo | xargs -I {} echo "scale=4; {}/1024^2" | bc)

# Check if using SSD or HDD
[ "$(cat /sys/block/sda/queue/rotational)" -eq 1 ]  &&  DISK=HDD  ||  DISK=SDD

command_exists() {
    command -v "$1" > /dev/null 2>&1
}

# http://stackoverflow.com/questions/43364510/prompt-to-continue-if-no-argument-passed
getopt --test > /dev/null
if [[ $? != 4 ]]; then
    echo "I’m sorry, $(getopt --test) failed in this environment."
    exit 1
fi

SHORT=hyq
LONG=help,yes,quick

# -temporarily store output to be able to check for errors
# -activate advanced mode getopt quoting e.g. via “--options”
# -pass arguments only via   -- "$@"   to separate them correctly
PARSED=$(getopt --options $SHORT --longoptions $LONG --name "$0" -- "$@")
if [[ $? != 0 ]]; then
    # e.g. $? == 1
    #  then getopt has complained about wrong arguments to stdout
    exit 2
fi
# use eval with "$PARSED" to properly handle the quoting
eval set -- "$PARSED"

h=0; quick=0; autoConfirm=0

# now enjoy the options in order and nicely split until we see --
while true; do
    case "$1" in
        -h|--help)
            h=1
            shift
            ;;
        -q|--quick)
            quick=1
            shift
            ;;
        -y|--yes)
            autoConfirm=1
            shift
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Invalid option.  Use -h for help"
            exit 3
            ;;
    esac
done

assertConfirmation () {
    local promptMsg=$1 #autoConfirm=$2
    if (( autoConfirm )); then
        return
    else
        clear
        read  -n 1 -p "$promptMsg (yes/No) "
        printf '\n' # Output a newline, because none was appended to the user's keypress.
        echo "========================================================================"
        if [[ $REPLY =~ ^([Yy])$ ]]; then # TODO: accept yes besides Y and y
            return
        fi
    fi
    return 1
}

font_installed () {
    fontname=$1
    fc-list | grep -i "$fontname" > /dev/null
}

if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
    shell_profile="zshrc" # assume Zsh
elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
    shell_profile="bashrc" # assume Bash
fi

have_sudo_access() {
  local -a args
  if [[ -n "${SUDO_ASKPASS-}" ]]; then
    args=("-A")
  fi

  if [[ -n "${args[*]-}" ]]; then
    /usr/bin/sudo "${args[@]}" -l mkdir &>/dev/null
  else
    /usr/bin/sudo -l mkdir &>/dev/null
  fi
  HAVE_SUDO_ACCESS="$?"

  return "$HAVE_SUDO_ACCESS"
}

export ARCH DOTFILES DELAY DESKTOP INSTALL DISK OS RAM VER h quick autoConfirm shell_profile
