\name{download.enron.mailboxes}
\alias{download.enron.mailboxes}
\title{Download and unpack the Enron corpus tarball into a user-specified directory}
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
whence the tarball came. The sequence of operations is
}
\details{
1. Remove the destination directory. 2. Create an empty
destination directory. 3. Change into the destination
directory. 4. Download the tarball. 5. Unpack the tarball.
6. Return to the original directory.
}
\examples{
# enron.tarball.url <- download.enron.mailboxes('/data/Enron')
}
\keyword{Enron}
\keyword{corpus}
\keyword{email}
\keyword{eml}

