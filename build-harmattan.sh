#!/bin/bash
BUILDDIR=build/harmattan
MADBIN=~/sw/opt/QtSDK/Madde/bin/mad
# MADOPT="-t harmattan-platform-api"
#MADOPT="-t harmattan_10.2011.34-1"
MADOPT="-t harmattan_10.2011.34-1_rt1.2"

cd $BUILDDIR
$MADBIN $MADOPT qmake && \
$MADBIN $MADOPT dpkg-buildpackage -nc -uc -us && \
echo "FINISHED:" $(date)
