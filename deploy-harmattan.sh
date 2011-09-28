#!/bin/bash
DEBNAME=qmljewel_0.0.1_armel.deb
scp ../$DEBNAME n950: && \
ssh n950 dpkg -i $DEBNAME
