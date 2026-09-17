# Begin ~/.bashrc
# Written for Beyond Linux From Scratch
# by James Robertson <jameswrobertson@earthlink.net>

# Personal environment variables and startup programs should go in
# ~/.bash_profile.  System wide environment variables and startup
# programs are in /etc/profile.  System wide aliases and functions are
# in /etc/bashrc.

if [ -f "/etc/bashrc" ] ; then
  source /etc/bashrc
fi

if [ -d "$HOME/bin" ] ; then
  pathprepend $HOME/bin
fi

if [ -d "$HOME/.local/share/bin" ] ; then
  pathprepend $HOME/.local/share/bin
fi

if [ -d "$HOME/.local/share/bin" ] ; then
  pathprepend $HOME/.local/share/platform-tools
fi

if [ -d "$HOME/.local/share/bin" ] ; then
  pathprepend $HOME/.local/share/arduino-ide
fi

if [ -d "$HOME/.local/share/bin" ] ; then
  pathprepend $HOME/.local/share/simulide
fi

# Set up user specific i18n variables
# export LANG=<ll>_<CC>.<charmap><@modifiers>

# User specific aliases
alias beroot="su -"
alias fetch="fastfetch -l none"
alias fetchm="fastfetch --logo-type kitty-direct --logo media-cover"

# End ~/.bashrc
