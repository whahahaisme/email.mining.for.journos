# Copyright (C) 2013 by M. Edward (Ed) Borasky
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http://www.gnu.org/licenses/agpl-3.0.txt) for more details.
#
#' Make an email corpus from an 'eml' directory
#'
#' 'corpus.from.eml' makes an email corpus from a directory containing email messages
#'
#' @keywords email corpus eml
#' @export corpus.from.eml
#' @importFrom tm VCorpus
#' @importFrom tm DirSource
#' @importFrom tm.plugin.mail readMail
#' @param directory absolute path to a directory containing email messages, one per file, aka 'eml format'
#' @examples
#' # email.corpus <- corpus.from.eml('/data/rdevel')

corpus.from.eml <- function(directory) {
  email.corpus <- VCorpus(
    DirSource(directory),
    readerControl = list(
      reader = readMail,
      load = TRUE
    )
  )
}

#' Make an email corpus from an 'mbox' file
#'
#' 'mbox.to.corpus' makes an email corpus from an 'mbox' file, which may be compressed!
#'
#' @keywords email corpus mbox
#' @export mbox.to.corpus
#' @importFrom tm.plugin.mail convert_mbox_eml
#' @param source.file an input file of emails in 'mbox' format, which may be compressed
#' @examples
#' # email.corpus <- corpus.from.mbox('2013-December.txt.gz')

corpus.from.mbox <- function(source.file) {
  workdir <- tempdir()
  convert_mbox_eml(source.file, workdir)
  email.corpus <- corpus.from.eml(workdir)
  unlink(workdir, recursive=TRUE, force=TRUE)
  return(email.corpus)
}
