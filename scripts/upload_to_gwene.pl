#!/usr/bin/perl

my $gwene_url = "gwene.org";

while(<>) {
    chomp;
    $feed_url = $_;
    my $p1_content = `curl -d "url=$feed_url&confirm=Sign Up" $gwene_url 2> /dev/null`;
    $p1_content =~ /group value="([^"]+)"/;
    my $group = $1;
    my $p2_content = `curl -d "url=$feed_url&confirm=Sign Up&group=$group" $gwene_url 2>/dev/null`;
    if ($p2_content =~ /already subscribed as ([^ ]+)/) {
	print "$1\n";
    } else {
	print "$group\n";
    }
}
