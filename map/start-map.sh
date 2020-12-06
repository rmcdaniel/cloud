#!/bin/bash
python mr_mapworker.py $MASTER_SERVICE_HOST $MASTER_SERVICE_PORT
tail -f /dev/null
