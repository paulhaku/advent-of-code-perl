#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use File::Spec;

my $file_dir = File::Spec->catdir('input');
my $filename = File::Spec->catfile($file_dir, '2023_day2.txt');
open my $fh, "<", $filename;

use constant {
    MAX_RED   => 12,
    MAX_GREEN => 13,
    MAX_BLUE  => 14
};

sub is_possible {
    my $line = shift;
    # remove useless game indicator at start
    $line =~ /^Game \d+?: (.+)$/;
    my @sets = split('; ', $1);

    my $num_red;
    my $num_blue;
    my $num_green;
    foreach my $set (@sets) {
        ($num_red) = $set =~ /(\d+) red/;
        ($num_blue) = $set =~ /(\d+) blue/;
        ($num_green) = $set =~ /(\d+) green/;
        $num_red //= 0;
        $num_blue //= 0;
        $num_green //= 0;
        if (($num_red > MAX_RED) || ($num_blue > MAX_BLUE) || ($num_green > MAX_GREEN)) {
            return 0;
        }
    }
    return 1;
}

my $id_sum = 0;
while (my $line = <$fh>) {
    chomp $line;
    my ($game_id) = $line =~ /^Game (\d+?): .+$/;
    if (is_possible($line)) {
        $id_sum += $game_id;
    }
}

print $id_sum, "\n";
close $fh;