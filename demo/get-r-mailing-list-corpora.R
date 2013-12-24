#' @demoTitle Download R-devel and R-help mailing list archives and build corpora
library(downloader)
library(email.mining.for.journos)
library(tm)
destination.directory <- '/data/RMailingLists'
unlink(destination.directory, recursive = TRUE, force = TRUE)
dir.create(path = destination.directory, recursive = TRUE)
here <- setwd(destination.directory)
for (mailing.list in c('r-devel', 'r-help')) {
  dir.create(path = mailing.list)
  setwd(mailing.list)
  where <- paste('https://stat.ethz.ch/pipermail', mailing.list, sep = '/')
  download(
    url = where,
    destfile = 'webpage.html',
    mode = 'wb',
    quiet = TRUE,
    extra = '--no-check-certificate'
  )
  file.names <- sub(
    'gz.*$',
    'gz',
    sub(
      '^.*href="',
      '',
      grep('txt.gz', readLines('webpage.html'), value = TRUE)
    )
  )

  for (source.file in file.names) {
    print(paste('Processing source file', mailing.list, source.file, sep = ' '))
    source.url <- paste(where, source.file, sep = '/')
    download(
      url = source.url,
      destfile = source.file,
      mode = 'wb',
      quiet = TRUE,
      extra = '--no-check-certificate'
    )
    email.corpus <- corpus.from.mbox(source.file)
    meta(email.corpus, tag = 'creator', type = 'corpus') <- '@znmeb'
    meta(email.corpus, tag = 'source.file', type = 'corpus') <- 
      paste(mailing.list, source.file, sep = '-')
    month <- sub(
      pattern = '.txt.gz$', replacement = '', 
      sub(pattern = '^.+-', replacement = '', source.file)
    )
    month.number <- sprintf('%02d', which(month.name == month))
    save.name <- sub(
      pattern = '.txt.gz$', replacement = '.corpus.rda',
      sub(pattern = month, replacement = month.number, source.file)
    )
    save(
      email.corpus,
      file = paste(mailing.list, save.name, sep = '-'),
      compress = 'xz'
    )
  }
  setwd('..')
}
setwd(here)
