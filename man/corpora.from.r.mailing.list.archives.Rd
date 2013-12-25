\name{corpora.from.r.mailing.list.archives}
\alias{corpora.from.r.mailing.list.archives}
\title{Make corpora from the R mailing list archives}
\usage{
corpora.from.r.mailing.list.archives(destination.directory, r.mailing.list.root)
}
\arguments{
  \item{destination.directory}{absolute path to a directory
  where you want the downloaded Enron corpus stored}

  \item{r.mailing.list.root}{The URL of the Enron tarball.
  This is inserted into the metadata of the output corpora}
}
\description{
'corpora.from.r.mailing.list.archives' makes corpora, one
per month of archived data, from the mailboxes archives
acquired via 'download.r.mailing.list.archives'
}
\examples{
# corpora.from.r.mailing.list.archives(
#   '/data/RMailingLists',
#   'https://stat.ethz.ch/pipermail'
# )
}
\keyword{corpus}
\keyword{email}
\keyword{mbox}
\keyword{r-devel}
\keyword{r-help}

