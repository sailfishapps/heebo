#!/bin/bash
DEBNAME=qmljewel_0.0.1_armel.deb

~/sw/opt/QtSDK/Madde/bin/mad -t harmattan-platform-api dpkg-buildpackage -nc -uc -us && \
scp ../$DEBNAME root@192.168.2.15: && \
ssh root@192.168.2.15 dpkg -i $DEBNAME
