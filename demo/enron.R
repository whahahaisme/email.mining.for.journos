enron <- Corpus(
  DirSource('/home/Email/enron/enron_mail_20110402/maildir/skilling-j/sent'),
  readerControl = list(
    reader = readMail,
    language = "en_US",
    load = TRUE
  )
)

# to do
# 1. Flatten directory structure
# 2. dos2unix all
# 3. fix missing EOLs
