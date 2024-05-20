#!/usr/bin/env perl
# this script does what?
# from Gabor: https://perlmaven.com/regex-superpowers-execute-code-in-substitution
# can two args be used in a substitute expression?
use 5.010;
use strict;
use warnings;
# Argument accounting ... say how many the scrit should have.
if(scalar @ARGV != 2) {
    print "Sorry, this script requires exactly one argument\n";
    die;
}
my $str = "abc 24 def";
 
# $str =~ s/(\d)(\d)/$1 + $2/e;
# what happens here?
$str =~ s/$ARGV[0]/$ARGV[1]/e;
# ok run with: 
#  perl rarg0.pl '(\d)(\d)' '$1+$2'
# so actually the pure regex is fine - but what doesn't come off well is the $1 .. no surprise
 
say $str;  # abc 6 def
