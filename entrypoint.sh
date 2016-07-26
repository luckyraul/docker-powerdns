#!/bin/bash
set -e

export PARAMS="--daemon=no"
if [[ "x"$AXFR_IPS != "x" ]]; then
    export PARAMS="$PARAMS --allow-axfr-ips=$AXFR_IPS  --only-notify=$AXFR_IPS"
fi

if [[ "x"$MODE_SLAVE != "x" && "x"$MODE_BIND != "x" ]]; then
    touch /var/lib/powerdns/named-superslave.conf
    chown -R pdns:pdns /var/lib/powerdns
    echo "options {
    directory \"/var/lib/powerdns\";
};
include \"named-superslave.conf\";
    " >> /etc/powerdns/bindbackend.conf
fi

# Run
exec /usr/sbin/pdns_server $PARAMS