# Copyright (C) 2013 by M. Edward (Ed) Borasky
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http://www.gnu.org/licenses/agpl-3.0.txt) for more details.
#

# libraries needed
require(email.mining)

system('rm -f rdevel.db')

print(date())
Rprof(
  filename = '/home/Email/rdevel.Rprof',
  memory.profiling = TRUE,
  gc.profiling = TRUE, 
  line.profiling = TRUE,
  numfiles = 10000L,
  bufsize = 10000L
)
rdevel.corpus <- make.email.corpus(
  '/home/Email/2006',
  Permanent=FALSE,
  dbName='rdevel.db'
)
Rprof(NULL)
print(date())
print(
  summaryRprof(
    filename = '/home/Email/rdevel.Rprof',
    memory = "both",
    lines = "both"
  )
)

# data cleaning
require(tm)
old.mc.cores <- options(mc.cores = 1) # debugging
rdevel.corpus <- tm_map(rdevel.corpus, as.PlainTextDocument)
rdevel.corpus <- tm_map(rdevel.corpus, stripWhitespace)
rdevel.corpus <- tm_map(rdevel.corpus, tolower)
rdevel.corpus <- tm_map(rdevel.corpus, stemDocument, language='english')
#rdevel.corpus <- tm_map(rdevel.corpus, removeWords, stopwords('english'))

print(summary(rdevel.corpus))
save(rdevel.corpus, file='/home/Email/rdevel-corpus.rda', compress='xz')

# Authors
authors <- lapply(rdevel.corpus, Author)
authors <- sapply(authors, paste, collapse = " ")
print(sort(table(authors), decreasing = TRUE)[1:5])

# Topics / Headings
headings <- lapply(rdevel.corpus, Heading)
headings <- sapply(headings, paste, collapse = " ")

# The sorted contingency table shows the biggest topics’ names and the amount of postings
print(bigTopicsTable <- sort(table(headings), decreasing = TRUE)[1:5])
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

# now make Term-Document Matrix
tdm <- TermDocumentMatrix(rdevel.corpus)

# find frequent terms
f <- findFreqTerms(tdm, 30, 31)
print(sort(f[-grep("[0-9]", f)]))
