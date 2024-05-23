#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use autodie;
use File::Spec;

my $file_dir = File::Spec->catdir('input');
my $file_name = File::Spec->catfile($file_dir, '2023_day3.txt');
open my $fh, '<', $file_name;

# We need to look ahead, so store every line in a list
my @grid = ();
while (my $line = <$fh>) {
    chomp $line;
    push(@grid, $line);
}
close $fh;

sub is_special_character {
    my $char = shift;
    return $char =~ /^[^\.\d]$/;
}

sub is_numeric {
    my $char = shift;
    return $char =~ /^\d$/;
}

my $sum = 0;
for (my $i = 0; $i < ($#grid + 1); $i++) {
    my $line = $grid[$i];
    for (my $j = 0; $j < length($line); $j++) {
        my $char = substr($line, $j, 1);
        # character is numeric
        if (is_numeric($char)) {
            # Is there a special character adjacent?
            for my $di (-1 .. 1) {
                for my $dj (-1 .. 1) {
                    next if $di == 0 && $dj == 0;
                    my ($adjacent_i, $adjacent_j) = ($i + $di, $j + $dj);
                    next if $adjacent_i < 0 || $adjacent_i > $#grid;
                    next if $adjacent_j < 0 || $adjacent_j > (length($line) - 1);
                    my $adjacent_character = substr($grid[$adjacent_i], $adjacent_j, 1);

                    # if it's not a period or a number, it is a special character
                    if (is_special_character($adjacent_character)) {
                        # go back in the current line until we find the start of the number
                        my $current_char = $char;
                        my $current_char_j = $j;
                        while ($current_char =~ /^\d$/) {
                            $current_char_j -= 1;
                            $current_char = substr($line, $current_char_j, 1);
                        }
                        # since current char is now not a number, go forward once to find the number again
                        $current_char_j += 1;
                        my $number = substr($line, $current_char_j, 1);
                        $current_char = $number;
                        while ($current_char =~ /^\d$/) {
                            $current_char_j += 1;
                            $current_char = substr($line, $current_char_j, 1);
                            if ($current_char =~ /^\d$/) {
                                $number = $number . $current_char;
                            }
                        }
                        $sum += $number;
                        # skip ahead so we don't check this same number again
                        $j = $current_char_j - 1;
                    }
                }
            }
        }
    }
}

print $sum;