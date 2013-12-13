#! /usr/bin/perl -w
#
# Copyright (C) 2012 by M. Edward (Ed) Borasky
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http://www.gnu.org/licenses/agpl-3.0.txt) for more details.
#

# make a directory
my $datadir = "/home/Email/enron";
system "mkdir -p ${datadir}";
chdir "${datadir}";

# name of unpacked tarball directory
my $directory = "enron_mail_20110402";
my $tarball = "http://download.srv.cs.cmu.edu/~enron/${directory}.tgz";

# download the tarball if we don't have it yet
system "wget -nc ${tarball}";

# get a clean directory of raw messages
print "unpacking tarball\n";
system "rm -fr ${directory}; tar xf enron*tgz";

# now "flatten" the directory structure to a single directory
print "collecting messages\n";
my @messagelines = `grep -m 1 -r -e 'Message-ID:' ${directory}/maildir`;

# now we have an array of message ID lines of the form
# <filename>:Message-ID: <message-ID>
my $messagecount = 0; # counter
my $destination = "${directory}/flattened"; # where to put the messages
system "rm -fr ${destination}; mkdir -p ${destination}";

# to save space, use symbolic links!
while (my $messageline = shift @messagelines) {
  next if $messageline !~ /\/inbox\//; # just use the 'Inbox' messages!
  chomp $messageline; 

  # make a reasonable file name from the message ID
  $messageline =~ s/<//;
  $messageline =~ s/\@/.at./;
  $messageline =~ s/>.*$//; 
  my ($filename, $messageid) = split /:Message-ID: /, $messageline;
  if (!defined $messageid) {
    print "${messageline}\n";
  }
  else {
    system "ln -sf ${datadir}/${filename} \'${destination}/${messageid}\'";
  }
  $messagecount += 1;
  print "${messagecount} messages processed\n" if $messagecount % 5000 == 0;
}

exit;
