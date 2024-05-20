#!/usr/bin/env perl
# this script does what?
use strict;
use warnings;
# Argument accounting ... say how many the scrit should have.
if(scalar @ARGV != 1) {
    print "Sorry, this script requires exactly one argument\n";
    die;
}
my $cmd = "ffmpeg -i $ARGV[0]";
# print $cmd;
my $o = `$cmd`;
print $o;
my 
