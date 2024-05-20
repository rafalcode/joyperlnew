
I got thisone liner off chatgpt and it worked:
perl -ne 'print "$. " if /^\(\d+%\)$/' cpubenchtable.txt

to turn this into a script notice that it actually isn't a problem passing a regex pattern as a string to a perl script
, the single quotes are vitral of course to escape the bash interpreter which of course it has to get through firsto
funnily enough the dolar dot gets through too.

# lnoc.pl
Beware, it's quite hardcoded for cpubenchmarks datafile
Stands for line number occurences. WHat it is though, is a way to recovered a table from a copy-pasted webpage. So why is it
necessary? Because when you copy paste a table, it converts the <td> to newlines.
You have to find a regex that one of the fields obeys and then use that to group lines to a row 
see the cpubenchmarks. It has four columns but these are lost in the copy-paste, so the (\d+%) regex captures
the second field and the lnco.pl scripts tries to work all this out.
It's still a bit rough, but most of the owkr is done in it. cpubs.txt is a cleaned version of it's rendering of this benchmarks file
