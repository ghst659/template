#!/usr/bin/env python3
import sys                      # access to basic things like sys.argv
import os                       # access pathname utilities
import argparse                 # for command-line options parsing
##############################################################################
# insert additional module functions here; if this file is imported using
# "import template" then these functions are callable as template.f()

##############################################################################
# main proc, if this file is executed as a standalone programme (not sourced)
def main(argv):
    "Template Python programme"
    exit_code = 0
    global me; me = os.path.basename(argv[0]) # name of this program
    ################################
    parser = argparse.ArgumentParser(description=main.__doc__)
    parser.add_argument("-m","--multi_opt", metavar='OPT_VAL',
                        dest='m_opt_lst', action='append',
                        help="multiple-valued option")
    parser.add_argument("-s","--single_opt", metavar='OPT_VAL',
                        dest='s_opt_val', default="default_value",
                        help="single-valued option")
    parser.add_argument("-v","--verbose",
                        dest='verbose', action="store_true",
                        help="run verbosely")
    parser.add_argument("targets",
                        metavar="TARGET_FILE", nargs="*",
                        help="target files to process, nargs=* means 0 or more")
    args = parser.parse_args(args=argv[1:])  # will exit on parse error
    ################################################################
    if args.verbose:
        print("{0}: verbose is on".format(me), file=sys.stderr)
    print("{0}: single option value: {1}".format(me, args.s_opt_val))
    if args.m_opt_lst is not None:
        for p in args.m_opt_lst:
            print("{0}: multi param: {1}".format(me,p), file=sys.stderr)
    i = 0
    for arg in args.targets:
        print("{0}: arg {1} = {2}".format(me,i,arg))
        i += 1
    ################################################################
    return exit_code

##############################################################################
# The following code calls main only if this program is invoked standalone
if __name__ == "__main__":
    sys.exit(main(sys.argv))
##############################################################################
# Text Editor Settings to help retain formatting; last line is for vi/vim
# Local Variables:
# mode: python
# python-indent: 4
# End:
# vim: set expandtab:
