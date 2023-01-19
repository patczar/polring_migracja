#!/bin/bash

rm ../schema/new_schema.sql

pg_dump -h localhost -p 65433 -d laravel -U laravel --schema-only --schema=public --format=plain --file=../schema/new_schema.sql

rm -r ../data/new

pg_dump -h localhost -p 65433 -d laravel -U laravel -j 2 --schema=public --format=directory --file=../data/new
