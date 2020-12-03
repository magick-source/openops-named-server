#!/bin/bash

set -e

say $BLUE "\n\n\n>> Setting up chroot environment"

create_directory $NAMED_DIR/etc/bind root

create_directory $NAMED_DIR/dev root

create_directory $NAMED_DIR/var/cache/bind bind:root

create_directory $NAMED_DIR/var/run/bind/run bind:root

say $YELLOW " -- creating null and random devnodes"

if [ ! -e $NAMED_DIR/dev/null ]; then 
  mknod -m 666 $NAMED_DIR/dev/null c 1 3
fi

if [ ! -e $NAMED_DIR/dev/random ]; then
  mknod -m 666 $NAMED_DIR/dev/random c 1 8
fi

cp -v /etc/bind/bind.keys $NAMED_DIR/etc/bind/bind.keys

cp -v /etc/bind/rndc.key $NAMED_DIR/etc/bind/rndc.key

#TODO: fix the issues with apparmor and //run error

say $BLUE "++ chroot environment done"

