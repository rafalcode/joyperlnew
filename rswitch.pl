#!/usr/bin/env perl
# this script does what?
# from Brian Foy's tips
# the rswitch on the s// substit expression
# actually it also brings to light the binding
use strict;
use warnings;
# Argument accounting ... say how many the scrit should have.
# if(scalar @ARGV != 1) {
#     print "Sorry, this script requires exactly one argument\n";
#     die;
# }


# my $old = "aabadaspisalwaysasgoodasno assatall"
my $old = "asbadasbadasyou say";
# my $new = $old =~ "s/bad/good/r";
# uh? hell! forget through quotations around the substitution!
my $new = $old =~ s/bad/good/gr;
print "$new\nfrom\n$old\n";

# so s//r is usefull when you want to send a modified version of the string to a function
# but note the underlying string variable is not affected as it would be without the "r"
# # sop the overall effect is making the =~ less strict, and not overwriting "itself".
