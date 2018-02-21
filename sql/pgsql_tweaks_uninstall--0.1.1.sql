SET client_min_messages TO warning;
SET log_min_messages    TO warning;

/*** uninstall file to drop all objects created by the extension pgsql_tweaks ***/

BEGIN;

DROP VIEW IF EXISTS pg_active_locks;
DROP FUNCTION IF EXISTS is_empty(s VARCHAR);
DROP FUNCTION IF EXISTS array_sum(a BIGINT[]);
DROP FUNCTION IF EXISTS array_sum(a INTEGER[]);
DROP FUNCTION IF EXISTS array_sum(a SMALLINT[]);
DROP FUNCTION IF EXISTS array_avg(a BIGINT[]);
DROP FUNCTION IF EXISTS array_avg(a INTEGER[]);
DROP FUNCTION IF EXISTS array_avg(a SMALLINT[]);
DROP FUNCTION IF EXISTS array_min(a TEXT[]);
DROP FUNCTION IF EXISTS array_min(a BIGINT[]);
DROP FUNCTION IF EXISTS array_min(a INTEGER[]);
DROP FUNCTION IF EXISTS array_min(a SMALLINT[]);
DROP FUNCTION IF EXISTS array_max(a TEXT[]);
DROP FUNCTION IF EXISTS array_max(a BIGINT[]);
DROP FUNCTION IF EXISTS array_max(a INTEGER[]);
DROP FUNCTION IF EXISTS array_max(a SMALLINT[]);
DROP FUNCTION IF EXISTS to_unix_timestamp(ts timestamp with time zone);
DROP FUNCTION IF EXISTS to_unix_timestamp(ts timestamp);
DROP FUNCTION IF EXISTS datetime_de(t TIMESTAMP WITH TIME ZONE, with_tz BOOLEAN);
DROP FUNCTION IF EXISTS date_de(d DATE);
DROP AGGREGATE IF EXISTS gap_fill(anyelement);
DROP FUNCTION IF EXISTS gap_fill_internal(s anyelement, v anyelement);
DROP FUNCTION IF EXISTS replace_latin1(s VARCHAR, s_search VARCHAR[], s_replace VARCHAR[]);
DROP FUNCTION IF EXISTS replace_latin1(s VARCHAR, replacement VARCHAR);
DROP FUNCTION IF EXISTS replace_latin1(s VARCHAR);
DROP FUNCTION IF EXISTS replace_encoding(s VARCHAR, s_search VARCHAR[], s_replace VARCHAR[]);
DROP FUNCTION IF EXISTS replace_encoding(s VARCHAR, e VARCHAR, replacement VARCHAR);
DROP FUNCTION IF EXISTS replace_encoding(s VARCHAR, e VARCHAR);
DROP FUNCTION IF EXISTS return_not_part_of_encoding(s VARCHAR, e VARCHAR);
DROP FUNCTION IF EXISTS return_not_part_of_latin1(s VARCHAR);
DROP FUNCTION IF EXISTS is_latin1(s VARCHAR);
DROP FUNCTION IF EXISTS is_encoding(s VARCHAR, enc VARCHAR, enc_from VARCHAR);
DROP FUNCTION IF EXISTS is_encoding(s VARCHAR, enc VARCHAR);
DROP VIEW IF EXISTS pg_functions;
DROP VIEW IF EXISTS pg_foreign_keys;
DROP VIEW IF EXISTS pg_db_views;
DROP FUNCTION IF EXISTS pg_schema_size(text);
DROP FUNCTION IF EXISTS sha256(bytea);
DROP FUNCTION IF EXISTS is_integer(s VARCHAR);
DROP FUNCTION IF EXISTS is_numeric(s VARCHAR);
DROP FUNCTION IF EXISTS is_timestamp(s VARCHAR, f VARCHAR);
DROP FUNCTION IF EXISTS is_timestamp(s VARCHAR);
DROP FUNCTION IF EXISTS is_time(s VARCHAR, f VARCHAR);
DROP FUNCTION IF EXISTS is_time(s VARCHAR);
DROP FUNCTION IF EXISTS is_date(s VARCHAR, f VARCHAR);
DROP FUNCTION IF EXISTS is_date(s VARCHAR);

END;
