# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
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

export PATH="$HOME/Documents/Code/general/llvm-project/build/bin:$PATH"

export PATH="$HOME/Software/lang5:$PATH"
alias nk=~/Software/k/k
alias nkr="rlwrap ~/Software/k/k ~/Software/k/repl.k"
alias bqnr="rlwrap ~/Software/CBQN/BQN"
alias k9=~/Software/li2.0
alias k9r="rlwrap ~/Software/li2.0"
alias md="~/Software/md.sh"
alias ktk="~/Software/+/k+"
alias ktkr="rlwrap ~/Software/+/k+"
alias lsr="rlwrap sbcl --load ~/Software/nodebug"
alias lsd="rlwrap sbcl"
alias nb="netbeans --laf Nimbus -J-Dswing.aatext=true -J-Dawt.useSystemAAFontSettings=lcd"
alias k4r="rlwrap ~/q/l32/q"
alias factor="~/Software/factor/factor"
alias jt=~/Documents/Code/gen/truffleruby-ws/truffleruby/bin/jt
alias tree-sitter=~/Documents/Code/gen/tree-sitter-factor/node_modules/.bin/tree-sitter
alias spl=~/Software/scryer-prolog/target/release/scryer-prolog
alias gpl=gprolog
alias notes="kak ~/Documents/notes/main/Things\ To\ Do.md ~/Documents/notes/main/Things\ completed.md"
alias maude="~/Software/Maude/maude.linux64"

export PATH=$PATH:$HOME/Software/Nial_Development/BuildNial/build
export PATH=$PATH:$HOME/Software/j903/bin
# mkcert for code.golf
export PATH=$PATH:$HOME/Software/mkcert
export PATH=$PATH:$HOME/Software
# Python Poetry lib manager 
export PATH="$PATH:/home/razetime/.local/bin"
# export SAXDIR=/usr/sax/rel
# export PATH=$SAXDIR/bin/:$PATH
# export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export AOC_SESSION=53616c7465645f5fb6fd9d8e29a7495551d9b1cd6776e6665652af073ab632495c5899896cd19150d5232a267cb5250a3096c728c4b11b22e7a7327744d5058d

# source ~/Software/emsdk/emsdk_env.sh
source /usr/local/share/chruby/chruby.sh

source /etc/profile
eval "$(/home/razetime/.rakubrew/bin/rakubrew init Bash)"
eval $(opam env)
tmux -u
tmux source-file ~/.tmux.conf
chruby ruby-3.0.3
clear

PATH="/home/razetime/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/razetime/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/razetime/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/razetime/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/razetime/perl5"; export PERL_MM_OPT;
. "$HOME/.cargo/env"

