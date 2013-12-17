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

old.mc.cores <- options(mc.cores = 1) # set to 1 for debugging
gcinfo(FALSE) # set to TRUE to see impact of low RAM

# libraries needed
library(email.mining.for.journos)
library(tm)

# make and save the corpus
print(date())
enron.corpus <- make.email.corpus('/data/enron')
print(date())
print(summary(enron.corpus))
save(enron.corpus, file = '/data/enron-corpus.rda', compress = 'xz')

# now make and save Document-Term Matrix
print(date())
enron.dtm <- DocumentTermMatrix(
  clean.email.corpus(enron.corpus),
  control = list(
    tolower = FALSE, 
    wordLengths = c(3, Inf)
  )
)
print(date())
save(enron.dtm, file = '/data/enron-dtm.rda', compress = 'xz')

# Top 20 Authors
enron.authors <- lapply(enron.corpus, Author)
enron.authors <- sapply(enron.authors, paste, collapse = " ")
print(sort(table(enron.authors), decreasing = TRUE)[1:20])

# Top 20 Headings
enron.headings <- lapply(enron.corpus, Heading)
enron.headings <- sapply(enron.headings, paste, collapse = " ")
print(sort(table(enron.headings), decreasing = TRUE)[1:20])
