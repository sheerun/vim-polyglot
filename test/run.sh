#!/bin/bash -e

VIM="/usr/bin/vim -c 'setrtp^=$(pwd)' -s test/test.vimscript"

TEST_FILES=$(/bin/grep '^au' ftdetect/polyglot.vim \
    | /bin/grep -E '\b(setfiletype|filetype|setf|ft)\b' \
    | /usr/bin/awk '{print $3}' \
    | /bin/grep -v / \
    | /bin/sed -E -e 's/\[(.).+\]/\1/g' -e 's/\{([^,]+),[^}]+\}/\1/g' -e 's/\*/test/g' \
    | /usr/bin/tr , '\n' \
    | /bin/grep -iE '^[a-z\.]+$' \
    | /usr/bin/sort -u)

for f in $TEST_FILES;
do
    echo should parse $f file
    touch /tmp/$f
    $VIM /tmp/$f > /dev/null
done
