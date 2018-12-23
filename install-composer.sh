#!/bin/sh

EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
php -r "copy('https://getcomposer.org/installer', '$1/bin/composer-setup.php');"
ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', '$1/bin/composer-setup.php');")

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature'
    rm $1/bin/composer-setup.php
    exit 1
fi

php $1/bin/composer-setup.php --install-dir=$1/bin --filename=composer
RESULT=$?
rm $1/bin/composer-setup.php
exit $RESULT