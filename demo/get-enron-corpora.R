#' @demoTitle Download Enron corpus tarball and build corpora from the mailboxes
library(downloader)
library(email.mining.for.journos)
library(tm)
here <- setwd('~/Downloads')
directory <- 'enron_mail_20110402'
tarball <- paste(directory, 'tgz', sep = '.')
tarball.url <- paste('http://download.srv.cs.cmu.edu/~enron', tarball, sep = '/')
unlink(directory, recursive = TRUE, force = TRUE)
unlink(tarball, force = TRUE)
download(
  url = tarball.url,
  destfile = tarball,
  quiet = TRUE,
  mode = 'wb'
)
untar(tarball, compressed='gzip')
setwd(paste(directory, 'maildir', sep = '/'))
mailboxes <- unique(
  sub(pattern = '\\/[1-9][0-9]*\\.$', replacement = '',
    grep(pattern = '.',
      list.files(full.names=FALSE, recursive=TRUE),
      fixed=TRUE,
      value=TRUE)
  )
)
for (mailbox.name in mailboxes) {
  print(paste('Processing mailbox', mailbox.name, sep = ' '))
  email.corpus <- corpus.from.eml(mailbox.name)
  meta(email.corpus, tag = 'creator', type = 'corpus') <- '@znmeb'
  meta(email.corpus, tag = 'mailbox.name', type = 'corpus') <- mailbox.name
  save.name <- gsub(pattern = '/', replacement = '-', mailbox.name)
  save(
    email.corpus,
    file = paste(save.name, 'corpus.rda', sep = '.'),
    compress = 'xz'
  )
}
setwd(here)
