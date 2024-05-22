#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use autodie;
use File::Spec;

my $file_dir = File::Spec->catdir('input');
my $filename = File::Spec->catfile($file_dir, '2023_day1.txt');
open my $fh, "<", $filename;

my $sum = 0;
while (my $line = <$fh>) {
    chomp $line;

    # extract first and last digit
    my ($first_digit) = $line =~ /(\d)/;
    my ($last_digit) = $line =~ /(\d)(?=\D*$)/;

    # use the first digit twice if there's only one digit
    $last_digit //= $first_digit;

    $sum += "${first_digit}${last_digit}";
}

close $fh;
print $sum;