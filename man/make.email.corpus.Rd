\name{make.email.corpus}
\alias{make.email.corpus}
\title{Make an email corpus using the 'tm' and 'tm.plugin.mail' packages}
\usage{
make.email.corpus(DirSource, Permanent = FALSE, dbName = "corpus.db")
}
\arguments{
  \item{DirSource}{absolute path to a directory containing
  email messages, one per file}

  \item{Permanent}{TRUE for a Permanent corpus, FALSE
  (default) for Volatile}

  \item{dbName}{filename for the database used by a
  Permanent corpus}
}
\description{
'make.email.corpus' makes an email corpus from a flattened
directory of email message files.
}
\examples{
# rdevel.corpus <- make.email.corpus('/home/Email/2006', Permanent=FALSE, dbName='rdevel.db')
}
\keyword{corpus}
\keyword{email}

