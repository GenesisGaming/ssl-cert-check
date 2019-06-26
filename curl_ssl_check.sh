#!/bin/bash
# Uses Curl to do a simple verification of SSL certificates for the endpoint
VERSION=0.1


# hostname:port pair for the endpoint. i.e., ugc.star888ad.com:443
endpoint=${1}
# host:port pair to actually connect to. i.e., ugc.star0ad.com.cdnle.com:443
host=${2}


appname=`basename $0`
curl_opts="-s -o /dev/null"

if [ -z "$endpoint" ]
then
    echo "ERROR: please provide an endpoint." >&2
    echo -e "$appname hostname:port [host:port]\n" >&2
    exit 1
fi

if [ ! -z "$host" ]
then
    curl_ct="--connect-to $endpoint:$host"
    log_host="host:$host"
fi

xdate=`date +%FT%T`
if curl $curl_opts  $curl_ct  https://$endpoint
then
    echo -e "INFO: $xdate All good. Checked endpoint:$endpoint $log_host" >&2
else
    echo -e "ERROR: $xdate Something went wrong. Checked endpoint:$endpoint $log_host" >&2
    exit 1
fi

