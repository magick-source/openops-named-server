#!/bin/bash

set -e

say $BLUE "\n\n\n>> Installing/Updating debian packages"

say $YELLOW " -- updating repo indexes"
apt-get update

say $YELLOW "\n\n -- Installing Bind"
apt-get -y install bind9

say $BLUE "++ Packages done\n\n"

