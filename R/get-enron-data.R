# Copyright (C) 2013 by M. Edward (Ed) Borasky
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http://www.gnu.org/licenses/agpl-3.0.txt) for more details.

#' Download and unpack the Enron corpus tarball
#'
#' 'download.enron.mailboxes' downloads and unpacks the Enron corpus tarball. The returned 
#' function value is the URL from whence the tarball came.
#'
#' @keywords email Enron corpus eml
#' @export download.enron.mailboxes
#' @importFrom downloader download
#' @param destination.directory absolute path to a directory where you want the downloaded Enron corpus stored
#' @examples
#' # enron.tarball.url <- download.enron.mailboxes('/data/Enron')

download.enron.mailboxes <- function(destination.directory) {
  unlink(destination.directory, recursive = TRUE, force = TRUE)
  dir.create(path = destination.directory, recursive = TRUE)
  here <- setwd(destination.directory)
  directory <- 'enron_mail_20110402'
  tarball <- paste(directory, 'tgz', sep = '.')
  tarball.url <- paste(
    'http://download.srv.cs.cmu.edu/~enron',
    tarball,
    sep = '/'
  )
  unlink(directory, recursive = TRUE, force = TRUE)
  unlink(tarball, force = TRUE)
  download(
    url = tarball.url,
    destfile = tarball,
    quiet = TRUE,
    mode = 'wb'
  )
  untar(tarball, compressed='gzip')
  setwd(here)
  return(tarball.url)
}

#' Make corpora from the Enron mailboxes
#'
#' 'corpora.from.enron.mailboxes' makes corpora, one per mailbox, from the mailboxes acquired via 'download.enron.mailboxes'
#'
#' @keywords email Enron corpus eml
#' @export download.enron.mailboxes
#' @importFrom downloader download
#' @param destination.directory absolute path to a directory where you want the downloaded Enron corpus stored
#' @examples
#' # enron.tarball.url <- download.enron.mailboxes('/data/Enron')

corpora.from.enron.mailboxes <- function(destination.directory, tarball.url) {
  here <- setwd(
    paste(
      destination.directory,
      'enron_mail_20110402',
      'maildir',
       sep = '/'
    )
  )
  mailboxes <- unique(
    sub(pattern = '\\/[1-9][0-9]*\\.$', replacement = '',
      grep(pattern = '.',
        list.files(full.names=FALSE, recursive=TRUE),
        fixed=TRUE,
        value=TRUE
      )
    )
  )

  for (mailbox.name in mailboxes) {
    print(paste('Processing mailbox', mailbox.name, sep = ' '))
    email.corpus <- corpus.from.eml(mailbox.name, '%a, %d %b %Y %X %z')
    meta(email.corpus, tag = 'creator', type = 'corpus') <- 'znmeb@znmeb.net'
    meta(email.corpus, tag = 'mailbox.name', type = 'corpus') <- mailbox.name
    meta(email.corpus, tag = 'source.url', type = 'corpus') <- tarball.url
    save.name <- gsub(pattern = '/', replacement = '-', mailbox.name)
    save(
      email.corpus,
      file = paste(save.name, 'corpus.rda', sep = '.'),
      compress = 'xz'
    )
  }
  setwd(here)
}
