#!/bin/sh
set -e

#if [[ "$1" != "prosody" ]]; then
#    exec prosodyctl $*
#    exit 0;
#fi

if [ "$LOCAL" -a  "$PASSWORD" -a "$DOMAIN" -a ! -f /var/lib/prosody/.local ] ; then
    sed -i "s/example.com/${DOMAIN}/" /etc/prosody/prosody.cfg.lua
    sed -i "s/specialadminuser@/${LOCAL}@/" /etc/prosody/prosody.cfg.lua
    prosodyctl register $LOCAL $DOMAIN $PASSWORD
    touch /var/lib/prosody/.local
fi

exec "$@"
