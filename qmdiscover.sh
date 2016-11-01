#!/usr/bin/perl

use strict;

my $first = 1;

print "{\n";
print "\t\"data\":[\n\n";

my $vzresult = `sudo /usr/sbin/qm list | sed 1d`;
my @lines = split /\n/, $vzresult;

foreach my $l (@lines) {
        if ($l =~ /^(\s*?)(\d+) (.*?)(\s+)(\S+) (\s+)(\S+) (\s+)(\S+) (\d+)/)
        {
                my $id = $2;
                my $hostname = $3;
                my $status = $5;
                my $memory = $7;
                my $bdisk = $9;
                my $pid = $10;

                print ",\n" if not $first;
                $first = 0;

                print "\t{\n";
                print "\t\t\"{#QMID}\":\"$id\",\n";
                print "\t\t\"{#QMHOST}\":\"$hostname\",\n";
                print "\t\t\"{#QMSTATUS}\":\"$status\",\n";
#               print "\t\t\"{#QMMEM}\":\"$memory\",\n";
#               print "\t\t\"{#QMBDISK}\":\"$bdisk\",\n";
                print "\t\t\"{#QMPID}\":\"$pid\"\n";
                print "\t}";
        }
}

print "\n\t]\n";
print "}\n";
