library(downloader)
library(tm)
library(tm.plugin.mail)
dir.create(path = '~/Downloads/RMailingLists', recursive = TRUE, mode = '0755')
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

    # now make and save a corpus!
    directory <- sub('.txt.gz', '', source.file, fixed=TRUE)

    convert_mbox_eml(
      source.file,
      directory
    )

    email.corpus <- VCorpus(
      DirSource(directory),
      readerControl = list(
        reader = readMail,
        load = TRUE
      )
    )

    save(
      email.corpus,
      file = paste(
        directory,
        '.corpus.rda',
        sep=''
      ),
      compress = 'xz'
    )

  }

  setwd('..')
}

setwd(here)
