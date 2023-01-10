#!/bin/bash

pg_dump -h localhost -p 65432 -d postgres -U postgres --schema-only --schema=dbo --format=plain --file=../old_schema/dbo.sql

pg_dump -h localhost -p 65432 -d postgres -U postgres -j 2 --schema=dbo --format=directory --file=../data/old
