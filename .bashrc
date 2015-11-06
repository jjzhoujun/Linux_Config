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
    xterm-color) color_prompt=yes;;
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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
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


# for java1.6 to compile Android4.4. Such as RTK.
#JAVA_HOME=/home/jayden/ProgramFiles/jdk1.6.0_45
#JAVA_JRE=/home/jayden/ProgramFiles/jdk1.6.0_45/jre
# for java1.7 to compile Android5.0. Such Hisi.
JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
JAVA_JRE=/usr/lib/jvm/java-7-openjdk-amd64/jre
PATH=$PATH:$JAVA_HOME/bin:$JAVA_JRE/bin
CLASSPATH=.:$JAVA_HOME/lib:$JAVA_JRE/lib
export JAVA_HOME
export JAVA_JRE
export PATH
export CLASSPATH

#Cross path for Hisi., This will set JAVA1.7 Path .
HI_CO_64=/opt/hisi-linux/arm64/aarch64-linux-gnu/bin
HI_CO=/opt/hisi-linux
HI_32=/opt/hisi-linux/x86-arm/arm-hisiv200-linux/bin
HI_32_TAR=/opt/hisi-linux/x86-arm/arm-hisiv200-linux/target/bin
PATH=$PATH:$HI_CO_64:$HI_CO:$HI_32:$HI_32_TAR
export PATH

umask 022
###### Change to 1.6 Need to delete this ln 
#jayden@X250:trunk_dtmb$ sudo ln -s /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java /usr/lib/jvm/java-7-openjdk-amd64/bin/java
#jayden@X250:trunk_dtmb$ ll /usr/lib/jvm/java-7-openjdk-amd64/bin/java
#lrwxrwxrwx 1 root root 46 Oct 21 22:16 /usr/lib/jvm/java-7-openjdk-amd64/bin/java -> /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java*


# for android
ANDROID_PLATFORM_TOOLS=/home/jayden/ProgramFiles/Android_Tool/sdk/platform-tools
ANDROID_TOOLS=/home/jayden/ProgramFiles/Android_Tool/sdk/tools
ANDROID_NDK=/home/jayden/ProgramFiles/Android_Tool/android-ndk-r10e
GRADLE=/home/jayden/ProgramFiles/Android_Tool/gradle-2.3/bin
#GRADLE=/home/jayden/ProgramFiles/Android_Tool/gradle-2.0/bin
PATH=$PATH:$ANDROID_PLATFORM_TOOLS:$ANDROID_TOOLS:$ANDROID_NDK:$GRADLE
CLASSPATH=.:$ANDROID_TOOLS/lib
export ANDROID_PLATFORM_TOOLS
export ANDROID_TOOLS
export PATH
export CLASSPATH


export LANGUAGE=en_HK:en
export LC_ALL=en_US.UTF-8

# Notify long time task.
#. /usr/share/undistract-me/long-running.bash
#notify_when_long_running_commands_finish_install
