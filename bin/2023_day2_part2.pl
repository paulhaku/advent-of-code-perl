#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use File::Spec;
use FileHandler qw(get_file_lines);

my @lines = @{get_file_lines('2023_day2.txt')};

sub get_power {
    my $line = shift;
    # remove useless game indicator at start
    $line =~ /^Game \d+?: (.+)$/;
    my @sets = split('; ', $1);

    my ($max_red, $max_blue, $max_green) = (0, 0, 0);

    foreach my $set (@sets) {
        my ($num_red) = $set =~ /(\d+) red/;
        my ($num_blue) = $set =~ /(\d+) blue/;
        my ($num_green) = $set =~ /(\d+) green/;
        $num_red //= 0;
        $num_blue //= 0;
        $num_green //= 0;

        $max_red = $num_red if $num_red > $max_red;
        $max_blue = $num_blue if $num_blue > $max_blue;
        $max_green = $num_green if $num_green > $max_green;
    }
    return $max_red * $max_blue * $max_green;
}

my $power_sum = 0;
foreach my $line (@lines) {
    $power_sum += get_power($line);
}

print $power_sum, "\n";