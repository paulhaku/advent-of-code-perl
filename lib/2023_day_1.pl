#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

my $f = "input.txt";
my $result = open my $fh, "<", $f;

if (!$result) {
    die "Couldn't open $f";
}

my $sum = 0;
while (!eof $fh) {
    my $line = readline $fh;
    # trim each line
    $line =~ s/^\s+|\s+$//g;
    # extract first and last digit
    my $first_digit;
    my $last_digit;

    if ($line =~ /(\d)/) {
        $first_digit = $1;
    }
    if ($line =~ /(\d)(?=\D*$)/) {
        $last_digit = $1;
    }

    if (defined $last_digit) {
        print "$line ($first_digit, $last_digit)\n";
        $sum += "${first_digit}${last_digit}";
    } else {
        print "$line ($first_digit)\n";
        $sum += "${first_digit}${first_digit}";
    }
}

print $sum;