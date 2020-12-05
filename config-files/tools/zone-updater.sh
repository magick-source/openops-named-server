#!/bin/bash

set -e

. $HOME/.openops_named.cfg


ZONE_DIR=${NAMED_DIR:-"$NAMED_DIR"}/zones

ZONE_GITDIR=${ZONE_GITDIR:-"/root/git/zones"}

if [ ! -d $ZONE_GITDIR ]; then
  ZONE_GIT=${1:-"$ZONE_GIT"}
  if [ -z "$ZONE_GIT" ]; then
    echo "FATAL: Repository doesn't exist in '$ZONE_GITDIR'"
    echo "   and \$ZONE_GIT is not set (and no parameter passed)"
    echo -e "\nBAILING OUT!"

    exit 1;
  fi

  mkdir -p $ZONE_GITDIR
  cd $ZONE_GITDIR

  echo "Cloning '$ZONE_GIT' into '$ZONE_GITDIR'"
  git clone "$ZONE_GIT" .

else 

  cd $ZONE_GITDIR
  git fetch --all
  git reset --hard origin/master
  
fi

rsync -rvu --delete "$ZONE_GITDIR/zones/" "$ZONE_DIR"

if [ ! -f "$ZONE_GITDIR/lists.conf" ]; then

  cd "$ZONE_DIR"
  >lists.conf
  for fname in *.list.conf; do
    echo "include \"/zones/$fname\";" >>lists.conf
  done

fi

/etc/init.d/bind9 restart

