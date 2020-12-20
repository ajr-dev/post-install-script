#!/bin/bash

# Exit if already sourced
if [ -n "$DECLARED" ]; then
  return
fi

mkdir -p ~/tmp && cd ~/tmp

command_exists() {
  command -v "$1" > /dev/null 2>&1
}

COLOR_GRAY="\033[1;38;5;243m"
COLOR_BLUE="\033[1;34m"
COLOR_GREEN="\033[1;32m"
COLOR_RED="\033[1;31m"
COLOR_PURPLE="\033[1;35m"
COLOR_YELLOW="\033[1;33m"
COLOR_NONE="\033[0m"

error() {
  echo -e "${COLOR_RED}Error: ${COLOR_NONE}$1"
  exit 1
}

warning() {
  echo -e "${COLOR_YELLOW}Warning: ${COLOR_NONE}$1"
}

info() {
  echo -e "${COLOR_BLUE}Info: ${COLOR_NONE}$1"
}

success() {
  echo -e "${COLOR_GREEN}$1${COLOR_NONE}"
}

DELAY=10
DOTFILES=$HOME/.dotfiles
INSTALL=$HOME/.post-install/install

# Desktop environment
DESKTOP="$(echo "$DESKTOP_SESSION" | tr '[:upper:]' '[:lower:]')"

# Machine architecture 64 or 32 bits
ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')

# Distribution and version
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
    read  -rn 1 -p "$promptMsg (yes/No) "
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

DECLARED=true

export ARCH DECLARED DOTFILES DELAY DESKTOP INSTALL DISK OS RAM VER h quick autoConfirm shell_profile
