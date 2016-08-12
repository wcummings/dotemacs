#!/usr/bin/perl
my $word = shift;
my $emoji = shift;

my @a = split //, $word;

foreach my $c (@a) {
    system("~/.emacs.d/scripts/slack-toilet.sh $c $emoji");
}
