# Copyright (C) 2013 by M. Edward (Ed) Borasky
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http://www.gnu.org/licenses/agpl-3.0.txt) for more details.
#

old.mc.cores <- options(mc.cores = 8) # set to 1 for debugging
gcinfo(TRUE)

# libraries needed
require(email.mining.for.journos)
require(tm)

print(date())
inboxes.corpus <- make.email.corpus('/data/inboxes')
print(date())
inboxes.corpus <- clean.email.corpus(inboxes.corpus)
print(date())
print(summary(inboxes.corpus))
save(inboxes.corpus, file='/data/inboxes-corpus.rda', compress='xz')

# now make and save Document-Term Matrix
inboxes.dtm <- DocumentTermMatrix(inboxes.corpus)
save(inboxes.dtm, file='/data/inboxes-dtm.rda', compress='xz')

# Authors
authors <- lapply(inboxes.corpus, Author)
authors <- sapply(authors, paste, collapse = " ")
print(sort(table(authors), decreasing = TRUE)[1:20])

# Topics / Headings
headings <- lapply(inboxes.corpus, Heading)
headings <- sapply(headings, paste, collapse = " ")
print(sort(table(headings), decreasing = TRUE)[1:20])
