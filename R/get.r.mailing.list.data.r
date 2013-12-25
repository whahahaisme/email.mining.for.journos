# Copyright (C) 2013 by M. Edward (Ed) Borasky
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http://www.gnu.org/licenses/agpl-3.0.txt) for more details.

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
#' # mailing.list.root <- 
#' #   download.r.mailing.list.archives(
#' #     destination.directory = '/data/RMailingLists'
#' # )

download.r.mailing.list.archives <- function(destination.directory) {
  mailing.list.root <- 'https://stat.ethz.ch/pipermail'
  
  print(paste('Removing', destination.directory))
  unlink(destination.directory, recursive = TRUE, force = TRUE)
  
  print(paste('Creating', destination.directory))
  dir.create(path = destination.directory, recursive = TRUE)
  here <- setwd(destination.directory)
  print(paste('Left', here, 'for', getwd()))
  
  for (mailing.list in c('r-devel', 'r-help')) {
    dir.create(path = mailing.list)
    setwd(mailing.list)
    where <- paste(mailing.list.root, mailing.list, sep = '/')
    download(
      url = where,
      destfile = 'webpage.html',
      mode = 'wb',
      quiet = TRUE,
      extra = '--no-check-certificate'
    )
    file.names <- sub(
      pattern = 'gz.*$',
      replacement = 'gz',
      sub(
        pattern = '^.*href="',
        replacement = '',
        grep(pattern = 'txt.gz', readLines('webpage.html'), value = TRUE)
      )
    )

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
  }
  setwd('..')

  print(paste('Returning to', here))
  setwd(here)
  return(mailing.list.root)
}
