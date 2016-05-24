#!/bin/bash

URL=$1
FILE=$(mktemp)

wget -O $FILE $URL
awk -f ~/.emacs.d/scripts/ical2org.awk < $FILE > ~/org/gcal_agenda.org
rm $FILE

