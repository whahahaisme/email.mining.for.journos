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

old.cores <- options(mc.cores = 1)
system('rm -f enron.db')

print(date())
Rprof(
  memory.profiling = TRUE,
  gc.profiling = TRUE, 
  line.profiling = TRUE,
  numfiles = 10000L,
  bufsize = 10000L
)
enron.corpus <- make.email.corpus(
  '/home/Email/enron/enron_mail_20110402/flattened',
  Permanent=FALSE,
  dbName='enron.db'
)
Rprof(NULL)
print(date())
print(
  summaryRprof(
    memory = "both",
    lines = "both"
  )
)
print(summary(enron.corpus))
