#' Download and unpack the Enron corpus tarball into a user-specified directory
#'
#' 'download.enron.mailboxes' downloads and unpacks the Enron corpus tarball. The returned 
#' function value is the URL from whence the tarball came. The sequence of operations is
#' 
#' 1. Remove the destination directory.
#' 2. Create an empty destination directory.
#' 3. Change into the destination directory.
#' 4. Download the tarball.
#' 5. Unpack the tarball.
#' 6. Return to the original directory.
#'
#' @keywords email Enron corpus eml
#' @export download.enron.mailboxes
#' @importFrom downloader download
#' @param destination.directory absolute path to a directory where you want the downloaded Enron corpus stored
#' @examples
#' # enron.tarball.url <- download.enron.mailboxes(destination.directory = '/data/Enron')

download.enron.mailboxes <- function(destination.directory) {

  print(paste('Removing', destination.directory))
  unlink(destination.directory, recursive = TRUE, force = TRUE)

  print(paste('Creating', destination.directory))
  dir.create(path = destination.directory, recursive = TRUE)
  here <- setwd(destination.directory)
  print(paste('Left', here, 'for', getwd()))

  directory <- 'enron_mail_20110402'
  tarball <- paste(directory, 'tgz', sep = '.')
  tarball.url <- paste(
    'http://download.srv.cs.cmu.edu/~enron',
    tarball,
    sep = '/'
  )

  print(paste('Downloading', tarball.url))
  download(
    url = tarball.url,
    destfile = tarball,
    quiet = TRUE,
    mode = 'wb'
  )

  print(paste('Unpacking', tarball))
  untar(tarball, compressed='gzip')
  print(paste('Returning to', here))
  setwd(here)
  return(tarball.url)
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
#' @param tarball.url The URL of the Enron tarball. This is inserted into the metadata of the output corpora
#' @examples
#' # corpora.from.enron.mailboxes(
#' #   '/data/Enron',
#' #   'http://download.srv.cs.cmu.edu/~enron/enron_mail_20110402.tgz'
#' # )

corpora.from.enron.mailboxes <- function(destination.directory, tarball.url) {
  here <- setwd(
    paste(
      destination.directory,
      'enron_mail_20110402',
      'maildir',
       sep = '/'
    )
  )
  print(paste('Left', here, 'for', getwd()))
  
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
    email.corpus <- corpus.from.eml(mailbox.name, '%a, %d %b %Y %X %z')
    meta(email.corpus, tag = 'creator', type = 'corpus') <- 'znmeb@znmeb.net'
    meta(email.corpus, tag = 'mailbox.name', type = 'corpus') <- mailbox.name
    meta(email.corpus, tag = 'source.url', type = 'corpus') <- tarball.url
    save.name <- gsub(pattern = '/', replacement = '-', mailbox.name)
    save.name <- paste(save.name, 'corpus.rda', sep = '.')
    save(
      email.corpus,
      file = save.name,
      compress = 'xz'
    )
    print(paste('Processing mailbox', mailbox.name))
    print(
      paste(
        'Made corpus',
        save.name,
        'from mailbox',
        mailbox.name
      )
    )
  }
  print(paste('Returning to', here))
  setwd(here)
}
