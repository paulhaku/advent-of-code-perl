#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use File::Spec;
use autodie;
use FileHandler qw(get_file_lines);

my @lines = @{get_file_lines('2023_day4.txt')};

my $total_points = 0;
foreach my $line (@lines) {
    my $points = 0;
    $line =~ /\d+:\s+(.+?) \| (.+)/;
    my @winning_numbers = split(/\s+/, $1);
    my @numbers = split(/\s+/, $2);
    foreach my $number (@numbers) {
        next unless grep(/^$number$/, @winning_numbers);
        $points = $points == 0 ? 1 : $points * 2;
    }
    $total_points += $points;
}

print $total_points, "\n";