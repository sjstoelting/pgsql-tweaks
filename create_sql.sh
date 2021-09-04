#!/bin/bash
# The script creates the SQL script to create the files needed for PGXN

# Copy the build.cfg.example to build.cfg and edit the configuration to match your nees
# Include the local configuration
source ./build.cfg

# Starts with the script to create all objects
# Define output file
EXTENSION=$(grep -m 1 '"name":' META.json | \
  sed -e 's/[[:space:]]*"name":[[:space:]]*"\([^"]*\)",/\1/')

EXTVERSION=$(grep -m 1 '"version":' META.json | \
  sed -e 's/[[:space:]]*"version":[[:space:]]*"\([^"]*\)",/\1/')

# Uninstall file with drop statements
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/sql/"
FILENAME="$DIR/$EXTENSION""_uninstall--$EXTVERSION.sql"

# Always start with an empty file
truncate -s 0 $FILENAME

echo '/*** uninstall file to drop all objects created by the extension pgsql_tweaks ***/' >> $FILENAME
echo '' >> $FILENAME

echo 'BEGIN;' >> $FILENAME
echo '' >> $FILENAME

echo 'DROP VIEW IF EXISTS pg_active_locks;' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_empty(s text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_sum(a BIGINT[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_sum(a INTEGER[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_sum(a SMALLINT[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_sum(a REAL[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_sum(a DOUBLE PRECISION[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_sum(a NUMERIC[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_avg(a BIGINT[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_avg(a INTEGER[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_avg(a SMALLINT[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_avg(a REAL[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_avg(a DOUBLE PRECISION[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_avg(a NUMERIC[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_min(a TEXT[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_min(a BIGINT[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_min(a INTEGER[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_min(a SMALLINT[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_min(a REAL[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_min(a DOUBLE PRECISION[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_min(a NUMERIC[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_max(a TEXT[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_max(a BIGINT[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_max(a INTEGER[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_max(a NUMERIC[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_max(a REAL[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_max(a DOUBLE PRECISION[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_max(a SMALLINT[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_trim(a text[], rd BOOLEAN);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_trim(a SMALLINT[], rd BOOLEAN);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_trim(a INTEGER[], rd BOOLEAN);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_trim(a BIGINT[], rd BOOLEAN);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_trim(a NUMERIC[], rd BOOLEAN);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_trim(a REAL[], rd BOOLEAN);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_trim(a DOUBLE PRECISION[], rd BOOLEAN);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_trim(a DATE[], rd BOOLEAN);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_trim(a TIMESTAMP[], rd BOOLEAN);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS array_trim(a TIMESTAMP WITH TIME ZONE[], rd BOOLEAN);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS to_unix_timestamp(ts timestamp with time zone);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS to_unix_timestamp(ts timestamp);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS datetime_de(t TIMESTAMP WITH TIME ZONE, with_tz BOOLEAN);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS date_de(d DATE);' >> $FILENAME
echo 'DROP AGGREGATE IF EXISTS gap_fill(anyelement);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS gap_fill_internal(s anyelement, v anyelement);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS replace_latin1(s text, s_search text[], s_replace text[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS replace_latin1(s text, replacement text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS replace_latin1(s text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS replace_encoding(s text, s_search text[], s_replace text[]);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS replace_encoding(s text, e text, replacement text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS replace_encoding(s text, e text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS return_not_part_of_encoding(s text, e text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS return_not_part_of_latin1(s text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_latin1(s text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_encoding(s text, enc text, enc_from text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_encoding(s text, enc text);' >> $FILENAME
echo 'DROP VIEW IF EXISTS pg_functions;' >> $FILENAME
echo 'DROP VIEW IF EXISTS pg_foreign_keys;' >> $FILENAME
echo 'DROP VIEW IF EXISTS pg_db_views;' >> $FILENAME
echo 'DROP VIEW IF EXISTS pg_table_matview_infos;' >> $FILENAME
echo 'DROP VIEW IF EXISTS pg_object_ownership;' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS pg_schema_size(text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS sha256(bytea);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_bigint(s text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_integer(s text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_smallint(s text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_numeric(s text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_real(s text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_double_precision(s text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_boolean(s text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_json(s text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_timestamp(s text, f text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_timestamp(s text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_time(s text, f text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_time(s text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_date(s text, f text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_json(s text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_jsonb(s text);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_hex(s TEXT);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS is_uuid(s TEXT);' >> $FILENAME
echo 'DROP FUNCTION IF EXISTS hex2bigint(s TEXT);' >> $FILENAME

echo '' >> $FILENAME
echo 'END;' >> $FILENAME

DROPFILE=$FILENAME


# Installation file
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/sql"
FILENAME="$DIR/$EXTENSION--$EXTVERSION.sql"

# Array with all file names
declare -a SQLFILES=(
  "function_is_date"
  "function_is_time"
  "function_is_timestamp"
  "function_is_numeric"
  "function_is_bigint"
  "function_is_integer"
  "function_is_smallint"
  "function_is_real"
  "function_is_double_precision"
  "function_is_boolean"
  "function_is_json"
  "function_is_jsonb"
  "function_is_uuid"
  "function_sha256"
  "function_pg_schema_size"
  "view_pg_db_views"
  "view_pg_foreign_keys"
  "view_pg_functions"
  "view_pg_table_matview_infos"
  "function_is_encoding"
  "function_is_latin1"
  "function_return_not_part_of_latin1"
  "function_replace_encoding"
  "function_replace_latin1"
  "function_return_not_part_of_encoding"
  "aggregate_function_gab_fill"
  "function_date_de"
  "function_datetime_de"
  "function_to_unix_timestamp"
  "function_is_empty"
  "function_array_max"
  "function_array_min"
  "function_array_avg"
  "function_array_sum"
  "function_array_trim"
  "view_pg_active_locks"
  "view_pg_object_ownership"
  "function_hex2bigint"
  "function_is_hex"
  )
arraylength=${#SQLFILES[@]}

# Always start with an empty file
truncate -s 0 $FILENAME

# Add licencse information
echo '/**' >> $FILENAME
echo ' * PostgreSQL pgsql_tweaks extension' >> $FILENAME
echo ' * Licence:    PostgreSQL Licence, see https://raw.githubusercontent.com/sjstoelting/pgsql-tweaks/master/LICENSE.md' >> $FILENAME
echo ' * Author:     Stefanie Janine Stölting <mail@stefanie-stoelting.de>' >> $FILENAME
echo ' * Repository: http://github.com/sjstoelting/pgsql_tweaks/' >> $FILENAME
echo ' * Version:    '$EXTVERSION >> $FILENAME
echo ' */' >> $FILENAME

# Add initial statements
echo '' >> $FILENAME
echo '/*** initial statements ***/' >> $FILENAME
echo 'SET client_min_messages TO warning;' >> $FILENAME
echo 'SET log_min_messages    TO warning;' >> $FILENAME
echo '' >> $FILENAME

# It is not allowed to drop functions in the script to create the extension
# cat $DROPFILE >> $FILENAME

echo '' >> $FILENAME
echo '/*** files with creation statements ***/' >> $FILENAME
echo '' >> $FILENAME

for (( i=1; i<${arraylength}+1; i++ ));
do
  cat $DIR/${SQLFILES[$i-1]}".sql" >> $FILENAME
  echo '' >> $FILENAME
done

# Now the test script has to be generated
# Define output file
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/test/sql/"
FILENAME="$DIR/$EXTENSION""_test--$EXTVERSION.sql"

# Always start with an empty file
truncate -s 0 $FILENAME

# Add initial statements
echo '\timing' >> $FILENAME
echo 'SET client_min_messages TO warning;' >> $FILENAME
echo 'SET log_min_messages    TO warning;' >> $FILENAME
echo '' >> $FILENAME

echo '/*** files with test statements ***/' >> $FILENAME
echo '' >> $FILENAME

for (( i=1; i<${arraylength}+1; i++ ));
do
  echo "SELECT 'Test starting: ${SQLFILES[$i-1]}' AS next_test;"  >> $FILENAME
  cat $DIR/${SQLFILES[$i-1]}".sql" >> $FILENAME
  echo '' >> $FILENAME
done


# Create control file
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FILENAME="$DIR/pgsql_tweaks.control"

# Always start with an empty file
truncate -s 0 $FILENAME

# Control data
echo "# pgsql_tweaks extension" >> $FILENAME
echo "comment = 'Some functions and views for daily usage'" >> $FILENAME
echo "default_version = '$EXTVERSION'" >> $FILENAME
echo "module_pathname = '\$libdir/pgsql_tweaks'" >> $FILENAME
echo "relocatable = true" >> $FILENAME

# Create the test data
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

psql -h $DBHOST -p $DBPORT -X -q -b postgres -c "CREATE DATABASE $DBNAME;"

psql -h $DBHOST -p $DBPORT -X -q -b -v ON_ERROR_STOP=1 $DBNAME -c "SELECT version ();"

psql -h $DBHOST -p $DBPORT -X -q -b -v ON_ERROR_STOP=1 $DBNAME -f $DIR/sql/pgsql_tweaks--$EXTVERSION.sql

psql -h $DBHOST -p $DBPORT -X -q -b -v ON_ERROR_STOP=1 $DBNAME -f $DIR/test/sql/pgsql_tweaks_test--$EXTVERSION.sql > $DIR/test/sql/pgsql_tweaks_test--$EXTVERSION.out

psql -h $DBHOST -p $DBPORT -X -q -b postgres -c "DROP DATABASE $DBNAME;"


# Create a documentation  for PGXN, the link differ from GitHun to PGXN
./create_pgxn_doc.sh

# Create a documentation in HTML
./create_html_doc.sh

# Create the PGXN package, output path is users tmp
git archive --format zip --prefix=pgsql-tweaks-$EXTVERSION/ --output ~/tmp/pgsql-tweaks-$EXTVERSION.zip main

# Unset variables
unset DIR
unset FILENAME
unset i
unset arraylength
