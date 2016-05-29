#!/bin/sh
set -e

#if [[ "$1" != "prosody" ]]; then
#    exec prosodyctl $*
#    exit 0;
#fi

if [ "$LOCAL" -a  "$PASSWORD" -a "$DOMAIN" ] ; then
    sed -i "s/example.com/${DOMAIN}/" /etc/prosody/prosody.cfg.lua
    sed -i "s/admins = { }/admins = { $LOCAL@${DOMAIN} }/" /etc/prosody/prosody.cfg.lua
    prosodyctl register $LOCAL $DOMAIN $PASSWORD
fi

exec "$@"
