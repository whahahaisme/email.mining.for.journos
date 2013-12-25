#' @demoTitle Download Enron corpus tarball & build corpora from mailboxes
library(email.mining.for.journos)
download.enron.mailboxes(destination.directory = '/data/Enron')
corpora.from.enron.mailboxes(destination.directory = '/data/Enron')
