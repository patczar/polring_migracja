#!/bin/bash

pg_dump -h localhost -p 65433 -d laravel -U laravel --schema-only --schema=public --format=plain --file=../new_schema/laravel.sql

pg_dump -h localhost -p 65433 -d laravel -U laravel -j 2 --schema=public --format=directory --file=../data/new
