#' @demoTitle Download R-devel / R-help archives & build corpora
library(email.mining.for.journos)
download.r.mailing.list.archives(
  destination.directory = '/data/RMailingLists'
)
corpora.from.r.mailing.list.archives(
  destination.directory = '/data/RMailingLists'
)
