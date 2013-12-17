Email Mining for Journalists
========================================================
author: M. Edward (Ed) Borasky
date: December 17, 2013
autosize: true
transition: none




Text Mining 101
========================================================
type: section

Corpora
========================================================
type: prompt
incremental: true

- A _corpus_ (plural _corpora_) is a collection of documents
- In the _tm_ package, there are two types of corpora
  - _Volatile_: Resides in RAM (but can be saved to and restored from disk!)
  - _Permanent_: Resides on disk with only some indexing in RAM

Typical Text Cleaning Operations
========================================================
type: prompt
incremental: true

- Remove Non-ASCII characters
- Remove numbers
- Consolidate whitespace
- Remove punctuation
- Convert to all lower case
- *Can be done in almost any programming language via regular expressions*

Stemming
========================================================
type: prompt
incremental: true

- Replace variations on a word with its _stem_
- Most often done using an algorithm called the _Porter Stemmer_
- You'll also see the term _Snowball_ - that's the implemented version
  - Example: replace "stem", "stemmer", "stemming", "stemmed" with "stem".

Stopwords
========================================================
type: prompt
incremental: true

- Frequently occurring words with little semantic value
  - Examples: a, an, and, or, this, ...
- Stopword removal cuts down the dataset size and run time
- Defining stopwords depends on what's in the corpus
  - Usually start with a predefined set and add more stopwords

Text Mining 102
========================================================
type: section

Bag of Words
========================================================
type: prompt
incremental: true

- A document is treated as a _bag of words_
- After you've cleaned a document you have a _bag_
  - aka _multiset_ - like a set but can have more than one copy of an element
  - like a set, _order doesn't matter_
- Of _words_ - we got rid of the numbers, punctuation, etc.
  - we probably stemmed and maybe removed stopwords
- In the literature, you'll hear the words called _terms_ or _types_

Document-Term Matrix
========================================================
type: prompt
incremental: true

- We have some _documents_ in our corpus - bags of words
- We'll call the words _terms_
- Make a matrix - a spreadsheet
  - The row labels are documents
  - The column labels are terms
- That's a _document-term matrix_

Ah, But What's in the Cells?
========================================================
type: prompt
incremental: true

- Numbers!
- Three common options
  1. _One_ if the term occurs in the document, _zero_ if it doesn't
  2. The number of times the term occurs in the document
  3. A mathematical function of the number of times the term occurs in the _document_ and _corpus_

The Document-Term Matrix is Sparse
========================================================
type: prompt
incremental: true

- Most of the numbers are zero
- So usually you only have to store triples
  - (document index, term index, non-zero value)

What Can You Do With a Matrix?
========================================================
type: prompt
incremental: true

- Computational linear algebra, of course!
- Most text mining algorithms are based on linear algebra / vector spaces
- Programming language choices
  - R and Python both have good libraries for this
  - The hard stuff is usually done via C/C++
  - A lot of Java code out there too
  

Wait - You Mangled the Documents - How Can This Possibly Work?
========================================================
type: prompt
incremental: true

- It works surprisingly well, actually
- The tricky part is visualizing the multi-dimensional objects
- See <a href="http://www.amazon.com/Handbook-Semantic-University-Institute-Cognitive-ebook/dp/B00CXU38Z4">Landauer et al. (2007)</a>  for some of the math and applications

One Final Note
========================================================
type: prompt
incremental: true

- The _transpose_ of a document-term matrix is called ... wait for it ...
  - A _term-document matrix!_
  - You'll see both in the literature
  - We'll stick with document-term matrix
  - That's the way R Commander's text mining code works

Tools - R Commander and RcmdrPlugin.temis
========================================================
type: section

R Commander
========================================================
type: prompt
incremental: true


- R Commander (<a href="http://www.jstatsoft.org/v14/i09">Fox, 2005</a> ) is a general purpose GUI for R
- Most common packaged analyses are available
- Can generate reports and web pages
- _Can save a script of the processing for documentation or later execution!_
- Wide range of plugins, including ...

RcmdrPlugin.temis
========================================================
type: prompt
incremental: true


-  <a href="http://journal.r-project.org/archive/2013-1/bouchetvalat-bastin.pdf">Bouchet-Valat & Bastin (2013)</a> : adds basic and advanced text mining functions
- Plan of attack
  1. Get some data - 2006 R-devel mailing list, to be precise (<a href="http://journal.r-project.org/archive/2011-1/RJournal_2011-1_Bohn~et~al.pdf">Feinerer et al. 2011</a> ; <a href="http://www.jstatsoft.org/v25/i05/">Feinerer et al. 2008</a>  )
  2. Unpack to a flat directory - each message is a single file
  3. Build a corpus and document-term matrix
  4. Save the script and package it

Demo
========================================================
type: section

Road Map
========================================================
type: section

Coming Soon To a Github Repo Near You!
========================================================
type: prompt
incremental: true

- Explore the text mining algorithms in RcmdrPlugin.temis
- Add social network analysis via package _snatm_ (<a href="http://journal.r-project.org/archive/2011-1/RJournal_2011-1_Bohn~et~al.pdf">Feinerer et al. 2011</a> )
- Add functionality to the package with journalism uses in mind
- Port the Bash and Perl pieces to R so the package will run on Windows
- ???
- Profit!

References
==========
type: prompt

<small>

- Ingo Feinerer, Kurt Bohn, Patrick Mair,   (2011) Content-Based Social Network Analysis
of Mailing Lists.  [http://journal.r-project.org/archive/2011-1/RJournal_2011-1_Bohn~et~al.pdf](http://journal.r-project.org/archive/2011-1/RJournal_2011-1_Bohn~et~al.pdf)
- Milan Bouchet-Valat, Gilles Bastin,   (2013) RcmdrPlugin.temis, a Graphical Integrated Text Mining Solution in R.  [http://journal.r-project.org/archive/2013-1/bouchetvalat-bastin.pdf](http://journal.r-project.org/archive/2013-1/bouchetvalat-bastin.pdf)
- Ingo Feinerer, Kurt Hornik, David Meyer,   (2008) Text Mining Infrastructure in R.  [http://www.jstatsoft.org/v25/i05/](http://www.jstatsoft.org/v25/i05/)
- John Fox,   (2005) The R Commander: A Basic Statistics Graphical User Interface to R.  [http://www.jstatsoft.org/v14/i09](http://www.jstatsoft.org/v14/i09)
- Thomas Landauer, Danielle McNamara, Simon Dennis, Walter Kintsch,   (2007) Handbook of Latent Semantic Analysis.  [http://www.amazon.com/Handbook-Semantic-University-Institute-Cognitive-ebook/dp/B00CXU38Z4](http://www.amazon.com/Handbook-Semantic-University-Institute-Cognitive-ebook/dp/B00CXU38Z4)

</small>
