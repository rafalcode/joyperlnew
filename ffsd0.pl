#!/usr/bin/env perl
# this script does what?
use strict;
use warnings;
# Argument accounting ... say how many the scrit should have.
if(scalar @ARGV != 3) {
    print "Sorry, this script requires exactly one argument\n";
    print "Arg 1 is sound file, arg 2 is dB threshold (-40 is good) arg3 is min. silence duration\n";
    die;
}

my $AF=$ARGV[0];
my $DB="$ARGV[1]dB";
my $DU=$ARGV[2];

# below parens: don't doubt it, they are nec.
my ($ext) = $AF =~ m/\.(.+)/;
print("$ext\n");

# ffmpeg -hide_banner -vn -i $AF -af "silencedetect=n=${DB}dB:d=${DU}" -f null - 2>&1 \
my $cmd = "ffmpeg -hide_banner -vn -i $AF -af \"silencedetect=n=$DB:d=$DU\" -f null - 2>&1";
print $cmd;
my $o = `$cmd`;
$o =~ tr/\n/ /;
my ($dur) = $o =~ m/Duration: ([:\.0-9]+)/; # the ($dur) is the list context required.
my @ss = ( $o =~ /silence_start: ([\.0-9]+).+?silence_end: ([\.0-9]+)/g );
print "\nDuration: $dur\n";

my @dd = ( $dur =~ /(\d+):(\d+):([\.0-9]+)/g );
print join(" ", @dd);
print "\n";
my $dd2 = $dd[0]*3600 + $dd[1]*60 +$dd[2];
print $dd2;

print "\nRuns of silence as follows:\n";
for(my $i=0; $i<@ss; $i+=2) {
	print("$ss[$i] $ss[$i+1]\n");
}
print "\nRuns of sound as follows:\n";
if($ss[0]<0.1 && $ss[@ss-1]<$dd2) {
    for(my $i=1; $i<@ss-1; $i+=2) {
        print("$ss[$i] $ss[$i+1]\n");
    }
}
print("$ss[@ss-1] $dd2\n");

# some convenience definitions:
my $PAD=0.33;
my ($t0, $t2, $ffcmd, $dura, $jj, $strjj);

print "\nRuns of sound with outer padding as follows:\n";
if($ss[0]<0.1 && $ss[@ss-1]<$dd2) {
    for(my $i=1; $i<@ss-1; $i+=2) {
        $t0 = $ss[$i]-$PAD;
        $t2 = $ss[$i+1]+$PAD;
        # print("$ss[$i]-$PAD $ss[$i+1]+$PAD\n");
        print("$t0 $t2\n");
    }
}
$t0 = $ss[@ss-1]-$PAD;
print("$t0 $dd2\n");

print "\nffmpeg lossless cut commandsRuns of sound with outer padding as follows:\n";

$jj=1;
if($ss[0]<0.1 && $ss[@ss-1]<$dd2) {
    for(my $i=1; $i<@ss-1; $i+=2) {
        $t0 = $ss[$i]-$PAD;
        $t2 = $ss[$i+1]+$PAD;
        # print("$ss[$i]-$PAD $ss[$i+1]+$PAD\n");
        $dura = $t2-$t0;
        $strjj= "chunk$jj.$ext";
        $ffcmd = "ffmpeg -y -i $AF -vn -c:a copy -ss $t0 -t $dura $strjj";
        print("$ffcmd\n");
        $jj++;
    }
}
#Final chunk:
$t0 = $ss[@ss-1]-$PAD;
# $dura = $t2-$t0;
$strjj= "chunk$jj.$ext";
$ffcmd = "ffmpeg -y -i $AF -vn -c:a copy -ss $t0 $strjj";
print("$ffcmd\n");
print("No audi file chunking has occurred, please use ffsd.pl for that (i.e. filenames without \"0\").\n");
