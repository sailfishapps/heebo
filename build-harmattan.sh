#!/bin/bash
MAD=~/sw/opt/QtSDK/Madde/bin/mad
MADOPT="-t harmattan-platform-api"

cd build/harmattan
$MAD $MADOPT qmake CONFIG+=harmattan
$MAD $MADOPT dpkg-buildpackage -nc -uc -us
