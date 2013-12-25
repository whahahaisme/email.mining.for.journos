\name{download.r.mailing.list.archives}
\alias{download.r.mailing.list.archives}
\title{Download the r-devel and r-help mailing list archives into a user-specified directory}
\usage{
download.r.mailing.list.archives(destination.directory)
}
\arguments{
  \item{destination.directory}{absolute path to a directory
  where you want the downloaded Enron corpus stored}
}
\description{
'download.r.mailing.list.archives' downloads the R mailing
list archives. The returned function value is the root URL
for the mailing list archives.
}
\examples{
# r.mailing.list.root <-
#   download.r.mailing.list.archives(
#     destination.directory = '/data/RMailingLists'
# )
}
\keyword{corpus}
\keyword{email}
\keyword{mbox}
\keyword{r}

