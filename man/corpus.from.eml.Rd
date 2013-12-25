\name{corpus.from.eml}
\alias{corpus.from.eml}
\title{Make an email corpus from an 'eml' directory}
\usage{
corpus.from.eml(directory, datestampformat)
}
\arguments{
  \item{directory}{absolute path to a directory containing
  email messages, one per file, aka 'eml format'}

  \item{datestampformat}{format to use parsing message time
  stamps}
}
\description{
'corpus.from.eml' makes an email corpus from a directory
containing email messages
}
\examples{
# email.corpus <- corpus.from.eml(
#   directory = '/data/Enron/enron_mail_20110402/maildir/dasovich-j/all_documents',
#   datestampformat = \%a, \%d \%b \%Y \%X \%z'
# )
}
\keyword{corpus}
\keyword{email}
\keyword{eml}

