#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use autodie;
use FileHandler qw(get_file_lines);

my @lines = @{get_file_lines('2023_day1.txt')};

my $sum = 0;
foreach my $line (@lines) {
    # extract first and last digit
    my ($first_digit) = $line =~ /(\d)/;
    my ($last_digit) = $line =~ /(\d)(?=\D*$)/;

    # use the first digit twice if there's only one digit
    $last_digit //= $first_digit;

    $sum += "${first_digit}${last_digit}";
}

print $sum;