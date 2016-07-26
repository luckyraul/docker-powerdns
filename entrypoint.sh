#!/bin/bash
set -e

export PARAMS="--daemon=no"
if [[ "x"$AXFR_IPS != "x" ]]; then
    export PARAMS="$PARAMS --allow-axfr-ips=$AXFR_IPS  --only-notify=$AXFR_IPS"
fi

# Run
exec /usr/sbin/pdns_server $PARAMS