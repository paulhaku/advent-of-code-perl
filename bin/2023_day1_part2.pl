#!/usr/bin/perl
use strict;
use warnings;
use autodie;
use FileHandler qw(get_file_lines);

my @lines = @{get_file_lines('2023_day1.txt')};

# Word representations
my %digit_values = (
    one => 1, two => 2, three => 3, four => 4, five => 5, six => 6, seven => 7, eight => 8, nine => 9
);
# Numerical representations
$digit_values{$_} = $_ for 1..9;

sub find_digits {
    my ($line, $digit_values) = @_;
    my ($first_digit, $last_digit);

    # Find first digit
    my $min_index = length($line);
    foreach my $digit (keys %$digit_values) {
        my $index = index($line, $digit);
        if ($index != -1 && $index < $min_index) {
            $min_index = $index;
            $first_digit = $digit_values->{$digit};
        }
    }

    # Find last digit
    my $max_index = -1;
    foreach my $digit (keys %$digit_values) {
        my $index = rindex($line, $digit);
        if ($index != -1 && $index > $max_index) {
            $max_index = $index;
            $last_digit = $digit_values->{$digit};
        }
    }

    $last_digit //= $first_digit;

    return ($first_digit, $last_digit);
}

my $sum = 0;
foreach my $line (@lines) {
    my ($first_digit, $last_digit) = find_digits($line, \%digit_values);
    $sum += "${first_digit}${last_digit}";
}

print $sum, "\n";