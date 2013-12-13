# Copyright (C) 2013 by M. Edward (Ed) Borasky
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

# unpack data
setwd('/home/Email')
system('gzip -dc r-devel/*2006*gz > 2006.txt')
convert_mbox_eml('2006.txt', '2006/')

print(date())
Rprof(
  memory.profiling = TRUE,
  gc.profiling = TRUE, 
  line.profiling = TRUE,
  numfiles = 10000L,
  bufsize = 10000L
)

# change to TRUE for Permanent corpus
Permanent <- FALSE

if (Permanent) {
  rdevel.corpus <- PCorpus(
    DirSource("2006/"),
    readerControl = list(
      reader = readMail,
      language = "en_US",
      load = TRUE
    ),
    dbControl = list(
      dbName = 'rdevel.db'
    )
  )
} else {
  rdevel.corpus <- VCorpus(
    DirSource("2006/"),
    readerControl = list(
      reader = readMail,
      language = "en_US",
      load = TRUE
    )
  )
}
Rprof(NULL)
print(date())
summaryRprof(
  memory = "both",
  lines = "both"
)

# pre-processing
rdevel.corpus <- tm_map(rdevel.corpus, as.PlainTextDocument, mc.cores=4)
rdevel.corpus <- tm_map(rdevel.corpus, stripWhitespace, mc.cores=4)
rdevel.corpus <- tm_map(rdevel.corpus, tolower, mc.cores=4)
summary(rdevel.corpus)
