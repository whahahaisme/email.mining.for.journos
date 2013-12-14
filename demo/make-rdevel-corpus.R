# Copyright (C) 2013 by M. Edward (Ed) Borasky
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http://www.gnu.org/licenses/agpl-3.0.txt) for more details.
#

old.mc.cores <- options(mc.cores = 8) # set to 1 for debugging

# libraries needed
require(email.mining)
require(tm)

system('rm -f rdevel.db')

print(date())
rdevel.corpus <- make.email.corpus(
  '/home/Email/2006',
  Permanent=FALSE,
  dbName='rdevel.db'
)
print(date())

print(summary(rdevel.corpus))
save(rdevel.corpus, file='/home/Email/rdevel-corpus.rda', compress='xz')

# now make and save Term-Document Matrix
rdevel.tdm <- TermDocumentMatrix(rdevel.corpus)
save(rdevel.tdm, file='/home/Email/rdevel-tdm.rda', compress='xz')

# Authors
authors <- lapply(rdevel.corpus, Author)
authors <- sapply(authors, paste, collapse = " ")
print(sort(table(authors), decreasing = TRUE)[1:20])

# Topics / Headings
headings <- lapply(rdevel.corpus, Heading)
headings <- sapply(headings, paste, collapse = " ")

# The sorted contingency table shows the biggest topics' names and the amount of postings
print(bigTopicsTable <- sort(table(headings), decreasing = TRUE)[1:20])
bigTopics <- names(bigTopicsTable)

# First topic
topicCol <- rdevel.corpus[headings == bigTopics[1]]
print(unique(sapply(topicCol, Author)))

# Second topic
topicCol <- rdevel.corpus[headings == bigTopics[2]]
print(unique(sapply(topicCol, Author)))

# How many postings deal with bugs?
print(
  bugCol <- tm_filter(
    rdevel.corpus,
    FUN = searchFullText,
    "[^[:alpha:]]+bug[^[:alpha:]]+",
    doclevel = TRUE
  )
)

# Most active authors about bugs
bugColAuthors <- lapply(bugCol, Author)
bugColAuthors <- sapply(bugColAuthors, paste, collapse = " ")
print(sort(table(bugColAuthors), decreasing = TRUE)[1:5])

# find frequent terms
f <- findFreqTerms(rdevel.tdm, 30, 31)
print(sort(f[-grep("[0-9]", f)]))
