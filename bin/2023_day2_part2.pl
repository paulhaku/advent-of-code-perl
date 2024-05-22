#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use File::Spec;

my $file_dir = File::Spec->catdir('input');
my $filename = File::Spec->catfile($file_dir, '2023_day2.txt');
open my $fh, "<", $filename;

sub get_power {
    my $line = shift;
    # remove useless game indicator at start
    $line =~ /^Game \d+?: (.+)$/;
    my @sets = split('; ', $1);

    my $max_red = 0;
    my $max_blue = 0;
    my $max_green = 0;
    foreach my $set (@sets) {
        my ($num_red) = $set =~ /(\d+) red/;
        my ($num_blue) = $set =~ /(\d+) blue/;
        my ($num_green) = $set =~ /(\d+) green/;
        $num_red //= 0;
        $num_blue //= 0;
        $num_green //= 0;
        if ($num_red > $max_red) {
            $max_red = $num_red;
        }
        if ($num_blue > $max_blue) {
            $max_blue = $num_blue;
        }
        if ($num_green > $max_green) {
            $max_green = $num_green;
        }
    }
    return $max_red * $max_blue * $max_green;
}

my $power_sum = 0;
while (my $line = <$fh>) {
    chomp $line;
    $power_sum += get_power($line);
}

print $power_sum, "\n";
close $fh;