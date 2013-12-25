#' Download the r-devel and r-help mailing list archives into a user-specified directory
#'
#' 'download.r.mailing.list.archives' downloads the R mailing list archives. The returned 
#' function value is the root URL for the mailing list archives. The sequence of operations is
#' 
#' 1. Remove the destination directory.
#' 2. Create an empty destination directory.
#' 3. Change into the destination directory.
#' 4. Download the r-devel archive tarballs.
#' 5. Download the r-help archive tarballs.
#' 6. Return to the original directory.
#'
#' @keywords email r corpus mbox
#' @export download.r.mailing.list.archives
#' @importFrom downloader download
#' @param destination.directory absolute path to a directory where you want the downloaded Enron corpus stored
#' @examples
#' # r.mailing.list.root <- 
#' #   download.r.mailing.list.archives(
#' #     destination.directory = '/data/RMailingLists'
#' # )

download.r.mailing.list.archives <- function(destination.directory) {
  r.mailing.list.root <- 'https://stat.ethz.ch/pipermail'
  
  print(paste('Removing', destination.directory))
  unlink(destination.directory, recursive = TRUE, force = TRUE)
  
  print(paste('Creating', destination.directory))
  dir.create(path = destination.directory, recursive = TRUE)
  here <- setwd(destination.directory)
  print(paste('Left', here, 'for', getwd()))
  
  for (mailing.list in c('r-devel', 'r-help')) {
    dir.create(path = mailing.list)
    setwd(mailing.list)
    where <- paste(r.mailing.list.root, mailing.list, sep = '/')

    # get the index page
    download(
      url = where,
      destfile = 'webpage.html',
      mode = 'wb',
      quiet = TRUE,
      extra = '--no-check-certificate'
    )
    
    # parse out the file names
    file.names <- grep(
      pattern = 'txt.gz',
      readLines('webpage.html'),
      value = TRUE
    )
    file.names <- sub(pattern = 'gz.*$', replacement = 'gz', file.names)
    file.names <- sub(pattern = '^.*href="', replacement = '', file.names)

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
    setwd('..')
  }

  print(paste('Returning to', here))
  setwd(here)
  return(r.mailing.list.root)
}

#' Make corpora from the R mailing list archives
#'
#' 'corpora.from.r.mailing.list.archives' makes corpora, one per month of archived data, from the mailboxes archives acquired via 'download.r.mailing.list.archives'
#'
#' @keywords email Enron corpus eml
#' @export corpora.from.r.mailing.list.archives
#' @importFrom tm meta
#' @importFrom tm meta<-
#' @param destination.directory absolute path to a directory where you want the downloaded Enron corpus stored
#' @param r.mailing.list.root The URL of the Enron tarball. This is inserted into the metadata of the output corpora
#' @examples
#' # corpora.from.r.mailing.list.archives(
#' #   '/data/RMailingLists',
#' #   'https://stat.ethz.ch/pipermail'
#' # )

corpora.from.r.mailing.list.archives <- function(destination.directory, r.mailing.list.root) {
  here <- setwd(destination.directory)
  print(paste('Left', here, 'for', getwd()))

  for (mailing.list in c('r-devel', 'r-help')) {
    setwd(mailing.list)
    
    # get the archive file names
    file.names <- list.files(full.names=FALSE, recursive=FALSE)
    file.names <- grep(pattern = '.tar.gz$', file.names, value=TRUE)

    for (source.file in file.names) {

      print(paste('Processing archive', mailing.list, source.file))
      email.corpus <- corpus.from.mbox(
        source.file = source.file,
        datestampformat = '%a, %d %b %Y %X %z'
      )
      
      meta(email.corpus, tag = 'creator', type = 'corpus') <- 'znmeb@znmeb.net'
      meta(email.corpus, tag = 'source.url', type = 'corpus') <- 
        paste(r.mailing.list.root, mailing.list, source.file, sep = '/') 

      # compute save file name
      month <- sub(pattern = '.txt.gz$', replacement = '', source.file)
      month <- sub(pattern = '^.+-', replacement = '', month)
      month.number <- sprintf('%02d', which(month.name == month))
      save.name <- sub(
        pattern = '.txt.gz$',
        replacement = '.corpus.rda',
        source.file
      )
      save.name <- sub(pattern = month, replacement = month.number, save.name)
      save.name <- paste(mailing.list, save.name, sep = '-')
      print(paste('Saving corpus', save.name))
      save(
        email.corpus,
        file = save.name,
        compress = 'xz'
      )
    }
    setwd('..')
  }
  print(paste('Returning to', here))
  setwd(here)
}
