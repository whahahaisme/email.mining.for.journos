#! /bin/bash
#
# Copyright (C) 2012 by M. Edward (Ed) Borasky
#
# This program is licensed to you under the terms of version 3 of the
# GNU Affero General Public License. This program is distributed WITHOUT
# ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING THOSE OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Please refer to the
# AGPL (http://www.gnu.org/licenses/agpl-3.0.txt) for more details.
#

export WHERE="https://stat.ethz.ch/pipermail/r-devel"
export FILES=`curl -s ${WHERE}/|grep 'txt.gz'|sed 's/^.*href="//'|sed 's/".*$//'`
mkdir -p r-devel
pushd r-devel
for i in ${FILES}
do
  wget -nc ${WHERE}/${i}
done
popd

export WHERE="https://stat.ethz.ch/pipermail/r-help"
export FILES=`curl -s ${WHERE}/|grep 'txt.gz'|sed 's/^.*href="//'|sed 's/".*$//'`
mkdir -p r-help
pushd r-help
for i in ${FILES}
do
  wget -nc ${WHERE}/${i}
done
popd
