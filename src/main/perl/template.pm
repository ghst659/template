#!/usr/bin/perl -w
package template;
##############################################################################
use Getopt::Long;               # for command-line options parsing
use Cwd qw(abs_path);           # get the absolute path
use File::Basename;             # get the trailing element of a path
use strict;
##############################################################################
our $me;                        # visible everywhere within this package file
##############################################################################
# package function export
BEGIN {
    use Exporter;
    our @ISA = qw(Exporter);
    our @EXPORT_OK = qw(&runner); # export procedure
}
sub runner
{
    my @jobvec = @_;
    unshift(@jobvec, "./slave");
    unshift(@jobvec, '('); push(@jobvec, ')'); # wrap compound cmds as one
    push(@jobvec, '2>&1');	# also capture stderr
    my $jobstr = join(' ', @jobvec);
    my $jobout = qx/$jobstr/; my $exitcode = $? >> 8;
    chomp($jobout);
    return ($jobout, $exitcode);
}
##############################################################################
# class methods
sub new
{
    my $class = shift(@_);
    my $self = {};
    $self->{'cmdline'} = [];
    foreach my $a (@_) {
	push(@{$self->{'cmdline'}}, $a);
    }
    bless($self, $class);
    return $self;
}

sub go
{
    my $self = shift(@_);
    return runner(@{$self->{'cmdline'}});
}
##############################################################################
# main proc, if this file is executed as a standalone programme (not sourced)
# It is better to use a main proc to limit the use of global variables
sub main
{
    local(@ARGV) = @_;          # must be local(), not my(), for GetOptions()
    my $exit_code = 0;
    ################################
    my %opts = (
        param => [],
        error_sim => 0,
        verbose => 0,
        help => 0
        );
    my $result = GetOptions(
        "error_sim" => \$opts{error_sim},
        "verbose" => \$opts{verbose},
        "help" => \$opts{help}
    );                          # returns false on error
    if ($opts{help} || ! $result) {
        print(STDERR "$me: usage: $me OPTIONS ARGS\n");
    } else {
	if ($opts{error_sim}) {
	    unshift(@ARGV,"-e");
	}
	my ($runresult, $runstat) = runner(@ARGV);
	if ($runstat == 0) {
	    print($runresult,"\n");
	} else {
	    print("$me: error: $runresult\n");
	}
    }
    ################################
    return $exit_code;
}
##############################################################################
# The following code calls main only if this program is invoked standalone
if (! caller()) {
    $me = basename(abs_path($0));
    exit(main(@ARGV));
} else {
    1;
}
##############################################################################
# Text Editor Settings to help retain formatting
# Local Variables:
# mode: perl
# perl-indent-level: 4
# End:
# vim: set expandtab:
