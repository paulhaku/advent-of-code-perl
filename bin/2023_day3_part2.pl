#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use autodie;
use FileHandler qw(get_file_lines);

my @lines = @{get_file_lines('2023_day3.txt')};

# We need to look ahead, so store every line in a list
my @grid = ();
foreach my $line (@lines) {
    chomp $line;
    push(@grid, $line);
}

sub is_special_character {
    my $char = shift;
    return $char =~ /^[^\.\d]$/;
}

sub is_numeric {
    my $char = shift;
    return $char =~ /^\d$/;
}

sub is_gear {
    my $char = shift;
    return $char eq '*';
}

my $gears = {};

for (my $i = 0; $i < @grid; $i++) {
    my $line = $grid[$i];
    for (my $j = 0; $j < length($line); $j++) {
        my $char = substr($line, $j, 1);

        next unless is_numeric($char);

        for my $di (-1 .. 1) {
            for my $dj (-1 .. 1) {
                next if $di == 0 && $dj == 0; # Skip current character
                my ($adjacent_i, $adjacent_j) = ($i + $di, $j + $dj);

                # Check if out of bounds
                next if $adjacent_i < 0 || $adjacent_i > $#grid;
                next if $adjacent_j < 0 || $adjacent_j >= length($line);

                my $adjacent_character = substr($grid[$adjacent_i], $adjacent_j, 1);

                # Skip if not a special character (anything that isn't a period or number)
                next unless is_special_character($adjacent_character);

                # Find the start of the number
                my $start_j = $j;
                $start_j-- while $start_j >= 0 && substr($line, $start_j, 1) =~ /^\d$/;
                $start_j++;

                # Extract the number
                my $number = '';
                while ($start_j < length($line) && substr($line, $start_j, 1) =~ /^\d$/) {
                    $number .= substr($line, $start_j, 1);
                    $start_j++;
                }

                # Skip ahead so we don't check this same number again
                $j = $start_j - 1;

                if (is_gear($adjacent_character)) {
                    push(@{$gears->{$adjacent_i . ',' . $adjacent_j}}, $number);
                }
            }
        }
    }
}

my $gear_ratio_sum = 0;
foreach my $gear (keys %$gears) {
    my $length = @{$gears->{$gear}};
    if ($length == 2) {
        $gear_ratio_sum += $gears->{$gear}->[0] * $gears->{$gear}->[1];
    }
}

print $gear_ratio_sum;