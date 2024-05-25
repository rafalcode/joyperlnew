#!/usr/bin/env perl
# this script does what?
use strict;
use warnings;
# Argument accounting ... say how many the scrit should have.
if(scalar @ARGV != 1) {
    print "Sorry, this script requires exactly one argument\n";
    die;
}

# this comes from https://www.perl.com/article/21/2013/4/21/Read-an-entire-file-into-a-string/
# doesn't work:
# my $filename;
# my $file_content = do{local(@ARGV,$/)=$filename;<>};
open my $fh, '<', $ARGV[0] or die "Can't open file $!";

my $content = do { local $/; <$fh> };

$content =~ tr/\n/ /;

my @ss = ( $content =~ /<LatitudeDegrees>([^<]+)/g );

print join(" ", @ss);
print "\n";
