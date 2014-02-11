# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Make bash append rather than overwrite the history on disk
shopt -s histappend

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# History Options
#
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
#
# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"

# Aliases
#
 alias grep='grep --color'                     # show differences in colour
 alias egrep='egrep --color=auto'              # show differences in colour
 alias fgrep='fgrep --color=auto'              # show differences in colour
 alias igrep='grep -i'
 alias lookfor='ls -lrt | igrep '
#
# Some shortcuts for different directory listings
 alias ls='ls -hF --color=tty'                 # classify files in colour
 alias dir='ls --color=auto --format=vertical'
 alias vdir='ls --color=auto --format=long'

# Load local customisations
 if [ -f "${HOME}/.bashrc.local" ]; then
   source "${HOME}/.bashrc.local"
 fi

# other
alias reload_config="source ${HOME}/.bashrc"

if [ -e "${HOME}/tools" ]; then
    export PATH=$PATH:${HOME}/tools
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export SVN_EDITOR=vim


function set_PS1_title
{
    if [[ -n $SSH_CLIENT ]] || [[ -n $SSH_TTY ]]; then
            IS_REMOTE_SESSION=true
    fi

    # set PS1
    if [[ -z $IS_REMOTE_SESSION ]]; then
	export PS1="\n(\[\e[32m\]\u@\h) \[\e[33m\]\w\[\e[0m\]\n\$ "
    else
	export PS1="\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ "
    fi
    
    # Set the term title
    case $TERM in
        xterm*)
    	if [[ -z $IS_REMOTE_SESSION ]]; then
    	    PROMPT_COMMAND='printf "\033]0;%s\007" "${PWD/#$HOME/~}"'
    	else
    	    PROMPT_COMMAND='printf "\033]0;%s@%s %s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    	fi
    
        ;;
        screen)
    	if [[ -z $IS_REMOTE_SESSION ]]; then
    	    PROMPT_COMMAND='printf "\033]0;%s\033\\" "${PWD/#$HOME/~}"'
    	else
    	    PROMPT_COMMAND='printf "\033]0;%s@%s %s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    	fi
        ;;
    esac
}

set_PS1_title
