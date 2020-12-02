#!/bin/bash
set -e

# ----------------------------------
# Colors
# ----------------------------------
NOCOLOR='\033[0m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BLUE='\033[1;34m'
RED='\033[0;31m'

OPENOPS_NAMED_GIT=${OPENOPS_NAMED_GIT:-"http://magick-source.net/OpenOps/named-server.git"}
OPENOPS_NAMED_DIR=${OPENOPS_NAMED_DIR:-"/tmp/named-server"}

check_yesno() {
  RES=$1

  if [ -z $RES ] || [ $RES = 'y' ] || [ $RES = 'Y' ]; then
    return 0
  fi

  return 1
}

if [ ! -f /etc/debian_version ]; then
  echo -e "${RED}ERROR: This install file was created for debian$NOCOLOR"
  echo -e "$YELLOW  * this doesn't seem to be running in debian.$NOCOLOR"
  echo -e "$YELLOW  Bailing out!!$NOCOLOR"

  exit 1;
fi

debian_version=$( cat /etc/debian_version )
OPENOPS_DEB_VERSION=$debian_version

echo -e "$BLUE>> Running in Debian $YELLOW$debian_version$NOCOLOR\n\n"

echo -e "$BLUE>> Installing dependenvies$NOCOLOR"
apt-get -y install git


echo -e "$BLUE>> Cloning OpenOps Named repo$NOCOLOR"

if [ -d $OPENOPS_NAMED_DIR ]; then
  echo -n -e "$YELLOW -- directory exists. Can I remove it? (Y/n) $NOCOLOR"
  read DROP_DIR

  if check_yesno $DROP_DIR; then
    
    echo -e "$BLUE -- Drop the current directory$NOCOLOR"
    rm -rf "$OPENOPS_NAMED_DIR"

  else
    
    echo -n -e "$YELLOW **** OK. Continue with the current version? (Y/n) $NOCOLOR"
    read USE_DIR

    if check_yesno $USE_DIR; then
      echo -e "$BLUE *** OK, moving on!$NOCOLOR"
    else
      echo -e "$RED STOPPING HERE!$NOCOLOR"
      exit 2;
    fi
  fi
fi

if [ -d $OPENOPS_NAMED_DIR ]; then

  cd "$OPENOPS_NAMED_DIR"
  git pull --rebase

else

  echo -e "$BLUE -- cloning '$YELLOW$OPENOPS_NAMED_GIT$BLUE'$NOCOLOR"
  git clone "$OPENOPS_NAMED_GIT" "$OPENOPS_NAMED_DIR"

fi

cd "$OPENOPS_NAMED_DIR"

# start the setup process
source $OPENOPS_NAMED_DIR/setup.sh

