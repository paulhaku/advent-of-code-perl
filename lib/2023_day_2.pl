#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use autodie;

my $filename = "input.txt";
open my $fh, "<", $filename;
my %digit_values = (1 => 1,
    2                 => 2,
    3                 => 3,
    4                 => 4,
    5                 => 5,
    6                 => 6,
    7                 => 7,
    8                 => 8,
    9                 => 9,
    "one"             => 1,
    "two"             => 2,
    "three"           => 3,
    "four"            => 4,
    "five"            => 5,
    "six"             => 6,
    "seven"           => 7,
    "eight"           => 8,
    "nine"            => 9);

my $sum = 0;
while (my $line = <$fh>) {
    chomp $line;
    my $first_digit;
    my $last_digit;

    my $min_index = length($line);
    foreach my $digit (keys %digit_values) {
        my $index = index($line, $digit);
        if ($index != -1 && $index < $min_index) {
            $min_index = $index;
            $first_digit = $digit;
        }
    }

    my $max_index = -1;
    foreach my $digit (keys %digit_values) {
        my $index = rindex($line, $digit);
        if ($index != -1 && $index > $max_index) {
            $max_index = $index;
            $last_digit = $digit;
        }
    }

    if (defined $last_digit) {
        $first_digit = $digit_values{$first_digit};
        $last_digit = $digit_values{$last_digit};
    } else {
        $first_digit = $digit_values{$first_digit};
        $last_digit = $digit_values{$first_digit};
    }

    print "$line ($first_digit, $last_digit)\n";
    $sum += "${first_digit}${last_digit}";
}

close $fh;
print $sum;