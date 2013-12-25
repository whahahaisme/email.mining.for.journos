\name{download.enron.mailboxes}
\alias{download.enron.mailboxes}
\title{Download and unpack the Enron corpus tarball}
\usage{
download.enron.mailboxes(destination.directory)
}
\arguments{
  \item{destination.directory}{absolute path to a directory
  where you want the downloaded Enron corpus stored}
}
\description{
'download.enron.mailboxes' downloads and unpacks the Enron
corpus tarball. The returned function value is the URL from
whence the tarball came.
}
\examples{
# enron.tarball.url <- download.enron.mailboxes('/data/Enron')
}
\keyword{Enron}
\keyword{corpus}
\keyword{email}
\keyword{eml}

