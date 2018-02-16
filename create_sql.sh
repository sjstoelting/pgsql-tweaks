#!/bin/bash
# The script creates the SQL script to create the files needed for PGXN

# Starts with the script to create all objects
# Define output file
EXTENSION=$(grep -m 1 '"name":' META.json | \
  sed -e 's/[[:space:]]*"name":[[:space:]]*"\([^"]*\)",/\1/')

EXTVERSION=$(grep -m 1 '"version":' META.json | \
  sed -e 's/[[:space:]]*"version":[[:space:]]*"\([^"]*\)",/\1/')

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/sql/"
FILENAME="$DIR/$EXTENSION--$EXTVERSION.sql"

# Array with all file names
declare -a SQLFILES=(
  "function_is_date"
  "function_is_time"
  "function_is_timestamp"
  "function_is_numeric"
  "function_is_integer"
  "function_sha256"
  "function_pg_schema_size"
  "view_pg_db_views"
  "view_pg_foreign_keys"
  "view_pg_functions"
  "function_is_encoding"
  "function_is_latin1"
  "function_return_not_part_of_latin1"
  "function_replace_latin1"
  "function_return_not_part_of_encoding"
  "aggregate_function_gab_fill"
  "function_date_de"
  "function_datetime_de"
  "function_to_unix_timestamp"
  "function_is_empty"
  )
arraylength=${#SQLFILES[@]}

# Always start with an empty file
truncate -s 0 $FILENAME

# Add initial statements
echo '/*** initial statements ***/' >> $FILENAME
echo 'SET client_min_messages TO warning;' >> $FILENAME
echo 'SET log_min_messages    TO warning;' >> $FILENAME
echo '' >> $FILENAME


echo '/*** files with creation statements ***/' >> $FILENAME
echo '' >> $FILENAME

for (( i=1; i<${arraylength}+1; i++ ));
do
  cat $DIR${SQLFILES[$i-1]}".sql" >> $FILENAME
  echo '' >> $FILENAME
done


# Now the test script has to be generated
# Define output file
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/test/sql/"
FILENAME="$DIR/pgsql_tweaks_tests.sql"

# Always start with an empty file
truncate -s 0 $FILENAME

# Add initial statements
echo 'SET client_min_messages TO warning;' >> $FILENAME
echo 'SET log_min_messages    TO warning;' >> $FILENAME
echo '' >> $FILENAME

echo '/*** files with test statements ***/' >> $FILENAME
echo '' >> $FILENAME

for (( i=1; i<${arraylength}+1; i++ ));
do
  cat $DIR${SQLFILES[$i-1]}".sql" >> $FILENAME
  echo '' >> $FILENAME
done


# Uninstall file with drop statements
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/sql/"
FILENAME="$DIR/pgsql_tweaks_uninstall.sql"

# Always start with an empty file
truncate -s 0 $FILENAME

# Add initial statements
echo 'SET client_min_messages TO warning;' >> $FILENAME
echo 'SET log_min_messages    TO warning;' >> $FILENAME
echo '' >> $FILENAME

echo '/*** uninstall file to drop all objects created by the extension pgsql_tweaks ***/' >> $FILENAME
echo '' >> $FILENAME

echo 'BEGIN;' >> $FILENAME
echo '' >> $FILENAME

echo 'DROP FUNCTION IF EXISTS to_unix_timestamp(ts timestamp with time zone);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS to_unix_timestamp(ts timestamp);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS datetime_de(t TIMESTAMP WITH TIME ZONE, with_tz BOOLEAN);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS date_de(d DATE);' >> $FILENAME
echo 'DROP AGGREGATE IF EXISTS gap_fill(anyelement);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS gap_fill_internal(s anyelement, v anyelement);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS replace_encoding(s VARCHAR, s_search VARCHAR[], s_replace VARCHAR[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS replace_encoding(s VARCHAR, e VARCHAR, replacement VARCHAR);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS replace_encoding(s VARCHAR, e VARCHAR);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS return_not_part_of_encoding(s VARCHAR, e VARCHAR);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS replace_latin1(s VARCHAR, s_search VARCHAR[], s_replace VARCHAR[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS replace_latin1(s VARCHAR, replacement VARCHAR);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS replace_latin1(s VARCHAR);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS return_not_part_of_latin1(s VARCHAR);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_latin1(s VARCHAR);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_encoding(s VARCHAR, enc VARCHAR, enc_from VARCHAR);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_encoding(s VARCHAR, enc VARCHAR);' >> $FILENAME
echo 'DROP VIEW IF EXISTS pg_functions;' >> $FILENAME
echo 'DROP VIEW IF EXISTS pg_foreign_keys;' >> $FILENAME
echo 'DROP VIEW IF EXISTS pg_db_views;' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS pg_schema_size(text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS sha256(bytea);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_integer(s VARCHAR);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_numeric(s VARCHAR);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_timestamp(s VARCHAR, f VARCHAR);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_timestamp(s VARCHAR);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_time(s VARCHAR, f VARCHAR);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_time(s VARCHAR);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_date(s VARCHAR, f VARCHAR);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_date(s VARCHAR);' >> $FILENAME

echo '' >> $FILENAME
echo 'END;' >> $FILENAME

# Unset variables
unset DIR
unset FILENAME
unset i
unset arraylength
