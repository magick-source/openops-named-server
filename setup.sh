#!/bin/bash

set -e

if [ ! -f /etc/debian_version ]; then
  
  echo -e "${RED}ERROR: This install file was created for debian$NOCOLOR"
  echo -e "$YELLOW  * this doesn't seem to be running in debian.$NOCOLOR"
  echo -e "$YELLOW  Bailing out!!$NOCOLOR"

  exit 1;
fi

debian_version=$( cat /etc/debian_version )
OPENOPS_DEB_VERSION=$debian_version

# TODO(maybe) = use $0 directory as the default?
OPENOPS_NAMED_DIR=${OPENOPS_NAMED_DIR:-"/tmp/named-server"}

if [ ! -d $OPENOPS_NAMED_DIR ]; then
  echo "**** ERROR: Expected OpenOps Named in $OPENOPS_NAMED_DIR"
  echo "     --- Directory not found"
  echo "you can export OPENOPS_NAMED_DIR=<...> to define where it is"
  exit 1;
fi

cd "$OPENOPS_NAMED_DIR"

# just some shared functions
source $OPENOPS_NAMED_DIR/common/functions.sh

# read settings
source $OPENOPS_NAMED_DIR/common/settings.sh

# install the needed packages
source $OPENOPS_NAMED_DIR/common/packages.sh

# setup chroot env
source $OPENOPS_NAMED_DIR/setup/chroot-env.sh

# setup config files
source $OPENOPS_NAMED_DIR/setup/config-files.sh

# setup tool to update the zones
source $OPENOPS_NAMED_DIR/setup/set-zone-updater.sh


