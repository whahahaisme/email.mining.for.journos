\name{corpora.from.enron.mailboxes}
\alias{corpora.from.enron.mailboxes}
\title{Make corpora from the Enron mailboxes}
\usage{
corpora.from.enron.mailboxes(destination.directory, tarball.url)
}
\arguments{
  \item{destination.directory}{absolute path to a directory
  where you want the downloaded Enron corpus stored}

  \item{tarball.url}{The URL of the Enron tarball. This is
  inserted into the metadata of the output corpora}
}
\description{
'corpora.from.enron.mailboxes' makes corpora, one per
mailbox, from the mailboxes acquired via
'download.enron.mailboxes'
}
\examples{
# enron.tarball.url <- download.enron.mailboxes('/data/Enron')
}
\keyword{Enron}
\keyword{corpus}
\keyword{email}
\keyword{eml}

