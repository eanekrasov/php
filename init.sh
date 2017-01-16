#!/bin/sh

# Script options (exit script on command fail).
set -e

# Define default Variables.
USER="www-data"
GROUP="www-data"
PHP_UID_DEFAULT="1000"
PHP_GID_DEFAULT="1000"
COMMAND="${COMMAND:-php-fpm}"

PHP_UID_ACTUAL=$(id -u ${USER})
PHP_GID_ACTUAL=$(id -g ${GROUP})

# Display settings on standard out.
echo "php settings"
echo "============"
echo
echo "  Username:        ${USER}"
echo "  Groupname:       ${GROUP}"
echo "  UID actual:      ${PHP_UID_ACTUAL}"
echo "  GID actual:      ${PHP_GID_ACTUAL}"
echo "  UID prefered:    ${PHP_UID:=${PHP_UID_DEFAULT}}"
echo "  GID prefered:    ${PHP_GID:=${PHP_GID_DEFAULT}}"
echo "  Command:         ${COMMAND}"
echo

# Change UID / GID of PHP user.
if [[ ${PHP_GID_ACTUAL} -ne ${PHP_GID} -o ${PHP_UID_ACTUAL} -ne ${PHP_UID} ]]
then
    echo "Updating UID / GID... "
    echo "change user / group"
    deluser ${USER}
    addgroup -g ${PHP_GID} ${GROUP}
    adduser -u ${PHP_UID} -G ${GROUP} -h /app -g 'PHP User' -s /sbin/nologin -D ${USER}
    echo "[DONE]"
fi

echo "Start ${COMMAND}... "
exec ${COMMAND}
