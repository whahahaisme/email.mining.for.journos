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
#' @keywords email corpus
#' @export make.email.corpus
#' @importFrom tm VCorpus
#' @importFrom tm DirSource
#' @importFrom tm.plugin.mail readMail
#' @param DirSource absolute path to a directory containing email messages, one per file
#' @examples
#' # rdevel.corpus <- make.email.corpus('/data/rdevel')

make.email.corpus <- function(DirSource) {

  # build the corpus first
  email.corpus <- VCorpus(
    DirSource(DirSource),
    readerControl = list(
      reader = readMail,
      language = "en_US",
      load = TRUE
    )
  )
  return(email.corpus)
}
