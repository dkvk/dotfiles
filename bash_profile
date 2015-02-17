### Aliases

# Open specified files in Sublime Text
# "s ." will open the current directory in Sublime
alias s='open -a "Sublime Text"'

# Color LS
colorflag="-G"
alias ls="command ls ${colorflag}"
alias l="ls -lF ${colorflag}" # all files, in long format
alias la="ls -laF ${colorflag}" # all files inc dotfiles, in long format
alias lsd='ls -lF ${colorflag} | grep "^d"' # only directories

# Quicker navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Shortcuts to my Code folder in my home directory
alias webdev="cd ~/Webdev"
alias sites="cd ~/Code/sites"

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Colored up cat!
# You must install Pygments first - "sudo easy_install Pygments"
alias c='pygmentize -O style=monokai -f console256 -g'

# Git 
# You must install Git first - ""
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m' # requires you to type a commit message
alias gp='git push'


### Prompt Colors 
# Modified version of @gf3’s Sexy Bash Prompt 
# (https://github.com/gf3/dotfiles)
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
	tput sgr0
	if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
		BLACK=$(tput setaf 190)
		MAGENTA=$(tput setaf 9)
		ORANGE=$(tput setaf 172)
		GREEN=$(tput setaf 190)
		PURPLE=$(tput setaf 141)
		WHITE=$(tput setaf 0)
	else
		BLACK=$(tput setaf 190)
		MAGENTA=$(tput setaf 5)
		ORANGE=$(tput setaf 4)
		GREEN=$(tput setaf 2)
		PURPLE=$(tput setaf 1)
		WHITE=$(tput setaf 7)
	fi
	BOLD=$(tput bold)
	RESET=$(tput sgr0)
else
	BLACK="\033[01;30m"
	MAGENTA="\033[1;31m"
	ORANGE="\033[1;33m"
	GREEN="\033[1;32m"
	PURPLE="\033[1;35m"
	WHITE="\033[1;37m"
	BOLD=""
	RESET="\033[m"
fi

export BLACK
export MAGENTA
export ORANGE
export GREEN
export PURPLE
export WHITE
export BOLD
export RESET

# Git branch details
function parse_git_dirty() {
	[[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}
function parse_git_branch() {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Git autocompletion
source ~/.git-completion.bash

# Change this symbol to something sweet. 
# (http://en.wikipedia.org/wiki/Unicode_symbols)
symbol="⚡ "

export PS1="\[${BOLD}${MAGENTA}\]\u \[$WHITE\]in \[$GREEN\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]\n$symbol\[$RESET\]"
export PS2="\[$ORANGE\]→ \[$RESET\]"


### Misc

# Only show the current directory's name in the tab 
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

# init z! (https://github.com/rupa/z)
. ~/z.sh


# SSH autocompletion
_complete_ssh_hosts () {
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        comp_ssh_hosts=`egrep -v '^[#\[]' ~/.ssh/known_hosts|\
                cut -f 1 -d ' '|sed -e 's/[,:].*//g'|uniq;
                awk '/^Host/ { print $2; }' ~/.ssh/config`
        COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
        return 0
}
complete -F _complete_ssh_hosts ssh
export PATH=/usr/local/memcached/bin:$PATH
export MANPATH=/usr/local/memcached/share/man:$MANPATH
export PATH=/usr/local/cmake/bin:$PATH
export MANPATH=/usr/local/cmake/man:$MANPATH
export PATH=/usr/local/mysql/bin:$PATH
export MANPATH=/usr/local/mysql/man:$MANPATH
export PATH=/usr/local/php5/bin:/usr/local/php5/sbin:$PATH
export PATH=/usr/local/node/bin:$PATH
export MANPATH=/usr/local/node/share/man:$MANPATH
export PATH=/usr/local/memcached/bin:$PATH
export MANPATH=/usr/local/memcached/share/man:$MANPATH
export PATH=/usr/local/pcre/bin:$PATH
export PATH=/usr/local/nginx/sbin:$PATH
export PATH=/usr/local/rbenv/bin:$PATH
export RBENV_ROOT=/usr/local/rbenv
eval "$(rbenv init -)"
export PATH=/usr/local/openssl/bin:$PATH
export MANPATH=/usr/local/openssl/ssl/man:$MANPATH
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH=/usr/local/sbin:$PATH
