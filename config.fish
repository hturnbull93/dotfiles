function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t $history[1]; commandline -f repaint
        case "*"
            commandline -i !
    end
end

function bind_dollar
    switch (commandline -t)[-1]
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar
end

# get the weather in london
alias 'weather'='curl wttr.in/London'

# clear
alias c='clear'

# dir movement
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'

# git commands
alias gs='git status'
alias gc='git commit -m'
alias gp='git push'
alias ga='git add -v'
alias gaa='git add . -v'

# add a tag
function gt
    git tag $argv
    git push --tags
end

# delete a tag
function gdt
    git tag -d $argv
    git push --delete origin $argv
end

# replace a tag
function grt
    git tag -d $argv
    git push --delete origin $argv
    git tag $argv
    git push --tags
end

# update everything
alias update='sudo apt-get update && sudo apt-get upgrade'

# fuzzy error fix
thefuck --alias | source
