#!/usr/bin/perl

my $gwene_url = "gwene.org";

while(<>) {
    chomp;
    $feed_url = $_;
    my $content = `curl -d "url=$feed_url&confirm=Sign Up" $gwene_url 2> /dev/null`;
    $content =~ /group value="([^"]+)"/;
    my $group = $1;
    my $content2 = `curl -d "url=$feed_url&confirm=Sign Up&group=$group" $gwene_url 2>/dev/null`;
    if ($content2 =~ /already subscribed as ([^ ]+)/) {
	print "$1\n";
    } else {
	print "$group\n";
    }
}
