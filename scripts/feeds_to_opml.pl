#!/usr/bin/perl
use XML::OPML;

my $opml = new XML::OPML(version => "1.1");

$opml->head(title => 'Subscriptions');

while(<>) {
    chomp;
    $opml->add_outline(type => 'rss', xmlUrl => $_, text => "Feeds");
}

$opml->save('feeds.opml');
