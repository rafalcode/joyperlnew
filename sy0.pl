#!/usr/bin/env perl
# this script does what? Using system calls in perl
# doc for this is https://stackoverflow.com/questions/3200801/how-can-i-call-a-shell-command-in-my-perl-script
use strict;
use warnings;

my $cmd = "ls -atlr";
# my $output = qx/script.sh --option/;
# my $output = qx/$cmd/; # that "q" puts everything in between slashes in backtick;
# # so, the following is the same:
my $output = `$cmd`; # that "q" puts everything in between slashes in backtick;
print $output;

# note: actually system($cmd) will also work!
