#!/bin/bash -e

TEST_FILES=$(/bin/grep '^au' ftdetect/polyglot.vim \
    | /bin/grep -E '\b(setfiletype|filetype|setf|ft)\b' \
    | /usr/bin/awk '{print $3}' \
    | /bin/grep -v / \
    | /bin/sed -E -e 's/\[(.).+\]/\1/g' -e 's/\{([^,]+),[^}]+\}/\1/g' -e 's/\*/test/g' \
    | /usr/bin/tr , '\n' \
    | /bin/grep -iE '^[a-z\.]+$' \
    | /usr/bin/sort -u)

stty rows 5
for f in $TEST_FILES;
do
    echo should parse $f file >&2
    touch /tmp/$f
    /usr/bin/vim -n -c "set t_te=" -c "set t_ti=" -c "set rtp^=$(pwd)" -s test/test.vimscript /tmp/$f <`tty`>`tty`
done
