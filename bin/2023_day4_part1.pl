#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use File::Spec;
use autodie;

my $file_dir = File::Spec->catdir('input');
my $file_name = File::Spec->catfile($file_dir, '2023_day4.txt');
open my $fh, '<', $file_name;

my $total_points = 0;
while (my $line = <$fh>) {
    chomp $line;
    my $points = 0;
    $line =~ /\d+:\s+(.+?) \| (.+)/;
    my @winning_numbers = split(/\s+/, $1);
    my @numbers = split(/\s+/, $2);
    foreach my $number (@numbers) {

        next unless grep(/^$number$/, @winning_numbers);
        if ($points == 0) {
            $points = 1;
        }
        else {
            $points *= 2;
        }
    }
    $total_points += $points;
}
close $fh;
print $total_points, "\n";