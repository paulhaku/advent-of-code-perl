#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

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
        print "($num_red, $num_green, $num_blue)\n";
        if (($num_red > MAX_RED) || ($num_blue > MAX_BLUE) || ($num_green > MAX_GREEN)) {
            return 0;
        }
    }
    return 1;
}