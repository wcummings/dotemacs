#!/usr/bin/perl
system("~/.emacs.d/scripts/slack-toilet.sh $_ $ARGV[1]") foreach split(//, $ARGV[0]);

