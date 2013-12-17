# Copyright (C) 2013 by M. Edward (Ed) Borasky
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http://www.gnu.org/licenses/agpl-3.0.txt) for more details.
#

# clean slate
ls(); rm(list = ls()); gc()

old.mc.cores <- options(mc.cores = 3) # set to 1 for debugging
gcinfo(FALSE) # set to TRUE to see impact of low RAM

# libraries needed
library(email.mining.for.journos)
library(tm)

# make and save the corpus
print(date())
rdevel.corpus <- make.email.corpus('/data/rdevel')
print(date())
print(summary(rdevel.corpus))
save(rdevel.corpus, file = '/data/rdevel-corpus.rda', compress = 'xz')

# now make and save Document-Term Matrix
print(date())
rdevel.dtm <- DocumentTermMatrix(
  clean.email.corpus(rdevel.corpus),
  control = list(
    tolower = FALSE, 
    wordLengths = c(3, Inf)
  )
)
print(date())
save(rdevel.dtm, file = '/data/rdevel-dtm.rda', compress = 'xz')

# Top 20 Authors
authors <- lapply(rdevel.corpus, Author)
authors <- sapply(authors, paste, collapse = " ")
print(sort(table(authors), decreasing = TRUE)[1:20])

# Top 20 Headings
headings <- lapply(rdevel.corpus, Heading)
headings <- sapply(headings, paste, collapse = " ")
print(sort(table(headings), decreasing = TRUE)[1:20])
