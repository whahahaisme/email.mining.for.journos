\name{download.r.mailing.list.archives}
\alias{download.r.mailing.list.archives}
\title{Download 'r-devel' and 'r-help' mailing list archives}
\usage{
download.r.mailing.list.archives(destination.directory)
}
\arguments{
  \item{destination.directory}{absolute path to a directory
  where you want the downloaded R mailing list archives
  stored}
}
\description{
'download.r.mailing.list.archives' downloads the 'r-devel'
and 'r-help' mailing list archives to a user-specified
directory. If the destination directory exists, it is
deleted and re-created.
}
\examples{
# download.r.mailing.list.archives(
#   destination.directory = '/data/RMailingLists'
# )
}
\keyword{archive}
\keyword{corpus}
\keyword{email}
\keyword{mailing.list}
\keyword{mbox}
\keyword{r-devel}
\keyword{r-help}

