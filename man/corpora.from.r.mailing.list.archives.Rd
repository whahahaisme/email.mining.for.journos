\name{corpora.from.r.mailing.list.archives}
\alias{corpora.from.r.mailing.list.archives}
\title{Make corpora from the R mailing list archives}
\usage{
corpora.from.r.mailing.list.archives(destination.directory, creator)
}
\arguments{
  \item{destination.directory}{absolute path to a directory
  where you want the downloaded Enron corpus stored}

  \item{creator}{email address of the creator for a
  corpus-level meta tag}
}
\description{
'corpora.from.r.mailing.list.archives' makes corpora, one
per month of archived data, from the archives acquired via
'download.r.mailing.list.archives'.
}
\examples{
# corpora.from.r.mailing.list.archives(
#   destination.directory = '/data/RMailingLists',
#   creator = 'znmeb at znmeb dot net'
# )
}
\keyword{corpus}
\keyword{email}
\keyword{mbox}
\keyword{r-devel}
\keyword{r-help}

