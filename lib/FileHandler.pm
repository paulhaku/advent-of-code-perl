package FileHandler;
use strict;
use warnings FATAL => 'all';
use File::Spec;
use Exporter 'import';
our @EXPORT_OK = qw(get_file_lines);

sub get_file_lines {
    my $input_file_name = shift;
    my $file_dir = File::Spec->catdir('input');
    my $file_name = File::Spec->catfile($file_dir, $input_file_name);
    open my $fh, '<', $file_name;
    my @lines = ();
    while (my $line = <$fh>) {
        chomp $line;
        push(@lines, $line);
    }
    close $fh;
    return \@lines;
}

1;