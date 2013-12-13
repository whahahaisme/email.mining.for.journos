# Copyright (C) 2012 by M. Edward (Ed) Borasky
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
require(filehash)

enron.corpus <- PCorpus(
  DirSource('/home/Email/enron/enron_mail_20110402/flattened'),
  readerControl = list(
    reader = readMail,
    language = "en_US",
    load = TRUE
  ),
  dbControl = list(
    dbName = 'enron.db'
  )
)
