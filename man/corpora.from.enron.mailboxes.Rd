\name{corpora.from.enron.mailboxes}
\alias{corpora.from.enron.mailboxes}
\title{Make corpora from the Enron mailboxes}
\usage{
corpora.from.enron.mailboxes(destination.directory, enron.tarball.url)
}
\arguments{
  \item{destination.directory}{absolute path to a directory
  where you want the downloaded Enron corpus stored}

  \item{enron.tarball.url}{The URL of the Enron tarball.
  This is inserted into the metadata of the output corpora}
}
\description{
'corpora.from.enron.mailboxes' makes corpora, one per
mailbox, from the mailboxes acquired via
'download.enron.mailboxes'
}
\examples{
# corpora.from.enron.mailboxes(
#   '/data/Enron',
#   'http://download.srv.cs.cmu.edu/~enron/enron_mail_20110402.tgz'
# )
}
\keyword{Enron}
\keyword{corpus}
\keyword{email}
\keyword{eml}

