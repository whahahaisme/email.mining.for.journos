.to.newdir <- function(destination.directory) {
  print(paste('Removing', destination.directory))
  unlink(destination.directory, recursive = TRUE, force = TRUE)
  
  print(paste('Creating', destination.directory))
  dir.create(path = destination.directory, recursive = TRUE)
  here <- setwd(destination.directory)
  print(paste('Left', here, 'for', getwd()))
  return(here)  
}

.r.mailing.list.root <- function() {
  return('https://stat.ethz.ch/pipermail')
}

.enron.tarball.url <- function() {
  return('http://download.srv.cs.cmu.edu/~enron/enron_mail_20110402.tgz')
}
