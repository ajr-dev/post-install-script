# Dotfiles

Welcome to my world. This is a collection of vim, tmux, and zsh configurations. Interested in a video walkthrough of the dotfiles? Check out my talk, [vim + tmux](https://www.youtube.com/watch?v=5r6yzFEXajQ).

Obviously this setup work for me, a JavaScript developer on macOS, but this particular setup may not work for you. If this particular setup doesn't work for you, please steal ideas from this and if you like, contribute back tips, tricks, PRs, and other tidbits if you like!

## Contents

* [Initial Setup and Installation](#initial-setup-and-installation)
* [ZSH Setup](#zsh-setup)
* [Vim and Neovim Setup](#vim-and-neovim-setup)
* [Fonts](#fonts)
* [Tmux](#tmux-configuration)
  * [Tmux Cheatsheet](#tmux-cheatsheet)
    * [Sessions](#sessions)
    * [Various](#various)
    * [Windows (tabs)](#windows-tabs)
    * [Panes (splits)](#panes-splits)
  * [Custom Tmux Keybindings](#custom-tmux-keybindings)
* [Vim](#vim)
  * [Vim Cheatsheet](#vim-cheatsheet)
  * [Custom Vim Keybindings](#custom-vim-keybindings)
* [Todo list](#todo-list)

## Initial Setup and Installation

Then, clone the dotfiles repository to your computer. This can be placed anywhere, and symbolic links will be created to reference it from your home directory.

```bash
git clone https://github.com/nicknisi/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh -qy
```

TODO: add a oneliner installation procedure:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ajr-dev/post-install-script/master/install.sh)"
```

This will install only the configuration without prompting for confirmation (because of the `-y` option meaning yes).  If you want to select what is done then type `./install.sh` instead.
`q` stands for quick so it won't install all the packages only the dotfiles so you can start working right away.

`install.sh` will start by initializing the submodules used by this repository (if any). **Read through this file and comment out anything you don't want installed.** Then, it will install all symbolic links into your home directory. Every file with a `.symlink` extension will be symlinked to the home directory with a `.` in front of it. As an example, `vimrc.symlink` will be symlinked in the home directory as `~/.vimrc`. Then, this script will create a `~/.vim-tmp` directory in your home directory, as this is where vim is configured to place its temporary files. Additionally, all files in the `$DOTFILES/config` directory will be symlinked to the `~/.config/` directory for applications that follow the [XDG base directory specification](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html), such as neovim.

Next, the install script will perform a check to see if it is running on an OSX machine. If so, it will install Homebrew if it is not currently installed and will install the homebrew packages listed in [`brew.sh`](install/brew.sh). Then, it will run [`osx.sh`](install/osx.sh) and change some OSX configurations. This file is pretty well documented and so it is advised that you __read through and comment out any changes you do not want__. Next, nginx (installed from Homebrew) will be configured with the provided configuration file. If a `nginx.conf` file already exists in `/usr/local/etc`, a backup will be made at `/usr/local/etc/nginx/nginx.conf.original`.

## ZSH Setup

You should take a look to the [zsh aliases](zsh/aliases.zsh).

ZSH is configured in the `zshrc.symlink` file, which will be symlinked to the home directory. The following occurs in this file:

* set the `EDITOR` to nvim
* Load any `~/.terminfo` setup
* Set the `CODE_DIR` variable, pointing to the location where the code projects exist for exclusive autocompletion with the `c` command
* Recursively search the `$DOTFILES/zsh` directory for files ending in .zsh and source them
* Setup zplug plugin manager for zsh plugins and installed them.
* source a `~/.localrc` if it exists so that additional configurations can be made that won't be kept track of in this dotfiles repo. This is good for things like API keys, etc.
* Add the `~/bin` and `$DOTFILES/bin` directories to the path
* And more...

### Prompt

The prompt is meant to be simple while still providing a lot of information to the user, particularly about the status of the git project, if the PWD is a git project. This prompt sets `precmd`, `PROMPT` and `RPROMPT`.

![](http://nicknisi.com/share/prompt.png)

The `precmd` shows the current working directory in it and the `RPROMPT` shows the git and suspended jobs info.

#### Prompt Git Info

The git info shown on the `RPROMPT` displays the current branch name, and whether it is clean or dirty.

![](http://nicknisi.com/share/git-branch-state.png)

Additionally, there are ⇣ and ⇡ arrows that indicate whether a commit has happened and needs to be pushed (⇡), and whether commits have happened on the remote branch that need to be pulled (⇣).

![](http://nicknisi.com/share/git-arrows.png)

#### Suspended Jobs

The prompt will also display a ✱ character in the `RPROMPT` indicating that there is a suspended job that exists in the background. This is helpful in keeping track of putting vim in the background by pressing CTRL-Z.

![](http://nicknisi.com/share/suspended-jobs.png)

## Vim and Neovim Setup

[Neovim](https://neovim.io/) is a fork and drop-in replacement for vim. in most cases, you would not notice a difference between the two, other than Neovim allows plugins to run asynchronously so that they do not freeze the editor, which is the main reason I have switched over to it. Vim and Neovim both use Vimscript and most plugins will work in both (all of the plugins I use do work in both Vim and Neovim). For this reason, they share the same configuration files in this setup. Neovim uses the [XDG base directory specification](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html) which means it won't look for a `.vimrc` in your home directory. Instead, its configuration looks like the following:

|                         | Vim        | Neovim                    |
|-------------------------|------------|---------------------------|
| Main Configuratin File  | `~/.vimrc` | `~/.config/nvim/init.vim` |
| Configuration directory | `~/.vim`   | `~/.config/nvim`          |

### Installation

Vim is likely already installed on your system. If using a Mac, MacVim will be installed from Homebrew. Neovim will also be installed from Homebrew by default on a Mac. For other systems, you may need to install Neovim manually. See their [web site](https://neovim.io) for more information.

[`link.sh`](install/link.sh) will symlink the XDG configuration directory into your home directory and will then create symlinks for `.vimrc` and `.vim` over to the Neovim configuration so that Vim and Neovim will both be configured in the same way from the same files. The benefit of this configuration is that you only have to maintain a single vim configuration for both, so that if Neovim (which is still alpha software) has issues, you can very seamlessly transition back to vim with no big impact to your productivity.

Inside of [`.zshrc`](zsh/zshrc.symlink), the `EDITOR` shell variable is set to `nvim`, defaulting to Neovim for editor tasks, such as git commit messages. Additionally, I have aliased `vim` to `nvim` in [`aliases.zsh`](zsh/aliases.zsh) You can remove this if you would rather not alias the `vim` command to `nvim`.

vim and neovim should just work once the correct plugins are installed. To install the plugins, you will need to open Neovim in the following way:

```bash
nvim +PlugInstall
```

## Fonts

I am currently using [Operator Mono](http://www.typography.com/fonts/operator/styles/operatormonoscreensmart) as my default font which is a paid font ($199 US) and does not include Powerline support. In addition to this, I do have [nerd-fonts](https://github.com/ryanoasis/nerd-fonts) installed and configured to be used for non-ascii characters. If you would prefer not to do this, then simply remove the `Plug 'ryanoasis/vim-devicons'` plugin from vim/nvim. Then, I configure the fonts in this way in iTerm2:

![](http://nicknisi.com/share/iterm-fonts-config.png)

## Tmux Configuration

Tmux is a terminal multiplexor which lets you create windows and splits in the terminal that you can attach and detach from. I use it to keep multiple projects open in separate windows and to create an IDE-like environment to work in where I can have my code open in vim/neovim and a shell open to run tests/scripts. Tmux is configured in [~/.tmux.conf](tmux/tmux.conf.symlink).

Tmux starts up automatically when opening zsh. If you don't like this behaviour change it at the end of the file [zsh](zsh/zshrc.symlink).

When tmux starts up, [login-shell](bin/login-shell) will be run and if it determines you are running this on macOS, it will call reattach-to-user-namespace, to fix the system clipboard for use inside of tmux.

## Tmux Cheatsheet

```bash
tmux                            # Start new session
tmux new -s myname              # Start new session with name
tmux a                          # Or 'tmux attach'. Attach to the first session listed
tmux a -t myname                # Attach to named session
tmux kill-session -t myname     # Kill session
tkl                             # Kill all tmux sessions
tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill
```

There are some tmux shortcuts found in [zsh/tmux.zsh](zsh/tmux.zsh).
You can list the custom tmux liases configured in that file with `tla`.

For the next commands you have to press the prefix first. The prefix is `ctrl+a`. The default prefix is `ctrl+b` but it's disabled in my configuration.

### Sessions

```bash
:new<CR>                        # New session
s                               # List sessions
$                               # Name current session
```

### Various
```bash
d                               # Disconnect from current session
?                               # List shortcuts
t                               # Shows a big clock
:                               # Let's you enter tmux commands
```

### Windows (tabs)

```bash
c                               # Create window
w                               # List windows
n                               # Next window
p                               # Previous window
f                               # Find window
,                               # Name window
&                               # Close window
```
### Panes (splits)

```bash
%                               # Vertical split
"                               # Horizontal split
o                               # Cycle through panes
q                               # Show pane numbers, press the number to go to that pane
x                               # Close pane
+                               # Break pane into window (e.g. to select text by mouse to copy)
-                               # Restore pane from window
⍽(space)                        # Toggle between layouts
{                               # Move the current pane left
}                               # Move the current pane right
z                               # Toggle pane zoom
```
## Custom Tmux Keybindings

```bash
Escape                          # Vi mode, enables movement like in vi
v (vi mode)                     # Selects text
y (vi mode)                     # Copy text to system clipboard
p                               # Paste text from system clipboard
y                               # Synchronize panes from a window
e                               # Edit configuration file
r                               # Reload configuration file
N                               # Open new window
|                               # Partir ventana verticalmente
-                               # Partir ventana horizontalmente
h                               # Moverse al panel izquierdo
j                               # Moverse al panel inferior
k                               # Moverse al panel superior
l                               # Moverse al panel derecho
ctrl+h                          # Go to left window
ctrl+l                          # Go to right window
H                               # Resize current pane left
J                               # Resize current pane down
K                               # Resize current pane up
L                               # Resize current pane right
```
## Vim Configuration
Take a look at my [.vimrc](config/nvim/init.vim).

## Tmux Cheatsheet
If you need to see the vim commands I recommend you print a cheatsheet like
![this one](http://www.viemu.com/vi-vim-dvorak-cheat-sheet.gif)

## Todo List
* Port the installation to distros that aren't based on debian.
* Install first the essential things to begin programming and leave interactive installs for last.
* Add the posibility for another cloud storage service.
* Fix [jDownloader install](jdownloader-install).
* Fix [go install](install/go-install).
* Fix [not asking for passwords](no-password-prompt).
* Fix installation in [Virtual Machine](virtual-machine).
* youcompleteme install should depend on the packages found in the system.
* Also to have a quicker setup it should install the basic and come to it later to make a more complete installation.
* Add [unattended-upgrades](install/unattended-upgrades) in Linux Mint.
* Fix some errors:
Error detected while processing function UltiSnips#TrackChange[1]..provider#python3#Call:
line 18:
Invalid channel "2"
