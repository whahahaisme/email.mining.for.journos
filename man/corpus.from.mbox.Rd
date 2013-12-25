\name{corpus.from.mbox}
\alias{corpus.from.mbox}
\title{Make an email corpus from an 'mbox' file}
\usage{
corpus.from.mbox(source.file, datestampformat)
}
\arguments{
  \item{source.file}{an input file of emails in 'mbox'
  format, which may be compressed}

  \item{datestampformat}{format to use parsing message time
  stamps}
}
\description{
'mbox.to.corpus' makes an email corpus from an 'mbox' file,
which may be compressed!
}
\examples{
# email.corpus <- corpus.from.mbox(
#   source.file = '2013-December.txt.gz',
#   datestampformat = \%a, \%d \%b \%Y \%X \%z'
# )
}
\keyword{corpus}
\keyword{email}
\keyword{mbox}

