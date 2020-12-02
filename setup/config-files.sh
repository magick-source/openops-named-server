#!/bin/bash

set -e

say $BLUE ">> Setting up configuration files"

render_file bind/named.conf $NAMED_DIR/etc/bind/named.conf

render_file bind/db.0 $NAMED_DIR/etc/bind/db.0

render_file bind/db.127 $NAMED_DIR/etc/bind/db.127

render_file bind/db.255 $NAMED_DIR/etc/bind/db.255

render_file bind/db.empty $NAMED_DIR/etc/bind/db.empty

render_file bind/db.local $NAMED_DIR/etc/bind/db.local

render_file bind/db.root $NAMED_DIR/etc/bind/db.root

render_file bind/zones.rfc1918 $NAMED_DIR/etc/bind/zones.rfc1918

say $BLUE ">>> Telling bind to chroot to $NAMED_DIR"

render_file bind/default-bind /etc/default/bind9

say $BLUE "++ Done with configuration files"


