#' Make an email corpus from an 'eml' directory
#'
#' 'corpus.from.eml' makes an email corpus from a directory containing email messages
#'
#' @keywords email corpus eml
#' @export corpus.from.eml
#' @importFrom tm VCorpus
#' @importFrom tm DirSource
#' @importFrom tm.plugin.mail readMail
#' @param directory absolute path to a directory containing email messages, one per file, aka 'eml format'
#' @param datestampformat format to use parsing message time stamps
#' @examples
#' # email.corpus <- corpus.from.eml(
#' #   directory = '/data/Enron/enron_mail_20110402/maildir/dasovich-j/all_documents',
#' #   datestampformat = %a, %d %b %Y %X %z'
#' # )

corpus.from.eml <- function(directory, datestampformat) {
  email.corpus <- VCorpus(
    DirSource(directory, recursive=TRUE),
    readerControl = list(
      reader = readMail(DateFormat = datestampformat),
      load = TRUE
    )
  )
}

#' Make an email corpus from an 'mbox' file
#'
#' 'mbox.to.corpus' makes an email corpus from an 'mbox' file, which may be compressed!
#'
#' @keywords email corpus mbox
#' @export corpus.from.mbox
#' @importFrom tm.plugin.mail convert_mbox_eml
#' @param source.file an input file of emails in 'mbox' format, which may be compressed
#' @param datestampformat format to use parsing message time stamps
#' @examples
#' # email.corpus <- corpus.from.mbox(
#' #   source.file = '2013-December.txt.gz',
#' #   datestampformat = %a, %d %b %Y %X %z'
#' # )

corpus.from.mbox <- function(source.file, datestampformat) {
  workdir <- tempdir()
  convert_mbox_eml(source.file, workdir)
  email.corpus <- corpus.from.eml(workdir, datestampformat)
  unlink(workdir, recursive=TRUE, force=TRUE)
  return(email.corpus)
}
