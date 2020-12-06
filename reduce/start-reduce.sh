#!/bin/bash
python mr_reduceworker.py $MASTER_SERVICE_HOST $MASTER_SERVICE_PORT
tail -f /dev/null
