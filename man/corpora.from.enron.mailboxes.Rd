\name{corpora.from.enron.mailboxes}
\alias{corpora.from.enron.mailboxes}
\title{Make corpora from the Enron mailboxes}
\usage{
corpora.from.enron.mailboxes(destination.directory, creator)
}
\arguments{
  \item{destination.directory}{absolute path to a directory
  where you want the downloaded Enron corpus stored}

  \item{creator}{email address of the creator for a
  corpus-level meta tag}
}
\description{
'corpora.from.enron.mailboxes' makes corpora, one per
mailbox, from the mailboxes acquired via
'download.enron.mailboxes'
}
\examples{
# corpora.from.enron.mailboxes(
#   destination.directory = '/data/Enron',
#   creator = 'znmeb at znmeb dot net'
# )
}
\keyword{Enron}
\keyword{corpus}
\keyword{email}
\keyword{eml}

