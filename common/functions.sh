#!/bin/bash

set +e

NOCOLOR='\033[0m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BLUE='\033[1;34m'
RED='\033[0;31m'

check_yesno() {
  RES=$1
  
  if [ -z $RES ] || [ $RES = 'y' ] || [ $RES = 'Y' ]; then
    return 0
  fi

  return 1
}

function say() {
  COLOR=$1
  MSG=$2

  echo -e "$COLOR$MSG$NOCOLOR"
}

function create_directory() {
  DIR=$1
  OWNER=${2:-root}
  MODE=${3:-755}

  if [ ! -d $DIR ]; then

    say $YELLOW " -- creating $DIR"
    mkdir -p $DIR
    chown $OWNER $DIR
    chmod $MODE $DIR

  fi

}

function render_file() {
  SOURCE=$1
  TARGET=$2

  SOURCE="$OPENOPS_MAIL_DIR/config-files/$SOURCE"

  say $YELLOW " -- rendering '$TARGET'"
  envsubst $OPENOPS_MAIL_VARIABlES <$SOURCE >$TARGET

}
