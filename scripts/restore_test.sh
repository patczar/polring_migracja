#!/bin/bash

pg_restore -h localhost -d polring -U polring --format=directory -O --no-privileges ../data/new
