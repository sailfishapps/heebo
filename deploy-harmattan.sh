#!/bin/bash
./build-harmattan.sh
DEBNAME=$(ls -1v build/heebo_*deb | tail -n1 | cut -d \/ -f 2-)
scp build/$DEBNAME n950:
## && ssh n950 dpkg -i $DEBNAME
