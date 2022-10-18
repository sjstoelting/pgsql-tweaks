/*** uninstall file to drop all objects created by the extension pgsql_tweaks ***/

BEGIN;

DROP VIEW IF EXISTS pg_active_locks;
DROP FUNCTION IF EXISTS is_empty(s text);
DROP FUNCTION IF EXISTS array_sum(a BIGINT[]);
DROP FUNCTION IF EXISTS array_sum(a INTEGER[]);
DROP FUNCTION IF EXISTS array_sum(a SMALLINT[]);
DROP FUNCTION IF EXISTS array_sum(a REAL[]);
DROP FUNCTION IF EXISTS array_sum(a DOUBLE PRECISION[]);
DROP FUNCTION IF EXISTS array_sum(a NUMERIC[]);
DROP FUNCTION IF EXISTS array_avg(a BIGINT[]);
DROP FUNCTION IF EXISTS array_avg(a INTEGER[]);
DROP FUNCTION IF EXISTS array_avg(a SMALLINT[]);
DROP FUNCTION IF EXISTS array_avg(a REAL[]);
DROP FUNCTION IF EXISTS array_avg(a DOUBLE PRECISION[]);
DROP FUNCTION IF EXISTS array_avg(a NUMERIC[]);
DROP FUNCTION IF EXISTS array_min(a TEXT[]);
DROP FUNCTION IF EXISTS array_min(a BIGINT[]);
DROP FUNCTION IF EXISTS array_min(a INTEGER[]);
DROP FUNCTION IF EXISTS array_min(a SMALLINT[]);
DROP FUNCTION IF EXISTS array_min(a REAL[]);
DROP FUNCTION IF EXISTS array_min(a DOUBLE PRECISION[]);
DROP FUNCTION IF EXISTS array_min(a NUMERIC[]);
DROP FUNCTION IF EXISTS array_max(a TEXT[]);
DROP FUNCTION IF EXISTS array_max(a BIGINT[]);
DROP FUNCTION IF EXISTS array_max(a INTEGER[]);
DROP FUNCTION IF EXISTS array_max(a NUMERIC[]);
DROP FUNCTION IF EXISTS array_max(a REAL[]);
DROP FUNCTION IF EXISTS array_max(a DOUBLE PRECISION[]);
DROP FUNCTION IF EXISTS array_max(a SMALLINT[]);
DROP FUNCTION IF EXISTS array_trim(a text[], rd BOOLEAN);
DROP FUNCTION IF EXISTS array_trim(a SMALLINT[], rd BOOLEAN);
DROP FUNCTION IF EXISTS array_trim(a INTEGER[], rd BOOLEAN);
DROP FUNCTION IF EXISTS array_trim(a BIGINT[], rd BOOLEAN);
DROP FUNCTION IF EXISTS array_trim(a NUMERIC[], rd BOOLEAN);
DROP FUNCTION IF EXISTS array_trim(a REAL[], rd BOOLEAN);
DROP FUNCTION IF EXISTS array_trim(a DOUBLE PRECISION[], rd BOOLEAN);
DROP FUNCTION IF EXISTS array_trim(a DATE[], rd BOOLEAN);
DROP FUNCTION IF EXISTS array_trim(a TIMESTAMP[], rd BOOLEAN);
DROP FUNCTION IF EXISTS array_trim(a TIMESTAMP WITH TIME ZONE[], rd BOOLEAN);
DROP FUNCTION IF EXISTS to_unix_timestamp(ts timestamp with time zone);
DROP FUNCTION IF EXISTS to_unix_timestamp(ts timestamp);
DROP FUNCTION IF EXISTS datetime_de(t TIMESTAMP WITH TIME ZONE, with_tz BOOLEAN);
DROP FUNCTION IF EXISTS date_de(d DATE);
DROP AGGREGATE IF EXISTS gap_fill(anyelement);
DROP FUNCTION IF EXISTS gap_fill_internal(s anyelement, v anyelement);
DROP FUNCTION IF EXISTS replace_latin1(s text, s_search text[], s_replace text[]);
DROP FUNCTION IF EXISTS replace_latin1(s text, replacement text);
DROP FUNCTION IF EXISTS replace_latin1(s text);
DROP FUNCTION IF EXISTS replace_encoding(s text, s_search text[], s_replace text[]);
DROP FUNCTION IF EXISTS replace_encoding(s text, e text, replacement text);
DROP FUNCTION IF EXISTS replace_encoding(s text, e text);
DROP FUNCTION IF EXISTS return_not_part_of_encoding(s text, e text);
DROP FUNCTION IF EXISTS return_not_part_of_latin1(s text);
DROP FUNCTION IF EXISTS is_latin1(s text);
DROP FUNCTION IF EXISTS is_encoding(s text, enc text, enc_from text);
DROP FUNCTION IF EXISTS is_encoding(s text, enc text);
DROP VIEW IF EXISTS pg_functions;
DROP VIEW IF EXISTS pg_foreign_keys;
DROP VIEW IF EXISTS pg_db_views;
DROP VIEW IF EXISTS pg_table_matview_infos;
DROP VIEW IF EXISTS pg_object_ownership;
DROP VIEW IF EXISTS pg_bloat_info;
DROP VIEW IF EXISTS pg_unused_indexes;
DROP VIEW IF EXISTS pg_partitioned_tables_infos;
DROP FUNCTION IF EXISTS pg_schema_size(text);
DROP FUNCTION IF EXISTS sha256(bytea);
DROP FUNCTION IF EXISTS is_bigint(s text);
DROP FUNCTION IF EXISTS is_integer(s text);
DROP FUNCTION IF EXISTS is_smallint(s text);
DROP FUNCTION IF EXISTS is_numeric(s text);
DROP FUNCTION IF EXISTS is_real(s text);
DROP FUNCTION IF EXISTS is_double_precision(s text);
DROP FUNCTION IF EXISTS is_boolean(s text);
DROP FUNCTION IF EXISTS is_json(s text);
DROP FUNCTION IF EXISTS is_timestamp(s text, f text);
DROP FUNCTION IF EXISTS is_timestamp(s text);
DROP FUNCTION IF EXISTS is_time(s text, f text);
DROP FUNCTION IF EXISTS is_time(s text);
DROP FUNCTION IF EXISTS is_date(s text, f text);
DROP FUNCTION IF EXISTS is_json(s text);
DROP FUNCTION IF EXISTS is_jsonb(s text);
DROP FUNCTION IF EXISTS is_hex(s TEXT);
DROP FUNCTION IF EXISTS is_uuid(s TEXT);
DROP FUNCTION IF EXISTS hex2bigint(s TEXT);
DROP FUNCTION IF EXISTS is_bigint_array(s TEXT);
DROP FUNCTION IF EXISTS is_integer_array(s TEXT);
DROP FUNCTION IF EXISTS is_smallint_array(s TEXT);
DROP FUNCTION IF EXISTS is_text_array(s TEXT);

END;
