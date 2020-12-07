#!/bin/bash
python mr_plugdata.py -i 10 -p $MASTER_SERVICE_PORT -M $MAP_WORKER_COUNT -R $REDUCE_WORKER_COUNT data.csv
tail -f /dev/null
