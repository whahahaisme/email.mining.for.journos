#! /bin/bash
#
# Copyright (C) 2013 by M. Edward (Ed) Borasky
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http://www.gnu.org/licenses/agpl-3.0.txt) for more details.
#

# start monitors
iostat 1 > ${1}.iostat.log &
vmstat 1 > ${1}.vmstat.log &

# run the demo with performance capture
/usr/bin/time R --no-save < ../demo/make-${1}-corpus.R 2>&1 | tee ${1}.log

# kill monitors
pkill iostat
pkill vmstat
