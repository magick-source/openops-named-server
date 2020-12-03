#!/bin/bash

set -e

say $BLUE ">> Setting up zone updater"

create_directory /root/tools root

render_file tools/zone-updater.sh /root/tools/zone-updater.sh
chmod +x /root/tools/zone-updater.sh

if [ ! -z "$ZONE_GIT" ]; then
  say $BLUE " -->> Updating zones"

  /root/tools/zone-updater.sh

else

  say $CYAN "the zone-updater is ready to use in /root/tools/zone-updater.sh"
  say $CYAN "usage: /root/tools/zone-updater.sh <git_repo> "

fi

say $BLUE " ++ zone-updater is in place"
