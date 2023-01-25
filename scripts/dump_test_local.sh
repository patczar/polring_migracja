#!/bin/bash

rm -rf ../data/local

pg_dump -h localhost -p 5432 -d polring -U polring -j 4 --schema=public --format=directory --file=../data/local
