\name{download.enron.mailboxes}
\alias{download.enron.mailboxes}
\title{Download and unpack the Enron corpus tarball}
\usage{
download.enron.mailboxes(destination.directory)
}
\arguments{
  \item{destination.directory}{absolute path to a directory
  where you want the downloaded Enron data stored}
}
\description{
'download.enron.mailboxes' downloads and unpacks the Enron
corpus tarball to a user-specified directory. If the
destination directory exists, it is deleted and re-created.
}
\examples{
# download.enron.mailboxes(destination.directory = '/data/Enron')
}
\keyword{Enron}
\keyword{corpus}
\keyword{email}
\keyword{eml}

