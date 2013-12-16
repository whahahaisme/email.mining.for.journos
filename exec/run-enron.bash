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

# start iostat
iostat 10 > iostat.log &

# run the full Enron corpus and DTM with performance capture
/usr/bin/time R --no-save < ../demo/make-rdevel-corpus.R 2>&1 | tee capture.log

# kill iostat
pkill iostat
