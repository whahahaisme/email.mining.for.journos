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
inboxes.corpus <- make.email.corpus('/data/inboxes')
print(date())
print(summary(inboxes.corpus))
save(inboxes.corpus, file = '/data/inboxes-corpus.rda', compress = 'xz')

# now make and save Document-Term Matrix
print(date())
inboxes.dtm <- DocumentTermMatrix(
  clean.email.corpus(inboxes.corpus),
  control = list(
    tolower = FALSE, 
    wordLengths = c(3, Inf)
  )
)
print(date())
save(inboxes.dtm, file = '/data/inboxes-dtm.rda', compress = 'xz')

# Top 20 Authors
inboxes.authors <- lapply(inboxes.corpus, Author)
inboxes.authors <- sapply(inboxes.authors, paste, collapse = " ")
print(sort(table(inboxes.authors), decreasing = TRUE)[1:20])

# Top 20 Headings
inboxes.headings <- lapply(inboxes.corpus, Heading)
inboxes.headings <- sapply(inboxes.headings, paste, collapse = " ")
print(sort(table(inboxes.headings), decreasing = TRUE)[1:20])
