# Copyright (C) 2013 by M. Edward (Ed) Borasky
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http://www.gnu.org/licenses/agpl-3.0.txt) for more details.
#
#' Make an email corpus using the 'tm' and 'tm.plugin.mail' packages
#'
#' 'make.email.corpus' makes an email corpus from a flattened directory of
#' email message files.
#'
#' @keywords email corpus data cleaning
#' @export clean.email.corpus
#' @importFrom tm tm_map
#' @importFrom tm as.PlainTextDocument
#' @importFrom tm.plugin.webmining removeNonASCII
#' @importFrom tm removePunctuation
#' @importFrom tm stripWhitespace
#' @importFrom tm stemDocument
#' @importFrom tm removeWords
#' @importFrom tm stopwords
#' @param email.corpus an email corpus made via make.email.corpus
#' @examples
#' # rdevel.corpus <- clean.email.corpus('/data/rdevel')

clean.email.corpus <- function(email.corpus) {

  # data cleaning
  email.corpus <- tm_map(email.corpus, as.PlainTextDocument)
  print(gc())
  email.corpus <- tm_map(email.corpus, removeNonASCII)
  print(gc())
  email.corpus <- tm_map(email.corpus, removeNumbers)
  print(gc())
  email.corpus <- tm_map(email.corpus, removePunctuation)
  print(gc())
  email.corpus <- tm_map(email.corpus, stripWhitespace)
  print(gc())
  email.corpus <- tm_map(email.corpus, tolower)
  print(gc())
  email.corpus <- tm_map(email.corpus, stemDocument, language='english')
  print(gc())
  #email.corpus <- tm_map(email.corpus, removeWords, stopwords('english'))
  #print(gc())
  return(email.corpus)
}
