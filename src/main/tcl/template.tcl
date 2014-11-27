#!/usr/intel/pkgs/tcl-tk/8.5.8-64/bin/tclsh
package require cmdline;        # for command-line options parsing
##############################################################################
set this_package_name "template"; # needs to match name of this file
package provide $this_package_name 0.1
namespace eval $this_package_name {
    ################################################################
    # insert additional package procs here
    
    ################################################################
    # main proc, if this file is executed standalone (not sourced)
    # It is better to use a main proc to limit the use of global variables
    proc main {argv} {
        set exit_code 0
        global me;              # value is set below
        ################################
        set optspec {
            {p.arg  "none" "parameter for processing"}
            {v	"run verbosely"}
        }
        set usage "OPTIONS ARGS"; # usage messsage
        set parcode [catch {::cmdline::getoptions argv $optspec $usage} pardat]
        if {$parcode != 0} {
            # parse error, including -help
            puts stderr "$pardat"
            set exit_code $parcode
        } else {
            array set opts $pardat
            ################################
            set script_info [info script]
            puts "$me: info script = $script_info"
            if {$opts(v)} {
                puts stderr "verbose"
            }
            puts "parameter = $opts(p)"
            set i 0
            foreach arg $argv {
                puts "$me: arg $i = $arg"
                incr i
            }
            ################################
        }
        return $exit_code
    }
}
##############################################################################
# The following code calls main only if this program is invoked standalone
if {[info exists argv0] && [file tail [info script]] eq [file tail $argv0]} {
    # this programme was invoked standalone
    global me;  set me [file tail [info script]]; # name of this program
    exit [${this_package_name}::main $argv]
}
##############################################################################
# Text Editor Settings to help retain formatting
# Local Variables:
# mode: tcl
# tcl-indent-level: 4
# End:
# vim: set expandtab:
