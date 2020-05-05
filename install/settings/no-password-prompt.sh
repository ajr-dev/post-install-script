# http://askubuntu.com/questions/136264/how-do-i-turn-off-all-the-password-prompts
# http://askubuntu.com/questions/43969/how-to-make-ubuntu-remember-forever-the-password-after-the-first-time
# http://askubuntu.com/questions/534125/never-ask-me-for-passwords?lq=1
# TODO fix this sed command
if [ ! -f /etc/sudoers.bak ]; then # https://askubuntu.com/questions/406787/best-way-add-nopasswd-vagrant-user
    sudo groupadd -r admin
    #sudo usermod -a -G admin vagrant
    #sudo sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=admin' /etc/sudoers
    #sudo sed -i -e 's/%admin ALL=(ALL) ALL/%admin ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers
    sudo cp /etc/sudoers /etc/sudoers.bak
    echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
fi
