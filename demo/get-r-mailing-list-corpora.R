library(downloader)
library(email.mining.for.journos)
unlink('~/Downloads/RMailingLists', recursive = TRUE, force = TRUE)
dir.create(path = '~/Downloads/RMailingLists', recursive = TRUE)
here <- setwd('~/Downloads/RMailingLists')
for (mailing.list in c('r-devel', 'r-help')) {
  dir.create(path = mailing.list)
  setwd(mailing.list)
  where <- paste('https://stat.ethz.ch/pipermail', mailing.list, sep = '/')
  download(
    url = where,
    destfile = 'webpage.html',
    mode = 'wb',
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
    source.url <- paste(where, source.file, sep = '/')
    download(
      url = source.url,
      destfile = source.file,
      mode = 'wb',
      extra = '--no-check-certificate'
    )
    email.corpus <- corpus.from.mbox(source.file)
    save(
      email.corpus,
      file = sub('txt.gz', 'corpus.rda', source.file),
      compress = 'xz'
    )
  }
  setwd('..')
}
setwd(here)
