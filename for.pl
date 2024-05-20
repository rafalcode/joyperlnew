#!/usr/bin/perl
use warnings;
use strict;

my @a = (10..15);
for(my $i=0; $i<@a; $i++) {
	print("$a[$i]","\n");
}
