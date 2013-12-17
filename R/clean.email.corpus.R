# Copyright (C) 2013 by M. Edward (Ed) Borasky
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http://www.gnu.org/licenses/agpl-3.0.txt) for more details.
#
#' Clean an email corpus using the 'tm' and 'tm.plugin.webmining' packages
#'
#' 'clean.email.corpus' cleans an email corpus made by 'make.email.corpus.
#'
#' @keywords email corpus data cleaning
#' @export clean.email.corpus
#' @importFrom tm tm_map
#' @importFrom tm as.PlainTextDocument
#' @importFrom tm.plugin.webmining removeNonASCII
#' @importFrom tm removeNumbers
#' @importFrom tm removePunctuation
#' @importFrom tm stripWhitespace
#' @importFrom tm stemDocument
#' @importFrom tm removeWords
#' @importFrom tm stopwords
#' @param email.corpus an email corpus made via make.email.corpus
#' @examples
#' # rdevel.corpus <- clean.email.corpus(rdevel.corpus)

clean.email.corpus <- function(email.corpus) {

  # data cleaning
  email.corpus <- tm_map(email.corpus, as.PlainTextDocument)
  email.corpus <- tm_map(email.corpus, removeNonASCII)
  email.corpus <- tm_map(email.corpus, removeNumbers)
  email.corpus <- tm_map(email.corpus, removePunctuation)
  email.corpus <- tm_map(email.corpus, stripWhitespace)
  email.corpus <- tm_map(email.corpus, tolower)
  email.corpus <- tm_map(email.corpus, stemDocument, language='english')
  #email.corpus <- tm_map(email.corpus, removeWords, stopwords('english'))
  return(email.corpus)
}
