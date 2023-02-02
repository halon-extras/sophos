#!/bin/sh

/opt/savdid/bin/update.sh https://sophos.halon.io/1/XXXXXXXXXX > /var/log/savdid-update.log 2>&1

status=$?

if [ $status -eq 2 ]; then
    # An exit status of 2 means that an update was available which requires the service to restart
    supervisorctl restart savdid
    exit 0
fi

exit $status
