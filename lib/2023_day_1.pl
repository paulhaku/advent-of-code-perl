#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use autodie;

my $filename = "input.txt";
open my $fh, "<", $filename;

my $sum = 0;
while (my $line = <$fh>) {
    chomp $line;

    # extract first and last digit
    my ($first_digit) = $line =~ /(\d)/;
    my ($last_digit) = $line =~ /(\d)(?=\D*$)/;

    # use the first digit twice if there's only one digit
    $last_digit //= $first_digit;

    $sum += "${first_digit}${last_digit}";
}

print $sum;