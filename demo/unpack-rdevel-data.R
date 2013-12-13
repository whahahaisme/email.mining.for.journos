# Copyright (C) 2013 by M. Edward (Ed) Borasky
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http://www.gnu.org/licenses/agpl-3.0.txt) for more details.
#

# libraries needed
require(tm.plugin.mail)

# unpack data
setwd('/home/Email')
system('gzip -dc r-devel/*2006*gz > 2006.txt')
system('rm -fr 2006/')
convert_mbox_eml('2006.txt', '2006/')
