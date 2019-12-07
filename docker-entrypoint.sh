#!/bin/sh
set -e

if [ "$1" = 'indimail' ]; then
    exec /usr/sbin/svscan "$@"
fi

exec "$@"
