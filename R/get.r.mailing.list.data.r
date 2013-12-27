#' Download 'r-devel' and 'r-help' mailing list archives
#'
#' 'download.r.mailing.list.archives' downloads the 'r-devel' and 'r-help'
#' mailing list archives to a user-specified directory. If the destination
#' directory exists, it is deleted and re-created.
#' 
#' @keywords email r-devel r-help corpus mbox
#' @export download.r.mailing.list.archives
#' @importFrom downloader download
#' @param destination.directory absolute path to a directory where you want the downloaded Enron corpus stored
#' @examples
#' # download.r.mailing.list.archives(
#' #   destination.directory = '/data/RMailingLists'
#' # )

download.r.mailing.list.archives <- function(destination.directory) {
  here <- .to.newdir(destination.directory)

  for (mailing.list in c('r-devel', 'r-help')) {

    # make a sub-directory for the mailing list
    dir.create(path = mailing.list)
    setwd(mailing.list)

    # get the index page
    where <- paste(.r.mailing.list.root(), mailing.list, sep = '/')
    download(
      url = where,
      destfile = 'index.html',
      mode = 'wb',
      quiet = TRUE,
      extra = '--no-check-certificate'
    )
    
    # parse out the file names
    file.names <- grep(pattern = 'txt.gz', readLines('index.html'), value = TRUE)
    file.names <- sub(pattern = 'gz.*$', replacement = 'gz', file.names)
    file.names <- sub(pattern = '^.*href="', replacement = '', file.names)

    # download the archive files
    for (source.file in file.names) {
      print(paste('Downloading', mailing.list, source.file))
      source.url <- paste(where, source.file, sep = '/')
      download(
        url = source.url,
        destfile = source.file,
        mode = 'wb',
        quiet = TRUE,
        extra = '--no-check-certificate'
      )
    }

    # go back up one level
    setwd('..')
  }

  print(paste('Returning to', here))
  setwd(here)
}

#' Make corpora from the R mailing list archives
#'
#' 'corpora.from.r.mailing.list.archives' makes corpora, one per month of 
#' archived data, from the archives acquired via
#' 'download.r.mailing.list.archives'.
#'
#' @keywords email r-devel r-help corpus mbox
#' @export corpora.from.r.mailing.list.archives
#' @importFrom tm meta
#' @importFrom tm meta<-
#' @param destination.directory absolute path to a directory where you want the downloaded Enron corpus stored
#' @examples
#' # corpora.from.r.mailing.list.archives(
#' #   destination.directory = '/data/RMailingLists'
#' # )

corpora.from.r.mailing.list.archives <- function(destination.directory) {
  here <- setwd(destination.directory)
  print(paste('Left', here, 'for', getwd()))

  for (mailing.list in c('r-devel', 'r-help')) {
    setwd(mailing.list)
    
    # get the archive file names
    file.names <- list.files(full.names=FALSE, recursive=FALSE)
    file.names <- grep(pattern = '.txt.gz$', file.names, value=TRUE)
    
    # make and tag corpora
    for (source.file in file.names) {

      # make and tag corpus
      email.corpus <- corpus.from.mbox(
        source.file = source.file,
        datestampformat = .r.mailing.list.date.stamp.format()
      )  
      meta(email.corpus, tag = 'creator', type = 'corpus') <- 'znmeb@znmeb.net'
      meta(email.corpus, tag = 'source.url', type = 'corpus') <- 
        paste(.r.mailing.list.root(), mailing.list, source.file, sep = '/') 

      # compute save file name
      month <- sub(pattern = '.txt.gz$', replacement = '', source.file)
      month <- sub(pattern = '^.+-', replacement = '', month)
      month.number <- sprintf('%02d', which(month.name == month))
      save.name <- sub(pattern = '.txt.gz$', replacement = '.corpus.rda', source.file)
      save.name <- sub(pattern = month, replacement = month.number, save.name)
      save.name <- paste(mailing.list, save.name, sep = '.')
      save.name <- gsub(pattern = '-', replacement = '.', save.name)
      save(email.corpus, file = save.name, compress = 'xz')
      print(
        paste('Made corpus', save.name, 'from archive', mailing.list, source.file)
      )
    }

    setwd('..')
  }

  print(paste('Returning to', here))
  setwd(here)
}
