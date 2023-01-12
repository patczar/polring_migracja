#!/bin/bash

pg_restore -h localhost -d polring -U polring -j 4 --format=directory -O --no-privileges ../data/old
