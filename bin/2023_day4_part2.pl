#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use File::Spec;
use autodie;
use FileHandler qw(get_file_lines);

my @lines = @{get_file_lines('2023_day4.txt')};

sub get_num_wins {
    my ($winning_numbers_ref, $numbers_ref) = @_;
    my @winning_numbers = @$winning_numbers_ref;
    my @numbers = @$numbers_ref;

    my $num_wins = 0;
    foreach my $number (@numbers) {
        next unless grep(/^$number$/, @winning_numbers);
        $num_wins++;
    }
    return $num_wins;
}

my $cards_by_id = {};

foreach my $line (@lines) {
    chomp $line;
    $line =~ /(\d+):\s+(.+?) \| (.+)/;
    my $id = $1;
    my @winning_numbers = split(/\s+/, $2);
    my @numbers = split(/\s+/, $3);
    $cards_by_id->{$id}->{"winning_numbers"} = \@winning_numbers;
    $cards_by_id->{$id}->{"numbers"} = \@numbers;
    $cards_by_id->{$id}->{"num_copies"} = 1;
}

my $total_scratchcards = 0;

foreach my $id (sort {$a <=> $b} keys %$cards_by_id) {
    my @winning_numbers = @{$cards_by_id->{$id}->{"winning_numbers"}};
    my @numbers = @{$cards_by_id->{$id}->{"numbers"}};
    my $num_wins = get_num_wins(\@winning_numbers, \@numbers);
    # Loop over every copy of the current card
    for (my $i = 0; $i < $cards_by_id->{$id}->{"num_copies"}; $i++) {
        # For every X wins this card has, make an extra copy of the next X cards
        for (my $j = 1; $j <= $num_wins; $j++) {
            my $copy_id = $id + $j;
            $cards_by_id->{$copy_id}->{"num_copies"} += 1;
        }
    }
    $total_scratchcards += $cards_by_id->{$id}->{"num_copies"};
}

print $total_scratchcards, "\n";