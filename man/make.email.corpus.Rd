\name{make.email.corpus}
\alias{make.email.corpus}
\title{Make an email corpus using the 'tm' and 'tm.plugin.mail' packages}
\usage{
make.email.corpus(DirSource)
}
\arguments{
  \item{DirSource}{absolute path to a directory containing
  email messages, one per file}
}
\description{
'make.email.corpus' makes an email corpus from a flattened
directory of email message files.
}
\examples{
# rdevel.corpus <- make.email.corpus('/home/Email/2006')
}
\keyword{corpus}
\keyword{email}

