alias lga="grep -E '(=)' $MY_ZSH/git.zsh | less"  # list formatted aliases and descriptions

alias gl='git pull'
alias gp='git push'
alias gdns='git diff --name-status'  # show files that have changed between two branches (git dbr master..branch)
alias gmv='git mv'
alias gcf='git show --pretty="format:" --name-only'  # show 'changed files' (mnemonic) for a commit
alias grn='git-rename'

# alias git-amend='git commit --amend -C HEAD'
alias git-undo='git reset --soft HEAD~1'
alias git-count='git shortlog -sn'
alias git-undopush='git push -f origin HEAD^:master'
alias cpbr='git rev-parse --abbrev-ref HEAD | pbcopy'
alias gr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`'
alias sub-pull='git submodule foreach git pull origin master'  # update submodules 
alias gls='git log -S '  # mnemonic: git log search. Show commits where the given string appears
# Show commits of the day from  oldest to newest
alias gday='git log --all --reverse --date=local --since=yesterday.midnight --oneline'
alias gmine='git log --all --oneline --author=`git config --get user.name`'  # show my commits

function give-credit() {
    git commit --amend --author $1 <$2> -C HEAD
}

# a simple git rename file function, so that git tracks case-sensitive changes
function git-rename() {
    git mv $1 "${2}-"
    git mv "${2}-" $2
}

function g() {
    if  [[ $# > 0 ]];  then  # if there are arguments, send them to git
        git $@
    else  # otherwise, run git status
        git s
    fi
}
