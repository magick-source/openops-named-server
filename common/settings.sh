#!/bin/bash

export OPENOPS_NAMED_VARIABLES='$NAMED_DIR'

echo -e "$BLUE>> Checking configs$NOCOLOR"

if [ -f "$HOME/.openops_named.cfg" ]; then

  echo -e "$YELLOW -- config file found. loading$NOCOLOR"
  . $HOME/.openops_named.cfg

else
  echo -n -e "$YELLOW Base directory for bind [/servers/named/]: "
  read NAMED_DIR
  export NAMED_DIR=${NAMED_DIR:-"/servers/named/"}

  echo >$HOME/.openops_named.cfg <<EoC

export NAMED_DIR="$NAMED_DIR"

EoC

fi

export NAMED_DIR=${NAMED_DIR:-"/servers/named/"}
echo -e "$BLUE NAMED_DIR=$YELLOW$NAMED_DIR$NOCOLOR"


