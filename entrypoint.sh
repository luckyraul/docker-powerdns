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
    echo "$SUPERMASTER_1 ns1" > /etc/powerdns/supermasters.conf

    if [[ "x"$SUPERMASTER_2 != "x" ]]; then
        echo "$SUPERMASTER_2 ns2" >> /etc/powerdns/supermasters.conf
    fi

    if [[ "x"$SUPERMASTER_3 != "x" ]]; then
        echo "$SUPERMASTER_3 ns3" >> /etc/powerdns/supermasters.conf
    fi

    if [[ "x"$SUPERMASTER_4 != "x" ]]; then
        echo "$SUPERMASTER_4 ns4" >> /etc/powerdns/supermasters.conf
    fi
fi

# Run
exec /usr/sbin/pdns_server $PARAMS
