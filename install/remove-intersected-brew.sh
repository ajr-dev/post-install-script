#!/bin/bash

brew list >> brewList.txt
if [ $? -eq 0 ]; then
    dpkg-query -l >> dpkgList.txt
    if [ $? -eq 0 ]; then
        grep -Fx -f brewList.txt dpkgList.txt >> intersectedList.txt
        if [ $? -eq 0 ]; then
            # you can place * after the backtick, if you want to remove node (or nodejs)
            sudo apt-get remove "$(cat intersectedList.txt)"
            if [ $? -eq 0 ]; then
                echo OK
            else
                echo "Task not completed!"
            fi
        else
            echo "grep -Fx -f brewList.txt dpkgList.txt error!"
        fi
    else
        echo "dpkg-query error!"
    fi
else
    echo "brew list!"
fi
