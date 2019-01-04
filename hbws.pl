#!/usr/bin/perl
#
# hdws.pl - Splitter for Hatena Blog Writer.
#
# This program is forked from hws.pl (Splitter for Hatena Diary Writer, http://www.hyuki.com/techinfo/hatena_diary_writer.html).
#
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
use strict;
use Digest::MD5 qw(md5_hex);

my $VERSION = "0.1.0";

my %diary;
my $diary_file = "diary.txt";
my $backup_file = "backup_diary.txt";
my $md5_file = "md5.txt";

# Scan diary.
{
    # Read.
    open(FILE, $diary_file) or die "$!: $diary_file\n";
    my $file = join('', <FILE>);
    close(FILE);

    # Replace.
    my $newfile = $file;
    $newfile =~ s/^\*t\*/"*" . time() . "*"/gem;

    # Write if replaced.
    if ($newfile ne $file) {
        # Backup.
        open(FILE, "> $backup_file") or die "$!: $backup_file\n";
        print FILE $file;
        close(FILE);
        # Save.
        open(FILE, "> $diary_file") or die "$!: $diary_file\n";
        print FILE $newfile;
        close(FILE);
    }

    # Process it.
    my ($date, $title) = ('', '');
    for (split(/\n/, $newfile)) {
        if (/^(\d\d\d\d-\d\d-\d\d_\d\d):(.*)/) {
            ($date, $title) = ($1, $2);
            if ($diary{$date}) {
                die "ERROR: Duplicate $date. ($title)\n";
            }
            $diary{$date}->{content} = "title: $title\n";
        } elsif ($date) {
            $diary{$date}->{content} .= "$_\n";
        } else {
            print "Before dateline: ", "$_\n";
        }
    }
}

# Compute MD5.
foreach (keys %diary) {
    $diary{$_}->{md5} = md5_hex($diary{$_}->{content});
    $diary{$_}->{update} = 1;
}

# Compare diary.
if (open(FILE, $md5_file)) {
    while (<FILE>) {
        chomp;
        my ($date, $md5) = split(/:/, $_);
        if ($diary{$date}->{md5} eq $md5) {
            $diary{$date}->{update} = 0;
        }
    }
    close(FILE);
}

# Save diary files.
for (sort keys %diary) {
    if ($diary{$_}->{update}) {
        print "Create $_.txt\n";
        open(FILE, "> $_.txt") or die "$!: $_.txt\n";
        print FILE $diary{$_}->{content};
        close(FILE);
    }
}

# Update md5 file.
open(FILE, "> $md5_file") or die "$!: $md5_file\n";
for (sort keys %diary) {
    print FILE $_, ":", $diary{$_}->{md5}, "\n";
}
close(FILE);
