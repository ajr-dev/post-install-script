# TODO: improve. Take a look at this https://github.com/Gaz2600/Windows-10-1803-Post-Install-Script/blob/master/Run_Once.ps1

##################################################################
# Check if running as admin, if not open a new instance as Admin #
##################################################################

If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{   
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

# Reverse scrolling

# Install other browsers

# Disable everything on privacy
# Disable notifications on System
# Disable system sounds on System -> Sound -> Advanced
# Enhanced Search

# Task Manager Ctrl + Shift + Esc -> Options -> always on top

# User Account Control -> Never notify

# Disable lock screen
# Registry -> Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization
# New DWORD 32 bit 'NoLockScreen' value 1

# Enable hibernate. Settings -> System -> Power -> Advanced

# Speed up shutdowns
# Registry -> Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control
# Lower 'WaitToKillServiceTimeout' set 2000

# Computer\HKEY_CURRENT_USER\Control Panel\Desktop
# New String Value 'WaitToKillAppTimeout' set 2000
# New String Value 'HungAppTimeout' set 2000
# New String Value 'AutoEndTasks' set 1

# Skip Recycle Bin
# Right-click on the Recycle Bin icon (either on the desktop, taskbar or within the Start Menu) and choose 'Properties'
# Under 'Settings for selected location', ensure you select the option which says 'Don’t move files to the Recycle Bin. Remove files immediately when deleted.'

# File Explorer -> View -> Check 'File name extensions' and 'Hidden items'. Select options. 'Single click', Disable 'Show recently and frequently used files'.
# Display full path in the title bar.
# Launch folder windows in a separate process.
# Uncheck minimize the ribbon.
# Display undo and redo.

# Set Any Folder as Default for Explorer
# Create a shortcut to the folder on your desktop.
# Move that shortcut to %APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar
# Rename and replace to 'File Explorer'

# Mute windows all sounds:
# Control Panel (Large or Small icons) and select Sound, now select the Sounds tab. Under Sound Scheme change it to No Sounds, at the bottom click Apply then OK.

# Install PowerToys and swap escape with caps lock.
# Remap shortcuts:
# Ctrl(Left) + Alt(Left) + Left -> Win(Left) + Ctrl(Left) + Left
# Ctrl(Left) + Alt(Left) + Up -> Win(Left) + Tab
# Ctrl(Left) + Alt(Left) + Right -> Win(Left) + Ctrl(Left) + Right

# OR place a shortcut to an AutoHotkey script in the Startup folder:
    Find the script file, select it, and press Ctrl+C.
    Press Win+R to open the Run dialog, then enter shell:startup and click OK or Enter. This will open the Startup folder for the current user. To instead open the folder for all users, enter shell:common startup (however, in that case you must be an administrator to proceed).
    Right click inside the window, and click "Paste Shortcut". The shortcut to the script should now be in the Startup folder.

# Check what programs are in the explorer contextual menu.

# Check what programs run at startup.

# Enable VSM on the BIOS. Install WSL.

# Enable WSL and VirtualMachinePlatform features
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Download and install the Linux kernel update package
$wslUpdateInstallerUrl = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
$downloadFolderPath = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
$wslUpdateInstallerFilePath = "$downloadFolderPath/wsl_update_x64.msi"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($wslUpdateInstallerUrl, $wslUpdateInstallerFilePath)
Start-Process -Filepath "$wslUpdateInstallerFilePath"

# Set WSL default version to 2
wsl --set-default-version 2

# Install linux distribution and terminal from the microsoft store.
# Download your favorite font from https://www.nerdfonts.com/font-downloads
# Choose a Windows Terminal theme
# https://medium.com/@hjgraca/style-your-windows-terminal-and-wsl2-like-a-pro-9a2e1ad4c9d0

# Get the SSH agent running when WSL starts
# sudo apt install keychain
# eval ``keychain --eval --agents ssh id_rsa

# To install homebrew on WSL
sudo apt update
sudo apt install -y build-essential curl file git
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/ajr-dev/.zprofile

brew install node
npm install -g grunt-cli

python3 -m pip install --upgrade pip
pip3 install neovim

nvim +PlugInstall

# Change default view on Windows Explorer
1. Open up a window in File Explorer (or hit START BUTTON followed by the letter E).

2. Open up the View Ribbon, and select the view option. In your case, you would select "large icons".

3. Still in the View Ribbon, select the "Options" icon (on the far right). If a menu drops down, select "change folder and search options".

4. From this point, things should look just like Windows XP or Windows 7. The "Folder Options" dialog should pop up. Select the "View" tab, and click the "Apply to Folders" button.

Install X-Server on Windows 10
https://sourceforge.net/projects/vcxsrv/
Create a shortcut with the following target:
"C:\Program Files\VcXsrv\vcxsrv.exe" :0 -ac -terminate -lesspointer -multiwindow -clipboard -wgl -dpi auto
Add X-Server to Startup Program
Press Windows Key + R and shell:startup
For more information:
https://medium.com/javarevisited/using-wsl-2-with-x-server-linux-on-windows-a372263533c3
