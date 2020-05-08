## Contents

* [Initial Setup and Installation](#initial-setup-and-installation)
* [Vim and Neovim Setup](#vim-and-neovim-setup)
* [Prompt](#prompt)
* [Fonts](#fonts)
* [Mappings](#mappings)
  * [ZSH Mappings](#zsh-mappings)
  * [Git Mappings](#git-mappings)
  * [Tmux Mappings](#tmux-mappings)
    * [Tmux Cheatsheet](#tmux-cheatsheet)
    * [Sessions](#sessions)
    * [Various](#various)
    * [Windows (tabs)](#windows-tabs)
    * [Panes (splits)](#panes-splits)
    * [Custom Tmux Keybindings](#custom-tmux-keybindings)
  * [Vim Mappings](#vim-mappings)
    * [Vim Cheatsheet](#vim-cheatsheet)
    * [Custom Vim Keybindings](#custom-vim-keybindings)
* [WSL](#wsl)
* [Todo list](#todo-list)

# Dotfiles

This is a collection of vim, tmux, and zsh configurations. Interested in a video walkthrough of the dotfiles? Check out [vim + tmux](https://www.youtube.com/watch?v=5r6yzFEXajQ).

Obviously this setup works for me, a JavaScript developer on macOS, but this particular setup may not work for you. If this particular setup doesn't work for you, please steal ideas from this and contribute back tips, tricks, PRs, and other tidbits if you want!

To install only the dotfiles do:

```bash
git clone https://github.com/ajr-dev/post-install-script.git ~/.dotfiles
~/.dotfiles/install/dotfiles.sh
```

## Initial Setup and Installation

This line will download the repository to your computer and ask you what you want to install.
The repository will be placed in the `.dotfiles` folder, so be sure to change that folder's name
if you are already using it.

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ajr-dev/post-install-script/master/install.sh)"
```

If you only want to do a quick configuration of the dotfiles without installing anything give the parameters `qy`
To install things by default give it the parameter `y`. It won't ask for confirmation.

```bash
git clone https://github.com/ajr-dev/post-install-script.git ~/.dotfiles
cd ~/.dotfiles
./install.sh -qy
```

Next, the install script will perform a check to see if it is running on an OSX machine. If so, it will install Homebrew if it is not currently installed and will install the homebrew packages listed in [`brew.sh`](install/brew.sh). Then, it will run [`osx.sh`](install/osx.sh) and change some OSX configurations. This file is pretty well documented and so it is advised that you __read through and comment out any changes you do not want__. Next, nginx (installed from Homebrew) will be configured with the provided configuration file. If a `nginx.conf` file already exists in `/usr/local/etc`, a backup will be made at `/usr/local/etc/nginx/nginx.conf.original`.

### Prompt

The prompt is meant to be simple while still providing a lot of information to the user, particularly about the status of the git project, if the PWD is a git project. This prompt sets `precmd`, `PROMPT` and `RPROMPT`. The `precmd` shows the current working directory in it and the `RPROMPT` shows the git and suspended jobs info. The main symbol used on the actual prompt line is `❯`.

The prompt will also display a `✱` character in the `RPROMPT` indicating that there is a suspended job that exists in the background. This is helpful in keeping track of putting vim in the background by pressing CTRL-Z.

The git info shown on the `RPROMPT` displays the current branch name, along with the following symbols.

-  `+` - New files were added
-  `!` - Existing files were modified
-  `?` - Untracked files exist that are not ignored
-  `»` - Current changes include file renaming
-  `✘` - An existing tracked file has been deleted
-  `$` - There are currently stashed files
-  `=` - There are unmerged files
-  `⇡` - Branch is ahead of the remote (indicating a push is needed)
-  `⇣` - Branch is behind the remote (indicating a pull is needed)
-  `⇕` - The branches have diverged (indicating history has changed and maybe a force-push is needed)
-  `✔` - The current working directory is clean

## Vim and Neovim Setup

[Neovim](https://neovim.io/) is a fork and drop-in replacement for vim. in most cases, you would not notice a difference between the two, other than Neovim allows plugins to run asynchronously so that they do not freeze the editor, which is the main reason I have switched over to it. Vim and Neovim both use Vimscript and most plugins will work in both (all of the plugins I use do work in both Vim and Neovim). For this reason, they share the same configuration files in this setup. Neovim uses the [XDG base directory specification](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html) which means it won't look for a `.vimrc` in your home directory. Instead, its configuration looks like the following:

|                         | Vim        | Neovim                    |
|-------------------------|------------|---------------------------|
| Main Configuratin File  | `~/.vimrc` | `~/.config/nvim/init.vim` |
| Configuration directory | `~/.vim`   | `~/.config/nvim`          |

### Installation

Vim is likely already installed on your system. If using a Mac, MacVim will be installed from Homebrew. Neovim will also be installed from Homebrew by default on a Mac. For other systems, you may need to install Neovim manually. See their [web site](https://neovim.io) for more information.

[`link.sh`](install/link.sh) will symlink the XDG configuration directory into your home directory and will then create symlinks for `.vimrc` and `.vim` over to the Neovim configuration so that Vim and Neovim will both be configured in the same way from the same files. The benefit of this configuration is that you only have to maintain a single vim configuration for both, so that if Neovim (which is still alpha software) has issues, you can very seamlessly transition back to vim with no big impact to your productivity.

Inside of [`.zshrc`](zsh/zshrc.symlink), the `EDITOR` shell variable is set to `vi`, which I have aliased `vi` to `nvim` in [`aliases.zsh`](zsh/aliases.zsh), defaulting to Neovim for editor tasks, such as git commit messages. To use `vim` you would write `vim` instead of `vi`.

vim and neovim should just work once the correct plugins are installed. To install the plugins, you will need to open Neovim in the following way:

```bash
nvim +PlugInstall
```

## Fonts

I'm using Source Code Pro patched with symbols from [nerd-fonts](https://github.com/ryanoasis/nerd-fonts). Install it with [this script](install/settings/source-code-pro.sh). If you would prefer not to do this, then simply remove `Plug 'ryanoasis/vim-devicons'` from the [vimrc](config/nvim/init.vim).

## Mappings

Bookmark [this page](https://github.com/ajr-dev/post-install-script#contents) as you'll have to take a look at the mappings listed (or in the files and webs linked) here when you don't remember one you want to use.

### ZSH Mappings

Write `alias` to get a list of all aliases declared, `alias -m "pattern"` to print aliases matching, specified pattern. You can see the ones defined by OMZ in their [Cheatsheet](https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet). You can use `lza` to list my ZSH aliases (mnemonic) which are defined in [zsh/aliases.zsh](zsh/aliases.zsh). Take a look at how [zsh autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) work. If you want some custom configuration write it in `~/.zshrc.local`. ZSH is configured in the [zshrc.symlink](zsh/zshrc.symlink) file, which will be symlinked to the home directory. You can navigate zsh with [vi-mode commands](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode).

### Git Mappings

Take a look at [zsh aliases for git](https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet#Git) defined by OhMyZsh here. My zsh aliases for git are in [zsh/git.zsh](zsh/git.zsh). You can list them with `lga` (mnemonic: list git aliases)

### Tmux Mappings

Tmux is a terminal multiplexor which lets you create windows and splits in the terminal that you can attach and detach from. I use it to keep multiple projects open in separate windows and to create an IDE-like environment to work in where I can have my code open in vim/neovim and a shell open to run tests/scripts. Tmux is configured in [~/.tmux.conf](tmux/tmux.conf.symlink) and in [tmux/theme.sh](tmux/theme.sh), which defines the colors used, the layout of the tmux bar, and what what will be displayed, including the time and date, open windows, tmux session name, computer name.

When tmux starts up, [login-shell](bin/login-shell) will be run and if it determines you are running this on macOS, it will call reattach-to-user-namespace, to fix the system clipboard for use inside of tmux.

Tmux starts up automatically when opening zsh. If you don't like this behaviour change `ZSH_TMUX_AUTOSTART` to false in [zshrc](zsh/zshrc.symlink).

#### Tmux Cheatsheet

[The tmux shortcuts for zsh](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tmux), my zsh shortcuts for tmux are in [zsh/tmux.zsh](zsh/tmux.zsh). You can list the custom tmux liases configured in that file with `lta` (mnemonic: tmux list aliases). My custom tmux aliases and tmux configuration are in [tmux/tmux.conf.symlink](tmux/tmux.conf.symlink)

The default tmux bindings are in [tmux-cheatsheet.markdown](https://gist.github.com/MohamedAlaa/2961058). For those commands you have to press the prefix first. The prefix in my configuration is `ctrl+a`.

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

#### Sessions

```bash
:new<CR>                        # New session
s                               # List sessions
$                               # Name current session
```

#### Various
```bash
d                               # Disconnect from current session
?                               # List shortcuts
t                               # Shows a big clock
:                               # Let's you enter tmux commands
```

#### Windows (tabs)

```bash
c                               # Create window
w                               # List windows
n                               # Next window
p                               # Previous window
f                               # Find window
,                               # Name window
&                               # Close window
```
#### Panes (splits)

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
#### Custom Tmux Keybindings

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

### Vim Mappings

Take a look at my [.vimrc](config/nvim/init.vim) to see my vim aliases.

![Vim Cheatsheet](vim-cheatsheet.gif)

## WSL

TODO: [disable automatic updates](https://www.windowscentral.com/how-stop-updates-installing-automatically-windows-10#disable_automatic_windows_update_gpedit), [open files/folders with single click](https://www.makeuseof.com/tag/open-files-folders-one-click-windows/), [change key repeat registry](https://superuser.com/a/509811), [swap escape and caps lock](https://oktomus.com/posts/2018/swap-escape-caps-lock-windows/), [skip login window](https://www.cnet.com/how-to/automatically-log-in-to-your-windows-10-pc/), [install WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10), [install WSLtty](https://github.com/mintty/wsltty), install [nerd fonts](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts), install [color](https://github.com/retorillo/mintty-onedark/blob/master/.minttyrc) in C:Users\UserName\AppData\Roaming\wsitty\themes, [install neovim](install/apps/neovim.sh), [install tmux](install/apps/tmux.sh), [install dotfiles](install/dotfiles.sh), [install XServer](https://github.com/Microsoft/WSL/issues/892#issuecomment-275873108), [add copy to system clipboard in nvim](https://lloydrochester.com/post/vim/wsl-neovim-copy-paste/)

## Todo List

Properly comment dotfiles
https://github.com/nicknisi/dotfiles/commits/master?before=b56df6a22982836a56b9a30e77c84912866ce892+770
