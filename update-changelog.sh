#!/bin/bash
changelog=changelog.md
version=$2

# If no from version is given then used the first version found in the current changelog
if [ -z $1 ]; then
  last=`cat changelog.md | sed -e '1!d;s/ .*//g'`
else
  last=$1
fi

# If no version is give then pull it from package.json
if [ -z $2 ]; then
  version=v`node -e 'console.log(require("./package.json").version)'`
fi

# If version not found set to the first commit
[ -z $last ] && last=`git rev-list HEAD | tail -n 1`

echo Adding changelog from $last to $version...

# Exit if the changelog is up to date
if [ "$last" = "$version" ]; then
  echo Nothing to do
  exit 1
fi

rm -f $changelog.tmp
header="$version / `date`"
echo $header > $changelog.tmp
for i in `seq 1 ${#header}`; do
  echo -n = >> $changelog.tmp
done
echo >> $changelog.tmp

(git log HEAD~10..HEAD --no-merges --format='* %s' | egrep -v '^\* (>|\d)' | sort -u | sed -e 's/\[PT #\(.*\)]/[PT \1](https:\/\/www.pivotaltracker.com\/story\/show\/\1)/' | sed -e 's/\[FD #\(.*\)]/[FD \1](https:\/\/clocklimited.freshdesk.com\/helpdesk\/tickets\/\1)/' ; echo '' ; cat $changelog)  >> $changelog.tmp

mv $changelog.tmp $changelog
