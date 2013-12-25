#' @demoTitle Download Enron corpus tarball and build corpora from the mailboxes
enron.tarball.url <- download.enron.mailboxes(destination.directory = '/data/Enron')
corpora.from.enron.mailboxes(
  destination.directory = '/data/Enron',
  tarball.url = enron.tarball.url
)
