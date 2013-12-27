#' Download and unpack the Enron corpus tarball
#'
#' 'download.enron.mailboxes' downloads and unpacks the Enron corpus tarball
#' to a user-specified directory. If the destination directory exists,
#' it is deleted and re-created.
#'
#' @keywords email Enron corpus eml
#' @export download.enron.mailboxes
#' @importFrom downloader download
#' @param destination.directory absolute path to a directory where you want the downloaded Enron data stored
#' @examples
#' # download.enron.mailboxes(destination.directory = '/data/Enron')

download.enron.mailboxes <- function(destination.directory) {

  here <- .to.newdir(destination.directory)

  tarball <- basename(.enron.tarball.url())
  print(paste('Downloading', .enron.tarball.url()))
  download.time <- system.time(download(
    url = .enron.tarball.url(),
    destfile = tarball,
    quiet = TRUE,
    mode = 'wb'
  ))
  print('Download time:')
  print(download.time)
  print(paste('Unpacking', tarball))
  untar(tarball, compressed='gzip')
  print(paste('Returning to', here))
  setwd(here)
}

#' Make corpora from the Enron mailboxes
#'
#' 'corpora.from.enron.mailboxes' makes corpora, one per mailbox, from the mailboxes acquired via 'download.enron.mailboxes'
#'
#' @keywords email Enron corpus eml
#' @export corpora.from.enron.mailboxes
#' @importFrom tm meta
#' @importFrom tm meta<-
#' @param destination.directory absolute path to a directory where you want the downloaded Enron corpus stored
#' @examples
#' # corpora.from.enron.mailboxes(destination.directory = '/data/Enron')

corpora.from.enron.mailboxes <- function(destination.directory) {
  here <- setwd(
    paste(destination.directory, 'enron_mail_20110402/maildir', sep = '/')
  )
  print(paste('Left', here, 'for', getwd()))
  
  # regular expression shenanigans to get the mailbox paths
  mailboxes <- list.files(full.names=FALSE, recursive=TRUE)
  mailboxes <- grep(pattern = '\\/[1-9][0-9]*\\.$', mailboxes, value = TRUE)
  mailboxes <- sub(pattern = '\\/[1-9][0-9]*\\.$', replacement = '', mailboxes)
  mailboxes <- unique(mailboxes)

  # now make corpora from the mailboxes
  for (mailbox.name in mailboxes) {

    # make and tag corpus
    email.corpus <- corpus.from.eml(mailbox.name, .enron.date.stamp.format())
    meta(email.corpus, tag = 'creator', type = 'corpus') <- 'znmeb@znmeb.net'
    meta(email.corpus, tag = 'mailbox.name', type = 'corpus') <- mailbox.name
    meta(email.corpus, tag = 'source.url', type = 'corpus') <- .enron.tarball.url()

    # save corpus
    save.name <- gsub(pattern = '/', replacement = '.', mailbox.name)
    save.name <- gsub(pattern = '-', replacement = '.', save.name)
    save.name <- paste(save.name, 'corpus.rda', sep = '.')
    save(email.corpus, file = save.name, compress = 'xz')
    print(paste('Made corpus', save.name, 'from mailbox', mailbox.name))

  }

  print(paste('Returning to', here))
  setwd(here)
}
