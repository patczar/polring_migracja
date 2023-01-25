#!/bin/bash

# podłączenie jako admin:
# psql -h localhost -p 65436 -d polring_tmp -U polring

# jako admin: wyczyszczenie i przygotowanie nowej bazy oraz usera laravel
psql -h localhost -p 65436 -d polring_tmp -U polring < prepare_fresh_database.sql

pg_restore -h localhost -p 65436 -d laravel -U laravel --format=directory -O --no-privileges ../data/local
