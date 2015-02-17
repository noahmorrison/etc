#
# ~/.bashrc
#

if test -f ~/.profile
then
    source ~/.profile
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


ls_alias="ls --color=auto"
while read line
do
   if [[ $line ]] && [[ ${line:0:1} != '#' ]]
   then
       export ls_alias+=" -I \"$line\""
   fi
done < ~/.gitignore

alias ls=$ls_alias
alias la="ls -A"
alias rm="mv -t ~/.trash"

pypi () {
    python ./setup.py register -r pypitest &&
    python ./setup.py sdist upload -r pypitest &&

    python ./setup.py register -r pypi &&
    python ./setup.py sdist upload -r pypi
}

# Colors
c () { echo -e "\e[${1}m"; }
declare -A fg
fg[black]=`c 30`
fg[red]=`c 31`
fg[green]=`c 32`
fg[yellow]=`c 33`
fg[blue]=`c 34`
fg[purple]=`c 35`
fg[cyan]=`c 36`
fg[white]=`c 37`
fg[normal]=`c 0`

declare -A bg
bg[black]=`c 40`
bg[red]=`c 41`
bg[green]=`c 42`
bg[yellow]=`c 43`
bg[blue]=`c 44`
bg[purple]=`c 45`
bg[cyan]=`c 46`
bg[white]=`c 47`
bg[normal]=`c 0`


# Prompt
human () {
    local ms=$1
    local days=$(( ms / 1000 / 60 / 60 / 24 ))
    local hours=$(( ms / 1000 / 60 / 60 % 24 ))
    local minutes=$(( ms / 1000 / 60 % 60 ))
    local seconds=$(( ms / 1000 % 60 ))

    (( $days > 0 )) && echo -n "${days}d "
    (( $hours > 0 )) && echo -n "${hours}h "
    (( $minutes > 0 )) && echo -n "${minutes}m "
    (( $seconds > 0 )) && echo -n "${seconds}s"
    echo
}

timer_start () {
    timer=${timer:-`date +%s%3N`}
}

timer_stop () {
    timer_show=$((`date +%s%3N` - $timer))
    unset timer
}

prompt () {
    local EXIT="$?"
    timer_stop

    local top="\[${fg[cyan]}\]\w"
    if test $timer_show -gt 5000
    then
        top="$top \[${fg[yellow]}\]$(human $timer_show)"
    fi

    # Is a git repo
    if git rev-parse --git-dir > /dev/null 2>&1
    then
        local branch=`git rev-parse --abbrev-ref HEAD`
        local color="green"

        # There are uncommitted changes
        if [[ -n "$(git status -s)" ]]
        then
            color="red"
        fi

        top="$top \[${fg[$color]}\]$branch"
    fi

    local bot="\[${fg[white]}\]! \[${fg[normal]}\]"
    local boterr="\[${fg[red]}\]! \[${fg[normal]}\]"

    if test $EXIT = 0
    then
        echo "$top\\n$bot"
    else
        echo "$top\\n$boterr"
    fi
}

trap 'timer_start' DEBUG
PS1=`prompt`

##
## Readline
##

# no word wrap
bind 'set horizontal-scroll-mode on'

# nicer autocomplete
bind 'TAB:menu-complete'
# \e[Z is Shift-Tab
bind '"\e[Z":menu-complete-backward'

# History searching
bind 'Control-k:history-substring-search-backward'
bind 'Control-j:history-substring-search-forward'


##
## Better History
##

shopt -s histappend

HISTSIZE=10000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignorespace:ignoredups

PROMPT_COMMAND='builtin history -a'


##
## GNU Screen
##

function scr () {
    screen -S main -D -RR
}
