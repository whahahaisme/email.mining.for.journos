#' @demoTitle Download R-devel / R-help archives & build corpora
library(email.mining.for.journos)
download.r.mailing.list.archives(
  destination.directory = '~/Documents/Data/RMailingLists'
)
corpora.from.r.mailing.list.archives(
  destination.directory = '~/Documents/Data/RMailingLists',
  creator = 'znmeb@znmeb.net'
)
