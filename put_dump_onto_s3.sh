#!/bin/sh
#
# File: put_dump_onto_s3.sh
#
# Author: Francesco Prelz (Francesco.Prelz@mi.infn.it)
#
# Revision history:
# 12-Feb-2019 Initial version.
#
# Description:
# Stage one or more files out to S3 using the 's3' (s3lib) command.
# The needed access credentials for s3lib must be present in the
# process environment (S3_ACCESS_KEY_ID, S3_SECRET_ACCESS_KEY
# and, if needed, S3_HOSTNAME).
# The access bucket can be set either in the environment (S3_BUCKET)
# or on the command line.
#
# TODO: currently key and file names are the same.
#

fst_s3_bucket="$S3_BUCKET"

usage_string="Usage: $0 [-b S3 bucket] outfile1 [,outfile2,...]"

while getopts "b:" arg
do
  case "$arg" in
    b) fst_s3_bucket="$OPTARG" ;;
    -) break ;;
    ?) >&2 echo $usage_string
       exit 1 ;;
  esac
done

shift `expr $OPTIND - 1`
if [ $# -lt 1 ]; then
  >&2 echo $usage_string
  exit 1
fi

if [ "x$fst_s3_bucket" = "x" ]; then
  >&2 echo "$0: Missing bucket name for S3 I/O"
  exit 2
fi

# Locate the S3 executable
my_s3=`which s3 2> /dev/null`

if [ "x$my_s3" = "x" -o ! -x "$my_s3" ]; then
  PATH=/bin:/usr/bin:$PATH
  export PATH
  my_s3=`which s3 2> /dev/null`
fi

if [ "x$my_s3" = "x" -o ! -x "$my_s3" ]; then
  my_s3=`pwd`/s3
  if [ -e "$my_s3" ]; then
    chmod +x "$my_s3"
  fi
fi

if [ ! -x "$my_s3" ]; then
  >&2 echo "$0: Cannot find a working copy of the 's3' executable. Exiting"
  exit 3
fi

exitcode=0

for out_file in "$@"; do
  out_key=`basename $out_file`
  $my_s3 put "$fst_s3_bucket/$out_key" filename="$out_file"  > /dev/null
  if [ $? -ne 0 ]; then
    >&2 echo "$0: unable to s3 put $out_file -> $fst_bucket/$out_key."
    exitcode=`expr $exitcode + 5` 
  fi
done

exit $exitcode
