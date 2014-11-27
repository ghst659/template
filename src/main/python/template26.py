#!/usr/bin/env python2.6
from __future__ import print_function
import sys                      # access to basic things like sys.argv
import os                       # access pathname utilities
import optparse                 # for command-line options parsing
##############################################################################

##############################################################################
# main proc, if this file is executed as a standalone programme (not imported)
def main(argv):
    "Template Python 2.6 programme"
    exit_code = 0
    global me; me = os.path.basename(argv[0]) # name of this program
    ################################
    parser = optparse.OptionParser()
    parser.add_option("-m","--multi_opt", metavar='OPT_VAL',
                      dest='m_opt_lst', action='append',
                      help="multiple-valued option")
    parser.add_option("-s","--single_opt", metavar='OPT_VAL',
                      dest='s_opt_val', default="default_value",
                      help="single-valued option")
    parser.add_option("-v","--verbose",
                      dest='verbose', action="store_true",
                      help="run verbosely")
    opts, args = parser.parse_args(argv[1:])  # will exit on parse error
    ################################################################
    if opts.verbose:
        print("{0}: verbose is on".format(me), file=sys.stderr)
    print("{0}: single option value: {1}".format(me, opts.s_opt_val))
    if opts.m_opt_lst is not None:
        for p in opts.m_opt_lst:
            print("{0}: multi param: {1}".format(me,p), file=sys.stderr)
    i = 0
    for arg in args:
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
