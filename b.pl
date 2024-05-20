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
# print $content;
# silence_start: 1.71133
# silence_start: [\.0-9]+
# my @ss = ( $content =~ /silence_start: ([\.0-9]+)/g );
# (my $dur = $content) =~ /Duration: ([:\.0-9]+)/; # the ($dur) is the list context required.
my ($dur) = $content =~ m/Duration: ([:\.0-9]+)/; # the ($dur) is the list context required.

# my $dur = $1 if ($content =~ /Duration: ([:\.0-9]+)/); # the ($dur) is the list context required.
# Coz you only want the first duration, then the +? nongreedy will catch all these pairs
my @ss = ( $content =~ /silence_start: ([\.0-9]+).+?silence_end: ([\.0-9]+)/g );

print "$dur\n";
print join(" ", @ss);
print "\n";
