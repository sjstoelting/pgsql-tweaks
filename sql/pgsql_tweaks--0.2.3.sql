/**
 * PostgreSQL pgsql_tweaks extension
 * Licence:    PostgreSQL Licence, see https://raw.githubusercontent.com/sjstoelting/pgsql-tweaks/master/LICENSE.md
 * Author:     Stefanie Janine Stölting <mail@stefanie-stoelting.de>
 * Repository: http://github.com/sjstoelting/pgsql_tweaks/
 * Version:    0.2.3
 */

/*** initial statements ***/
SET client_min_messages TO warning;
SET log_min_messages    TO warning;


/*** files with creation statements ***/

/**
 * Creates two functions to check strings for being a date.
 * The first function checks it with the default format, the second with the
 * format given as parameter.
 */
CREATE OR REPLACE FUNCTION is_date(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::date;
	RETURN TRUE;
EXCEPTION WHEN OTHERS THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_date(s VARCHAR) IS 'Takes a varchar and checks if it is a date, uses standard date format YYYY-MM-DD';


CREATE OR REPLACE FUNCTION is_date(s VARCHAR, f VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM to_date(s, f);
	RETURN TRUE;
EXCEPTION WHEN OTHERS THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_date(s VARCHAR, f VARCHAR) IS 'Takes a varchar and checks if it is a date by taking the second varchar as date format';

/**
 * Creates two functions to check strings for being a time.
 * The first function checks it with the default format, the second with the
 * format given as parameter.
 */
CREATE OR REPLACE FUNCTION is_time(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::TIME;
	RETURN TRUE;
EXCEPTION WHEN OTHERS THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_time(s VARCHAR) IS 'Takes a varchar and checks if it is a time, uses standard date format HH24:MI:SS.US';


CREATE OR REPLACE FUNCTION is_time(s VARCHAR, f VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM to_timestamp(s, f)::TIME;
	RETURN TRUE;
EXCEPTION WHEN OTHERS THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_time(s VARCHAR, f VARCHAR) IS 'Takes a varchar and checks if it is a time by taking the second varchar as time format';

/**
 * Creates two functions to check strings for being timestamps.
 * The first function checks it with the default format, the second with the
 * format given as parameter.
 */
CREATE OR REPLACE FUNCTION is_timestamp(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::TIMESTAMP;
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE;
COMMENT ON FUNCTION is_timestamp(s VARCHAR) IS 'Takes a varchar and checks if it is a timestamp, uses standard timestamp format YYYY-MM-DD HH24:MI:SS';


CREATE OR REPLACE FUNCTION is_timestamp(s VARCHAR, f VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM to_timestamp(s, f)::TIMESTAMP;
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE;
COMMENT ON FUNCTION is_timestamp(s VARCHAR) IS 'Takes a varchar and checks if it is a timestamp by taking the second varchar as date format';

/**
 * Creates a function to check strings for being nunbers.
 */
CREATE OR REPLACE FUNCTION is_numeric(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::NUMERIC;
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_numeric(s VARCHAR) IS 'Checks, whether the given parameter is a number';

/**
 * Creates a function to check strings for being BIGINT.
 */
CREATE OR REPLACE FUNCTION is_bigint(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::BIGINT;
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_bigint(s VARCHAR) IS 'Checks, whether the given parameter is a BIGINT';

/**
 * Creates a function to check strings for being INTEGER.
 */
CREATE OR REPLACE FUNCTION is_integer(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::INTEGER;
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_integer(s VARCHAR) IS 'Checks, whether the given parameter is an INTEGER';

/**
 * Creates a function to check strings for being SMALLINT.
 */
CREATE OR REPLACE FUNCTION is_smallint(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::SMALLINT;
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_smallint(s VARCHAR) IS 'Checks, whether the given parameter is a is_smallint';

/**
 * Creates a function to check strings for being INTEGER.
 */
CREATE OR REPLACE FUNCTION is_real(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::REAL;
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_real(s VARCHAR) IS 'Checks, whether the given parameter is a REAL';

/**
 * Creates a function to check strings for being INTEGER.
 */
CREATE OR REPLACE FUNCTION is_double_precision(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::DOUBLE PRECISION;
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_double_precision(s VARCHAR) IS 'Checks, whether the given parameter is a DOUBLE PRECISION';

/**
 * Creates a function to check strings for being INTEGER.
 */
CREATE OR REPLACE FUNCTION is_boolean(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::BOOLEAN;
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_boolean(s VARCHAR) IS 'Checks, whether the given parameter is a BOOLEAN';

/**
 * Creates a function which returns the size of a schema.
 */
CREATE OR REPLACE FUNCTION pg_schema_size(text) RETURNS BIGINT AS $$
	SELECT SUM(pg_total_relation_size(quote_ident(schemaname) || '.' || quote_ident(tablename)))::BIGINT
	FROM pg_tables
	WHERE schemaname = $1
$$ LANGUAGE SQL STRICT IMMUTABLE;
COMMENT ON FUNCTION pg_schema_size(text) IS 'Returns the size for given schema name';

/**
 * Creates a view to get all views of the current database but excluding system views and all views which do start with 'pg' or '_pg'.
 */
CREATE OR REPLACE VIEW pg_db_views AS
SELECT table_catalog AS view_catalog
	, table_schema AS view_schema
	, table_name AS view_name
	, view_definition
FROM INFORMATION_SCHEMA.views
WHERE NOT table_name LIKE 'pg%'
	AND NOT table_name LIKE '\\_pg%'
	AND table_schema NOT IN ('pg_catalog', 'information_schema')
ORDER BY table_catalog
	, table_schema
	, table_name
;
COMMENT ON VIEW pg_db_views IS 'Creates a view to get all views of the current database but excluding system views and all views which do start with ''pg'' or ''_pg''';

/**
 * Creates a view to get all foreign keys of the current database.
 */
 CREATE OR REPLACE VIEW pg_foreign_keys AS
 SELECT tc.table_catalog
 	, tc.table_schema
 	, tc.table_name
 	, kcu.column_name
 	, ccu.TABLE_NAME AS foreign_table_name
 	, ccu.COLUMN_NAME AS foreign_column_name
 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
 	INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu
 		ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
 		INNER JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE AS ccu
 			ON ccu.CONSTRAINT_NAME = tc.CONSTRAINT_NAME
 WHERE tc.CONSTRAINT_TYPE = 'FOREIGN KEY'
 ;
 COMMENT ON VIEW pg_foreign_keys IS 'The view returns all foreign keys of the current database';

/**
 * Creates a view to get all functions of the current database.
 */
CREATE OR REPLACE VIEW pg_functions AS
SELECT pg_namespace.nspname AS schema_name
	, pg_proc.proname AS function_name
	, pg_catalog.pg_get_function_result(pg_proc.oid) AS returning_data_type
	, pg_catalog.pg_get_function_arguments(pg_proc.oid) AS parameters
	, CASE
			WHEN pg_proc.proisagg THEN
				'aggregate'
			WHEN pg_proc.proiswindow THEN
				'window'
			 WHEN pg_proc.prorettype = 'pg_catalog.trigger'::pg_catalog.regtype THEN
			 	'trigger'
			 ELSE
			 	'function'
		END as function_type
	, pg_description.description AS function_comment
FROM pg_catalog.pg_proc
	LEFT OUTER JOIN pg_catalog.pg_namespace
		ON pg_proc.pronamespace = pg_namespace.oid
	LEFT OUTER JOIN pg_catalog.pg_description
		ON pg_proc.oid = pg_description.objoid
WHERE pg_catalog.pg_function_is_visible(pg_proc.oid)
	AND pg_namespace.nspname NOT IN ('pg_catalog', 'information_schema')
ORDER BY schema_name
	, function_name
	, parameters
;
COMMENT ON VIEW pg_functions IS 'The view returns all functions of the current database, excluding those in the schema pg_catalog and information_schema';

/**
 * Creates two functions to check strings about encodings.
 * The first function checks if an UTF-8 string does only contain characters
 * in the given second parameter.
 * The second parameter takes as third parameter the encoding in which the
 * string is and checks if the string does only contain characters as given in
 * the second parameter.
 */
CREATE OR REPLACE FUNCTION is_encoding(s VARCHAR, enc VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM convert(s::bytea, 'UTF8', enc);
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_encoding(s VARCHAR, enc VARCHAR) IS 'Checks, whether the given UTF8 sting contains only encodings in the given encoding characters';


CREATE OR REPLACE FUNCTION is_encoding(s VARCHAR, enc VARCHAR, enc_from VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM convert(s::bytea, enc_from, enc);
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_encoding(s VARCHAR, enc VARCHAR, enc_from VARCHAR) IS 'Checks, whether the given encoding sting contains only encodings in the given encoding characters';

/**
 * Creates a function to check UTF-8 strings for containing only Latin1
 * characters.
 */
CREATE OR REPLACE FUNCTION is_latin1(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM convert(s::bytea, 'UTF8', 'LATIN1');
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_latin1(s VARCHAR) IS 'Checks, whether the given parameter contains only latin1 characters';

/**
 * Creates a function which returns a distinct array with all non latin1
 * characters . Depends on function is_latin1 which is part of this repository.
 */
CREATE OR REPLACE FUNCTION return_not_part_of_latin1(s VARCHAR) RETURNS VARCHAR[] AS $$
DECLARE
	i INTEGER := 0;
	res VARCHAR[];
	current_s VARCHAR := NULL::VARCHAR[];
BEGIN

	LOOP
		EXIT WHEN i > length(s);
		i := i + 1;
		current_s := substring(s FROM i FOR 1);
		IF (NOT is_latin1(current_s)) THEN
			SELECT array_append(res, current_s) INTO res;
		END IF;
	END LOOP;

	WITH t1 AS
		(
			SELECT unnest(res) AS c1
		)
	, t2 AS
		(
			SELECT DISTINCT c1
			FROM t1
		)
	, t3 AS
		(
			SELECT array_agg(c1) AS res_array
			FROM t2
		)
	SELECT res_array
	FROM t3
	INTO res;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION return_not_part_of_latin1(s VARCHAR) IS 'Creates a function which returns a distinct array with all non latin1 characters';

/**
 * Creates three function to replace characters, that are not part of the given
 * encoding.
 * The function does depend on the function is_encoding which is part of this
 * repository.
 */
CREATE OR REPLACE FUNCTION replace_encoding(s VARCHAR, e VARCHAR) RETURNS VARCHAR AS $$
DECLARE
	i INTEGER := 0;
	res VARCHAR;
BEGIN
	res := s;

	LOOP
		EXIT WHEN i > length(res);
		i := i + 1;
		IF (NOT is_encoding(substring(res FROM i FOR 1 ), e)) THEN
			res := OVERLAY(res PLACING '' FROM i FOR 1);
		END IF;
	END LOOP;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION replace_encoding(s VARCHAR, e VARCHAR) IS 'Replaces all characters, which are not part of the given encoding, with spaces and returns the result only with characters which are part of the given encoding';


CREATE OR REPLACE FUNCTION replace_encoding(s VARCHAR, e VARCHAR, replacement VARCHAR) RETURNS VARCHAR AS $$
DECLARE
	i INTEGER := 0;
	res VARCHAR;
BEGIN
	res := s;

	LOOP
		EXIT WHEN i > length(res);
		i := i + 1;
		IF (NOT is_encoding(substring(res FROM i FOR 1 ), e)) THEN
			res := OVERLAY(res PLACING replacement FROM i FOR 1);
		END IF;
	END LOOP;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION replace_encoding(s VARCHAR, e VARCHAR, replacement VARCHAR) IS 'Replaces all characters, which are not part of the given encoding, with the given replacement in the third parameter and returns the result only with characters which are part of the given encoding';


CREATE OR REPLACE FUNCTION replace_encoding(s VARCHAR, s_search VARCHAR[], s_replace VARCHAR[]) RETURNS VARCHAR AS $$
DECLARE
	i INTEGER := 0;
	res VARCHAR;
	length_equal BOOLEAN;
	a_count INTEGER;
BEGIN

	SELECT array_length(s_search, 1) = array_length(s_replace, 1) INTO length_equal;

	IF NOT length_equal THEN
		RAISE 'Search and replacement arrays do not have the same count of entries' USING ERRCODE = '22000';
	END IF;

	SELECT array_length(s_search, 1) INTO a_count;
	res := s;

	LOOP
		EXIT WHEN i >= a_count;
		i := i + 1;

		res := REPLACE(res, s_search[i], s_replace[i]);

	END LOOP;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION replace_encoding(s VARCHAR, s_search VARCHAR[], s_replace VARCHAR[]) IS 'Replaces charactes given in s_search with characters given in s_replace at the same array position';

/**
 * Creates two function to replace characters, that are not part of latin1.
 * The function does depend on the function is_latin1 which is part of this
 * repository.
 */
CREATE OR REPLACE FUNCTION replace_latin1(s VARCHAR) RETURNS VARCHAR AS $$
DECLARE
	i INTEGER := 0;
	res VARCHAR;
BEGIN
	res := s;

	LOOP
		EXIT WHEN i > length(res);
		i := i + 1;
		IF (NOT is_latin1(substring(res FROM i FOR 1 ))) THEN
			res := OVERLAY(res PLACING '' FROM i FOR 1);
		END IF;
	END LOOP;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION replace_latin1(s VARCHAR) IS 'Replaces all not latin1 characters with spaces and returns the result with only containing latin1 characters';


CREATE OR REPLACE FUNCTION replace_latin1(s VARCHAR, replacement VARCHAR) RETURNS VARCHAR AS $$
DECLARE
	i INTEGER := 0;
	res VARCHAR;
BEGIN
	res := s;

	LOOP
		EXIT WHEN i > length(res);
		i := i + 1;
		IF (NOT is_latin1(substring(res FROM i FOR 1 ))) THEN
			res := OVERLAY(res PLACING replacement FROM i FOR 1);
		END IF;
	END LOOP;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION replace_latin1(s VARCHAR, replacement VARCHAR) IS 'Replaces all not latin1 characters with the given replacement in the second parameter and returns the result with only containing latin1 characters';


CREATE OR REPLACE FUNCTION replace_latin1(s VARCHAR, s_search VARCHAR[], s_replace VARCHAR[]) RETURNS VARCHAR AS $$
DECLARE
	res VARCHAR;
BEGIN

	SELECT replace_encoding(s, s_search, s_replace) INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION replace_latin1(s VARCHAR, s_search VARCHAR[], s_replace VARCHAR[]) IS 'Replaces charactes given in s_search with characters given in s_replace at the same array position. The function is an alias for replace_encoding.';

/**
 * Creates a function which returns a distinct array with all non latin1 characters .
 */
CREATE OR REPLACE FUNCTION return_not_part_of_encoding(s VARCHAR, e VARCHAR) RETURNS VARCHAR[] AS $$
DECLARE
	i INTEGER := 0;
	res VARCHAR[];
	current_s VARCHAR := NULL::VARCHAR[];
BEGIN

	LOOP
		EXIT WHEN i > length(s);
		i := i + 1;
		current_s := substring(s FROM i FOR 1);
		IF (NOT is_encoding(current_s, e)) THEN
			SELECT array_append(res, current_s) INTO res;
		END IF;
	END LOOP;

	WITH t1 AS
		(
			SELECT unnest(res) AS c1
		)
	, t2 AS
		(
			SELECT DISTINCT c1
			FROM t1
		)
	, t3 AS
		(
			SELECT array_agg(c1) AS res_array
			FROM t2
		)
	SELECT res_array
	FROM t3
	INTO res;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION return_not_part_of_encoding(s VARCHAR, e VARCHAR) IS 'Creates a function which returns a distinct array with all characters which are not part of the encoding give in e';

/**
 * Create a window function to calculate values for gaps.
 */
CREATE OR REPLACE FUNCTION gap_fill_internal(s anyelement, v anyelement)
RETURNS anyelement AS
$$
BEGIN
	RETURN COALESCE(v, s);
END;
$$ LANGUAGE PLPGSQL IMMUTABLE;
COMMENT ON FUNCTION gap_fill_internal(s anyelement, v anyelement) IS 'The function is used to fill gaps in window functions';


-- The Window function needs an aggregate
DROP AGGREGATE IF EXISTS gap_fill(anyelement);
CREATE AGGREGATE gap_fill(anyelement) (
	SFUNC=gap_fill_internal,
	STYPE = anyelement
)
;
COMMENT ON AGGREGATE gap_fill(anyelement) IS 'Implements the aggregate function to fill gaps using the function GapFillInternal';

/**
 * Creates a function which returns the given date in German format.
 */
 CREATE OR REPLACE FUNCTION date_de(d DATE) RETURNS VARCHAR AS $$
 BEGIN
	RETURN to_char(d, 'DD.MM.YYYY');
 END;
 $$
 STRICT
 LANGUAGE plpgsql IMMUTABLE;
 COMMENT ON FUNCTION date_de(d DATE) IS 'Creates a function which returns the given date in German format';

/**
 * Creates a function which returns the given timestamp in German format.
 * The second parameter indicates, if the result is with or without time zone,
 * default is with thime zone
 */
 CREATE OR REPLACE FUNCTION datetime_de(t TIMESTAMP WITH TIME ZONE, with_tz BOOLEAN DEFAULT TRUE) RETURNS VARCHAR AS $$
 BEGIN
 	IF with_tz THEN
 		RETURN to_char(t, 'DD.MM.YYYY HH24:MI:SS TZ');
 	ELSE
 		RETURN to_char(t, 'DD.MM.YYYY HH24:MI:SS');
 	END IF;
 END;
 $$
 STRICT
 LANGUAGE plpgsql IMMUTABLE;
 COMMENT ON FUNCTION datetime_de(t TIMESTAMP WITH TIME ZONE, with_tz BOOLEAN) IS 'Creates a function which returns the given timestamp in German format';

/**
 * Creates two functions which returns unix timestamp for the a given timestamp
 * or a given timestamp with time zone.
 *
 * The function needs the pgcrypto package.
 */
CREATE OR REPLACE FUNCTION to_unix_timestamp(ts timestamp) RETURNS bigint AS $$
	SELECT EXTRACT (EPOCH FROM ts)::bigint;
$$ LANGUAGE SQL STRICT IMMUTABLE
;
COMMENT ON FUNCTION to_unix_timestamp(ts timestamp) IS 'Returns an unix timestamp for the given timestamp';

CREATE OR REPLACE FUNCTION to_unix_timestamp(ts timestamp with time zone) RETURNS bigint AS $$
	SELECT EXTRACT (EPOCH FROM ts)::bigint;
$$ LANGUAGE SQL STRICT IMMUTABLE
;
COMMENT ON FUNCTION to_unix_timestamp(ts timestamp with time zone) IS 'Returns an unix timestamp for the given timestamp with time zone';

/**
 * Creates a function to checks a string variable for being either, NULL or ''.
 */
CREATE OR REPLACE FUNCTION is_empty(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
	RETURN COALESCE(s, '') = '';
END;
$$
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_empty(s VARCHAR) IS 'Checks, whether the given parameter is NULL or ''''';

/**
 * Returns the maximum value of an array.
 * Implementation for BIGINT, INTEGER, SMALLINT, TEXT
 */

-- BIGINT implementation
CREATE OR REPLACE FUNCTION array_max(a BIGINT[]) RETURNS BIGINT AS $$
DECLARE
	res BIGINT;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
	SELECT max(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_max(a BIGINT[]) IS 'Returns the maximum value of a BIGINT array';

-- INTEGER implementation
CREATE OR REPLACE FUNCTION array_max(a INTEGER[]) RETURNS BIGINT AS $$
DECLARE
	res INTEGER;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT max(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_max(a INTEGER[]) IS 'Returns the maximum value of an INTEGER array';

-- SMALLINT implementation
CREATE OR REPLACE FUNCTION array_max(a SMALLINT[]) RETURNS BIGINT AS $$
DECLARE
	res SMALLINT;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT max(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_max(a SMALLINT[]) IS 'Returns the maximum value of a SMALLINT array';

-- TEXT implementation
CREATE OR REPLACE FUNCTION array_max(a TEXT[]) RETURNS TEXT AS $$
DECLARE
	res TEXT;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT max(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_max(a TEXT[]) IS 'Returns the maximum value of a TEXT array';

-- REAL implementation
CREATE OR REPLACE FUNCTION array_max(a REAL[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT max(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_max(a REAL[]) IS 'Returns the maximum value of a REAL array';

-- DOUBLE PRECISION implementation
CREATE OR REPLACE FUNCTION array_max(a DOUBLE PRECISION[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT max(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_max(a DOUBLE PRECISION[]) IS 'Returns the maximum value of a DOUBLE PRECISION array';

-- NUMERIC implementation
CREATE OR REPLACE FUNCTION array_max(a NUMERIC[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT max(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_max(a NUMERIC[]) IS 'Returns the maximum value of a NUMERIC array';

/**
 * Returns the minumum value of an array.
 * Implementation for BIGINT, INTEGER, SMALLINT, TEXT
 */

-- BIGINT implementation
CREATE OR REPLACE FUNCTION array_min(a BIGINT[]) RETURNS BIGINT AS $$
DECLARE
	res BIGINT;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
	SELECT min(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_min(a BIGINT[]) IS 'Returns the minumum value of a BIGINT array';

-- INTEGER implementation
CREATE OR REPLACE FUNCTION array_min(a INTEGER[]) RETURNS INTEGER AS $$
DECLARE
	res INTEGER;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT min(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_min(a INTEGER[]) IS 'Returns the minumum value of an INTEGER array';

-- SMALLINT implementation
CREATE OR REPLACE FUNCTION array_min(a SMALLINT[]) RETURNS SMALLINT AS $$
DECLARE
	res SMALLINT;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT min(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_min(a SMALLINT[]) IS 'Returns the minumum value of a SMALLINT array';

-- TEXT implementation
CREATE OR REPLACE FUNCTION array_min(a TEXT[]) RETURNS TEXT AS $$
DECLARE
	res TEXT;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT min(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_min(a TEXT[]) IS 'Returns the minumum value of a TEXT array';

-- REAL implementation
CREATE OR REPLACE FUNCTION array_min(a REAL[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT min(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_min(a REAL[]) IS 'Returns the minumum value of a REAL array';

-- DOUBLE PRECISION implementation
CREATE OR REPLACE FUNCTION array_min(a DOUBLE PRECISION[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT min(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_min(a DOUBLE PRECISION[]) IS 'Returns the minumum value of a DOUBLE PRECISION array';

-- NUMERIC implementation
CREATE OR REPLACE FUNCTION array_min(a NUMERIC[]) RETURNS NUMERIC AS $$
DECLARE
	res REAL;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT min(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_min(a NUMERIC[]) IS 'Returns the minumum value of a NUMERIC array';

/**
 * Returns the average value of an array.
 * Implementation for BIGINT, INTEGER, SMALLINT
 */

-- BIGINT implementation
CREATE OR REPLACE FUNCTION array_avg(a BIGINT[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
	SELECT avg(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_avg(a BIGINT[]) IS 'Returns the average value of a BIGINT array';

-- INTEGER implementation
CREATE OR REPLACE FUNCTION array_avg(a INTEGER[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT avg(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_avg(a INTEGER[]) IS 'Returns the average value of an INTEGER array';

-- SMALLINT implementation
CREATE OR REPLACE FUNCTION array_avg(a SMALLINT[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT avg(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_avg(a SMALLINT[]) IS 'Returns the average value of a SMALLINT array';

--REAL implementation
CREATE OR REPLACE FUNCTION array_avg(a REAL[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT avg(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_avg(a REAL[]) IS 'Returns the average value of a REAL array';

-- DOUBLE PRECISION implementation
CREATE OR REPLACE FUNCTION array_avg(a DOUBLE PRECISION[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT avg(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_avg(a DOUBLE PRECISION[]) IS 'Returns the average value of a DOUBLE PRECISION array';

-- NUMERIC implementation
CREATE OR REPLACE FUNCTION array_avg(a NUMERIC[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT avg(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_avg(a NUMERIC[]) IS 'Returns the average value of a NUMERIC array';

/**
 * Returns the sum of values of an array.
 * Implementation for BIGINT, INTEGER, SMALLINT
 */

-- BIGINT implementation
CREATE OR REPLACE FUNCTION array_sum(a BIGINT[]) RETURNS BIGINT AS $$
DECLARE
	res BIGINT;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
	SELECT sum(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_sum(a BIGINT[]) IS 'Returns the sum of values of a BIGINT array';

-- INTEGER implementation
CREATE OR REPLACE FUNCTION array_sum(a INTEGER[]) RETURNS BIGINT AS $$
DECLARE
	res BIGINT;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT sum(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_sum(a INTEGER[]) IS 'Returns the sum of values of an INTEGER array';

-- SMALLINT implementation
CREATE OR REPLACE FUNCTION array_sum(a SMALLINT[]) RETURNS BIGINT AS $$
DECLARE
	res BIGINT;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT sum(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_sum(a SMALLINT[]) IS 'Returns the sum of values of a SMALLINT array';

-- REAL implementation
CREATE OR REPLACE FUNCTION array_sum(a REAL[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT sum(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_sum(a REAL[]) IS 'Returns the sum of values of a REAL array';

-- DOUBLE PRECISION implementation
CREATE OR REPLACE FUNCTION array_sum(a DOUBLE PRECISION[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT sum(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_sum(a DOUBLE PRECISION[]) IS 'Returns the sum of values of a DOUBLE PRECISION array';

-- NUMERIC implementation
CREATE OR REPLACE FUNCTION array_sum(a NUMERIC[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT sum(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_sum(a NUMERIC[]) IS 'Returns the sum of values of a NUMERIC array';

/**
 * Creates a view to get all connections and their locks.
 */
 CREATE OR REPLACE VIEW pg_active_locks AS
 SELECT DISTINCT pid
 	, state
 	, datname
 	, usename
 	, application_name
 	, client_addr
 	, query_start
 	, wait_event_type
 	, wait_event
 	, locktype
 	, mode
 	, query
 FROM pg_stat_activity AS a
 INNER JOIN pg_locks AS l
 	USING(pid)
 ;
COMMENT ON VIEW pg_active_locks IS 'Creates a view to get all connections and their locks';

