#' @demoTitle Download Enron corpus tarball & build corpora from mailboxes
library(email.mining.for.journos)
download.enron.mailboxes(destination.directory = '~/Documents/Data/Enron')
corpora.from.enron.mailboxes(
  destination.directory = '~/Documents/Data/Enron',
  creator = 'znmeb@znmeb.net'
)
