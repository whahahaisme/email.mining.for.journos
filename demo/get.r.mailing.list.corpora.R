#' @demoTitle Download R-devel and R-help archives and build corpora
library(email.mining.for.journos)
r.mailing.list.root <- download.r.mailing.list.archives(
  destination.directory = '/data/RMailingLists'
)
corpora.from.r.mailing.list.archives(
  destination.directory = '/data/RMailingLists',
  r.mailing.list.root = r.mailing.list.root
)
