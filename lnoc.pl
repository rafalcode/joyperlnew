#!/usr/bin/env perl
use strict;
use warnings;

# this script does what? lines where a regex (arg) occurs
# actuall the script equivalent of
# perl -ne 'print "$. " if /^\(\d+%\)$/' cpubenchtable.txt
# IT's surprising how difficult a script is compared to a one liner.
# Argument accounting ... say how many the scrit should have.
if(scalar @ARGV != 2) {
    print "Sorry, this script requires 2 args: regex in single quotes 2. file to be searched\n";
    die;
}

open my $fh, '<', $ARGV[1] or die "Can't open file $!";
# my $finside = do { local $/; <$fh> };

my $ln=0;
my @malns;  # matched lines.
my @alllines;
while(my $line = <$fh>) {
    $ln++;
    if($line =~ /$ARGV[0]/) {
        push(@malns, $ln);
    }
    chomp($line); # note overwrites itseln
    push(@alllines, $line);
}

my @diffs;
my $runlensame=0; # run length is the same
my $d1 = $malns[1] - $malns[0];
my $line2start=$malns[0];
for(my $i=2; $i<@malns; $i++) {
    if($d1 != $malns[$i] - $malns[$i-1]) {
        $d1 = $malns[$i] - $malns[$i-1];
        $line2start = $malns[$i-1];
    } else {
        $runlensame++;
    }
}
printf("occurence happens every %i and %i times\n", $d1, $runlensame);
print "$line2start\n";
for(my $i=$line2start; $i<@alllines; $i+=$d1) {
    printf("%s\t%s\t%s\t%s\n", $alllines[$i-2], $alllines[$i-1], $alllines[$i], $alllines[$i+1]);
}

# print array
# print join(" ", @malns);
# print "\n";
