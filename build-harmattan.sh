#!/bin/bash
DEBNAME=qmljewel_0.0.1_armel.deb
MAD=~/sw/opt/QtSDK/Madde/bin/mad
MADOPT="-t harmattan-platform-api"

$MAD $MADOPT qmake CONFIG+=harmattan
$MAD $MADOPT dpkg-buildpackage -nc -uc -us && \
scp ../$DEBNAME n950: && \
ssh n950 dpkg -i $DEBNAME
