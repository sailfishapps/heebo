#!/bin/bash
./build-harmattan.sh && scp $(ls -1v build/*deb | tail -n1) n9:
