# Copyright (C) 2012 by M. Edward (Ed) Borasky
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http://www.gnu.org/licenses/agpl-3.0.txt) for more details.
#

# libraries needed
require(tm)
require(tm.plugin.mail)
require(SnowballC)

# unpack data
setwd('/home/Email')
system('gzip -dc r-devel/*2006*gz > 2006.txt')
convert_mbox_eml('2006.txt', '2006/')

# create the (volatile) corpus
rdevel <- Corpus(
  DirSource("2006/"),
  readerControl = list(
    reader = readMail,
    language = "en_US",
    load = TRUE
  )
)

# pre-processing
rdevel <- tm_map(rdevel, tm::asPlainTextDocument, mc.cores=1)
rdevel <- tm_map(rdevel, tm::stripWhitespace, mc.cores=1)
rdevel <- tm_map(rdevel, tmTolower, mc.cores=1)
summary(rdevel)
