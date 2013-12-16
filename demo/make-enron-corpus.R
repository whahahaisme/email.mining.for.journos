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
require(email.mining.for.journos)
require(tm)

system('rm -f enron.db')

print(date())
enron.corpus <- make.email.corpus(
  '/home/Email/enron/enron_mail_20110402/flattened',
  Permanent=FALSE,
  dbName='enron.db'
)
print(date())

print(summary(enron.corpus))
save(enron.corpus, file='/home/Email/enron-corpus.rda', compress='xz')

# now make and save Document-Term Matrix
enron.dtm <- DocumentTermMatrix(enron.corpus)
save(enron.dtm, file='/home/Email/enron-dtm.rda', compress='xz')

# Authors
authors <- lapply(enron.corpus, Author)
authors <- sapply(authors, paste, collapse = " ")
print(sort(table(authors), decreasing = TRUE)[1:20])

# Topics / Headings
headings <- lapply(enron.corpus, Heading)
headings <- sapply(headings, paste, collapse = " ")

# The sorted contingency table shows the biggest topics' names and the amount of postings
print(bigTopicsTable <- sort(table(headings), decreasing = TRUE)[1:20])
bigTopics <- names(bigTopicsTable)
