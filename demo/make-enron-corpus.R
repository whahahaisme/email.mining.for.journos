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
enron.corpus <- make.email.corpus('/data/enron')
print(date())
print(summary(enron.corpus))
save(enron.corpus, file='/data/enron-corpus.rda', compress='xz')

# now make and save Document-Term Matrix
print(gc())
enron.dtm <- DocumentTermMatrix(enron.corpus)
print(gc())
save(enron.dtm, file='/data/enron-dtm.rda', compress='xz')

# Authors
authors <- lapply(enron.corpus, Author)
authors <- sapply(authors, paste, collapse = " ")
print(sort(table(authors), decreasing = TRUE)[1:20])

# Topics / Headings
headings <- lapply(enron.corpus, Heading)
headings <- sapply(headings, paste, collapse = " ")
print(sort(table(headings), decreasing = TRUE)[1:20])
