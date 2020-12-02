#!/bin/bash

export OPENOPS_NAMED_VARIABLES='$NAMED_DIR'

echo -e "$BLUE>> Checking configs$NOCOLOR"

if [ -f "$HOME/.openops_named.cfg" ]; then

  echo -e "$YELLOW -- config file found. loading$NOCOLOR"
  . $HOME/.openops_named.cfg

else

  echo -e "$YELLOW -- config file not found. creating$NOCOLOR"

  echo -e "$RED TODO: ask for the config variables and store in file$NOCOLOR"
  exit 1;
fi

export NAMED_DIR=${NAMED_DIR:-"/server/named/"}
echo -e "$BLUE NAMED_DIR=$YELLOW$NAMED_DIR$NOCOLOR"


