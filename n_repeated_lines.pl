#!/usr/bin/perl
i# simple but not so simple. Concise.
# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 25 April 2014
# Website: https://github.com/trizen

# Print only the lines that repeat n times in one or more files.
# usage: perl n_repeated_lines.pl [n] [file1.txt] [...]

use strict;
use warnings;

# quite a tricky one to understand this
# but n is the number of repeats to look out for, and it will be be 2 by default.
my $n = @ARGV && not(-f $ARGV[0]) ? shift() : 2;

my %seen;
while (<>) {
    /\S/ || next;
    ++$seen{unpack('A*')} == $n && print;
}
