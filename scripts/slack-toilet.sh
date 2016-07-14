#!/bin/sh
figlet -f banner $1 | sed "s/ /\:whitespace\:/g" | sed "s/[\#]/\:${2}\:/g"
