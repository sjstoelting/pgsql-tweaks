/**
 * PostgreSQL pgsql_tweaks extension
 * Licence:    PostgreSQL Licence, see https://raw.githubusercontent.com/sjstoelting/pgsql-tweaks/master/LICENSE.md
 * Author:     Stefanie Janine Stölting <mail@stefanie-stoelting.de>
 * Repository: http://github.com/sjstoelting/pgsql_tweaks/
 * Version:    0.10.7
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
CREATE OR REPLACE FUNCTION is_date(s text) RETURNS BOOLEAN AS $$
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
COMMENT ON FUNCTION is_date(s text) IS 'Takes a text and checks if it is a date, uses standard date format YYYY-MM-DD';


CREATE OR REPLACE FUNCTION is_date(s text, f text) RETURNS BOOLEAN AS $$
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
COMMENT ON FUNCTION is_date(s text, f text) IS 'Takes a text and checks if it is a date by taking the second text as date format';

/**
 * Creates two functions to check strings for being a time.
 * The first function checks it with the default format, the second with the
 * format given as parameter.
 */
CREATE OR REPLACE FUNCTION is_time(s text) RETURNS BOOLEAN AS $$
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
COMMENT ON FUNCTION is_time(s text) IS 'Takes a text and checks if it is a time, uses standard date format HH24:MI:SS.US';


CREATE OR REPLACE FUNCTION is_time(s text, f text) RETURNS BOOLEAN AS $$
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
COMMENT ON FUNCTION is_time(s text, f text) IS 'Takes a text and checks if it is a time by taking the second text as time format';

/**
 * Creates two functions to check strings for being timestamps.
 * The first function checks it with the default format, the second with the
 * format given as parameter.
 */
CREATE OR REPLACE FUNCTION is_timestamp(s text) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::TIMESTAMP;
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE;
COMMENT ON FUNCTION is_timestamp(s text) IS 'Takes a text and checks if it is a timestamp, uses standard timestamp format YYYY-MM-DD HH24:MI:SS';


CREATE OR REPLACE FUNCTION is_timestamp(s text, f text) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM to_timestamp(s, f)::TIMESTAMP;
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE;
COMMENT ON FUNCTION is_timestamp(s text) IS 'Takes a text and checks if it is a timestamp by taking the second text as date format';

/**
 * Creates a function to check strings for being nunbers.
 */
CREATE OR REPLACE FUNCTION is_numeric(s text) RETURNS BOOLEAN AS $$
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
COMMENT ON FUNCTION is_numeric(s text) IS 'Checks, whether the given parameter is a number';

/**
 * Creates a function to check strings for being BIGINT.
 */
CREATE OR REPLACE FUNCTION is_bigint(s text) RETURNS BOOLEAN AS $$
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
COMMENT ON FUNCTION is_bigint(s text) IS 'Checks, whether the given parameter is a BIGINT';

/**
 * Creates a function to check strings for being INTEGER.
 */
CREATE OR REPLACE FUNCTION is_integer(s text) RETURNS BOOLEAN AS $$
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
COMMENT ON FUNCTION is_integer(s text) IS 'Checks, whether the given parameter is an INTEGER';

/**
 * Creates a function to check strings for being SMALLINT.
 */
CREATE OR REPLACE FUNCTION is_smallint(s text) RETURNS BOOLEAN AS $$
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
COMMENT ON FUNCTION is_smallint(s text) IS 'Checks, whether the given parameter is a smallint';

/**
 * Creates a function to check strings for being INTEGER.
 */
CREATE OR REPLACE FUNCTION is_real(s text) RETURNS BOOLEAN AS $$
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
COMMENT ON FUNCTION is_real(s text) IS 'Checks, whether the given parameter is a REAL';

/**
 * Creates a function to check strings for being INTEGER.
 */
CREATE OR REPLACE FUNCTION is_double_precision(s text) RETURNS BOOLEAN AS $$
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
COMMENT ON FUNCTION is_double_precision(s text) IS 'Checks, whether the given parameter is a DOUBLE PRECISION';

/**
 * Creates a function to check strings for being BOOLEAN.
 */
CREATE OR REPLACE FUNCTION is_boolean(s text) RETURNS BOOLEAN AS $$
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
COMMENT ON FUNCTION is_boolean(s text) IS 'Checks, whether the given parameter is a BOOLEAN';

/**
 * Creates a function to check strings for being JSON.
 */
CREATE OR REPLACE FUNCTION is_json(s text) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::JSON;
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_json(s text) IS 'Checks, whether the given text is a JSON';

/**
 * Creates a function to check strings for being JSONB.
 */
CREATE OR REPLACE FUNCTION is_jsonb(s text) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::JSONB;
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_jsonb(s text) IS 'Checks, whether the given text is a JSONB';

/**
 * Creates a function to check strings for being UUID.
 */
CREATE OR REPLACE FUNCTION is_uuid(s text) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::UUID;
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_uuid(s text) IS 'Checks, whether the given parameter is a uuid';

/**
 * Creates a function which returns a SHA256 hash for the given string.
 *
 * The function needs the pgcrypto package, this is checked on the installation.
 */
DO $$
DECLARE
	pg_extension_installed BOOLEAN;
	function_source TEXT; 
BEGIN

	SELECT count(*) = 1 AS pgcrypto_installed FROM pg_extension WHERE extname = 'pgcrypto' INTO pg_extension_installed;

	IF pg_extension_installed THEN
		-- The pgcrypto extension is installed, sha256 will be installed
		function_source :=  
$string$
CREATE OR REPLACE FUNCTION sha256(bytea) RETURNS text AS $f1$
	SELECT ENCODE(digest($1, 'sha256'), 'hex')
$f1$ LANGUAGE SQL STRICT IMMUTABLE
;
$string$
;

		EXECUTE function_source;

		COMMENT ON FUNCTION sha256(bytea) IS 'Returns a SHA254 hash for the given string';
	END IF;

END $$;

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
DO $$
DECLARE
	version_11_greater BOOLEAN;
BEGIN
	SELECT to_number((string_to_array(version(), ' '))[2], '999.99') >= 11 INTO version_11_greater;

	DROP VIEW IF EXISTS pg_foreign_keys;

	IF version_11_greater THEN
		-- Only version 11 or newer
		CREATE OR REPLACE VIEW pg_foreign_keys AS
		SELECT ccu.constraint_name
			, tc.is_deferrable
			, tc.initially_deferred
			, tc."enforced"
			, tc.table_schema
			, tc.table_name
			, kcu.column_name
			, ccu.table_schema AS foreign_table_schema
			, ccu.TABLE_NAME AS foreign_table_name
			, ccu.COLUMN_NAME AS foreign_column_name
			, EXISTS
				(
					SELECT 1
					FROM pg_catalog.pg_index AS i
					WHERE i.indrelid = cs.conrelid
						AND i.indpred IS NULL
						AND (i.indkey::smallint[])[0:cardinality(cs.conkey)-1] OPERATOR(pg_catalog.@>) cs.conkey
				) AS is_indexed
			FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
			INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu
				ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
			INNER JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE AS ccu
				ON ccu.CONSTRAINT_NAME = tc.CONSTRAINT_NAME
			INNER JOIN PG_CATALOG.PG_NAMESPACE AS n
				ON tc.table_schema = n.nspname
			INNER JOIN PG_CATALOG.PG_CONSTRAINT AS cs
				ON n."oid" = cs.connamespace
				AND tc.constraint_name = cs.conname
		WHERE tc.CONSTRAINT_TYPE = 'FOREIGN KEY'
		;
	ELSE
		-- Older than version 11
		CREATE OR REPLACE VIEW pg_foreign_keys AS
		SELECT ccu.constraint_name
			, tc.is_deferrable
			, tc.initially_deferred
			, tc.table_schema
			, tc.table_name
			, kcu.column_name
			, ccu.table_schema AS foreign_table_schema
			, ccu.TABLE_NAME AS foreign_table_name
			, ccu.COLUMN_NAME AS foreign_column_name
			, EXISTS
				(
					SELECT 1
					FROM pg_catalog.pg_index AS i
					WHERE i.indrelid = cs.conrelid
						AND i.indpred IS NULL
						AND (i.indkey::smallint[])[0:cardinality(cs.conkey)-1] OPERATOR(pg_catalog.@>) cs.conkey
				) AS is_indexed
			FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
			INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu
				ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
			INNER JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE AS ccu
				ON ccu.CONSTRAINT_NAME = tc.CONSTRAINT_NAME
			INNER JOIN PG_CATALOG.PG_NAMESPACE AS n
				ON tc.table_schema = n.nspname
			INNER JOIN PG_CATALOG.PG_CONSTRAINT AS cs
				ON n."oid" = cs.connamespace
				AND tc.constraint_name = cs.conname
		WHERE tc.CONSTRAINT_TYPE = 'FOREIGN KEY'
		;
	END IF;

	COMMENT ON VIEW pg_foreign_keys IS 'The view returns all foreign keys of the current database';

END $$;

/**
 * Creates a view to get all functions of the current database.
 * This is the script handles the different installations which are needed for
 * PostgreSQL 11 or newer and PostgreSQL 10 or older.
 */
DO $$
DECLARE
	version_greater_11 BOOLEAN;
BEGIN
	SELECT to_number((string_to_array(version(), ' '))[2], '999.99') >= 11 INTO version_greater_11;

	IF version_greater_11 THEN
		-- Create the view pg_functions for PostgreSQL 11 or newer
		CREATE OR REPLACE VIEW pg_functions AS
		SELECT pg_namespace.nspname AS schema_name
			, pg_proc.proname AS function_name
			, pg_catalog.pg_get_function_result(pg_proc.oid) AS returning_data_type
			, pg_catalog.pg_get_function_arguments(pg_proc.oid) AS parameters
			, CASE
					WHEN pg_proc.prokind = 'a' THEN
						'aggregate'
					WHEN pg_proc.prokind = 'w' THEN
						'window'
					WHEN pg_proc.prokind = 'f' THEN
						'function'
					WHEN pg_proc.prorettype = 'pg_catalog.trigger'::pg_catalog.regtype THEN
						'trigger'
					ELSE
						'unknown'
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
	ELSE
		-- Create the view pg_functions for PostgreSQL older than 11
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
	END IF;

	-- Add a comment
	COMMENT ON VIEW pg_functions IS 'The view returns all functions of the current database, excluding those in the schema pg_catalog and information_schema';

END $$;

/**
 * Creates a view to get information about table and materialized views in the
 * current database. It includes their sizes and indexes.
 */
CREATE OR REPLACE VIEW pg_table_matview_infos AS
WITH indexes AS
	(
		SELECT schemaname
			, tablename
			, array_agg(indexname) AS indexes
		FROM pg_indexes
		GROUP BY schemaname
			, tablename
	)
SELECT 'table' AS type
	, n.nspname AS schemaname
	, c.relname AS tablename
	, pg_get_userbyid (c.relowner) AS tableowner
	, t.spcname AS TABLESPACE
	, i.indexes
	, pg_table_size (c.oid) AS table_size
	, pg_indexes_size(c.oid) AS indexes_size
	, pg_total_relation_size(c.oid) AS total_relation_size
	, pg_size_pretty(pg_table_size(c.oid)) AS table_size_pretty
	, pg_size_pretty(pg_indexes_size(c.oid)) AS indexes_size_pretty
	, pg_size_pretty(pg_total_relation_size(c.oid)) AS total_relation_size_pretty
FROM pg_class AS c
	LEFT OUTER JOIN pg_namespace AS n
		ON n.oid = c.relnamespace
	LEFT OUTER JOIN pg_tablespace AS t
		ON t.oid = c.reltablespace
	LEFT OUTER JOIN indexes AS i
		ON n.nspname = i.schemaname
		AND c.relname = i.tablename
WHERE c.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])
	AND n.nspname NOT IN ('pg_catalog', 'information_schema')
UNION ALL
SELECT 'matview' AS type
	, n.nspname AS schemaname
	, c.relname AS matviewname
	, pg_get_userbyid(c.relowner) AS matviewowner
	, t.spcname AS tablespace
	, i.indexes
	, pg_table_size(c.oid) AS table_size
	, pg_indexes_size(c.oid) AS indexes_size
	, pg_total_relation_size(c.oid) AS total_relation_size
	, pg_size_pretty(pg_table_size(c.oid)) AS table_size_pretty
	, pg_size_pretty(pg_indexes_size(c.oid)) AS indexes_size_pretty
	, pg_size_pretty(pg_total_relation_size(c.oid)) AS total_relation_size_pretty
FROM pg_class AS c
	LEFT OUTER JOIN pg_namespace AS n
		ON n.oid = c.relnamespace
	LEFT OUTER JOIN pg_tablespace t
		ON t.oid = c.reltablespace
	LEFT OUTER JOIN indexes AS i
		ON n.nspname = i.schemaname
		AND c.relname = i.tablename
WHERE c.relkind = 'm'::"char"
;
COMMENT ON VIEW pg_table_matview_infos IS 'The view shows detailed information about sizes and indexes of tables and materialized views';

/**
 * Creates a view to get information about partitioned tables.
 */
DO $$
DECLARE
	version_greater_10 BOOLEAN;
BEGIN
	SELECT to_number((string_to_array(version(), ' '))[2], '999.99') >= 10 INTO version_greater_10;

	IF version_greater_10 THEN
		-- Create the view pg_functions for PostgreSQL 10 or newer
		CREATE OR REPLACE VIEW pg_partitioned_tables_infos AS
		SELECT cl.oid AS parent_relid
			, n.nspname AS parent_schemaname
			, cl.relname AS parent_tablename
			, r.rolname AS parent_owner
			, CASE pt.partstrat
				WHEN 'l' THEN
					'LIST'
				WHEN 'r' THEN
					'RANGE'
				WHEN 'h' THEN
					'HASH'
			END AS partition_strategy
			, count (cl2.oid) OVER (PARTITION BY cl.oid) AS count_of_partitions
			, COALESCE (sum (pg_relation_size (cl2.oid)) OVER (PARTITION BY cl.oid), 0) AS overall_size
			, cl2.oid AS child_relid
			, n2.nspname AS child_schemaname
			, cl2.relname AS child_tablename
			, r2.rolname AS child_owner
			, pg_relation_size (cl2.oid) AS child_size
		FROM pg_catalog.pg_class AS cl
		INNER JOIN pg_catalog.pg_partitioned_table AS pt
			ON cl.oid = pt.partrelid
		INNER JOIN pg_catalog.pg_namespace AS n
			ON cl.relnamespace = n.oid
		INNER JOIN pg_catalog.pg_roles AS r
			 ON cl.relowner = r.oid
		LEFT OUTER JOIN pg_catalog.pg_inherits AS i
			ON cl.oid = i.inhparent
		LEFT OUTER JOIN pg_catalog.pg_class AS cl2
			ON i.inhrelid = cl2.oid
			AND cl2.relispartition
			AND cl2.relkind = 'r'
		LEFT OUTER JOIN pg_catalog.pg_namespace AS n2
			ON cl2.relnamespace = n2.oid
		LEFT OUTER JOIN pg_catalog.pg_roles AS r2
			 ON cl2.relowner = r2.oid
		WHERE cl.relkind = 'p'
		;

		COMMENT ON VIEW pg_partitioned_tables_infos IS 'Creates a view to get information about partitioned tables';
	END IF;

END $$;

/**
 * Creates two functions to check strings about encodings.
 * The first function checks if an UTF-8 string does only contain characters
 * in the given second parameter.
 * The second parameter takes as third parameter the encoding in which the
 * string is and checks if the string does only contain characters as given in
 * the second parameter.
 */
CREATE OR REPLACE FUNCTION is_encoding(s text, enc text) RETURNS BOOLEAN AS $$
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
COMMENT ON FUNCTION is_encoding(s text, enc text) IS 'Checks, whether the given UTF8 sting contains only encodings in the given encoding characters';


CREATE OR REPLACE FUNCTION is_encoding(s text, enc text, enc_from text) RETURNS BOOLEAN AS $$
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
COMMENT ON FUNCTION is_encoding(s text, enc text, enc_from text) IS 'Checks, whether the given encoding sting contains only encodings in the given encoding characters';

/**
 * Creates a function to check UTF-8 strings for containing only Latin1
 * characters.
 */
CREATE OR REPLACE FUNCTION is_latin1(s text) RETURNS BOOLEAN AS $$
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
COMMENT ON FUNCTION is_latin1(s text) IS 'Checks, whether the given parameter contains only latin1 characters';

/**
 * Creates a function which returns a distinct array with all non latin1
 * characters . Depends on function is_latin1 which is part of this repository.
 */
CREATE OR REPLACE FUNCTION return_not_part_of_latin1(s text) RETURNS text[] AS $$
DECLARE
	i INTEGER := 0;
	res text[];
	current_s text := NULL::text[];
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
COMMENT ON FUNCTION return_not_part_of_latin1(s text) IS 'Creates a function which returns a distinct array with all non latin1 characters';

/**
 * Creates three function to replace characters, that are not part of the given
 * encoding.
 * The function does depend on the function is_encoding which is part of this
 * repository.
 */
CREATE OR REPLACE FUNCTION replace_encoding(s text, e text) RETURNS text AS $$
DECLARE
	i INTEGER := 0;
	res text;
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
COMMENT ON FUNCTION replace_encoding(s text, e text) IS 'Replaces all characters, which are not part of the given encoding, with spaces and returns the result only with characters which are part of the given encoding';


CREATE OR REPLACE FUNCTION replace_encoding(s text, e text, replacement text) RETURNS text AS $$
DECLARE
	i INTEGER := 0;
	res text;
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
COMMENT ON FUNCTION replace_encoding(s text, e text, replacement text) IS 'Replaces all characters, which are not part of the given encoding, with the given replacement in the third parameter and returns the result only with characters which are part of the given encoding';


CREATE OR REPLACE FUNCTION replace_encoding(s text, s_search text[], s_replace text[]) RETURNS text AS $$
DECLARE
	i INTEGER := 0;
	res text;
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
COMMENT ON FUNCTION replace_encoding(s text, s_search text[], s_replace text[]) IS 'Replaces charactes given in s_search with characters given in s_replace at the same array position';

/**
 * Creates two function to replace characters, that are not part of latin1.
 * The function does depend on the function is_latin1 which is part of this
 * repository.
 */
CREATE OR REPLACE FUNCTION replace_latin1(s text) RETURNS text AS $$
DECLARE
	i INTEGER := 0;
	res text;
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
COMMENT ON FUNCTION replace_latin1(s text) IS 'Replaces all not latin1 characters with spaces and returns the result with only containing latin1 characters';


CREATE OR REPLACE FUNCTION replace_latin1(s text, replacement text) RETURNS text AS $$
DECLARE
	i INTEGER := 0;
	res text;
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
COMMENT ON FUNCTION replace_latin1(s text, replacement text) IS 'Replaces all not latin1 characters with the given replacement in the second parameter and returns the result with only containing latin1 characters';


CREATE OR REPLACE FUNCTION replace_latin1(s text, s_search text[], s_replace text[]) RETURNS text AS $$
DECLARE
	res text;
BEGIN

	SELECT replace_encoding(s, s_search, s_replace) INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION replace_latin1(s text, s_search text[], s_replace text[]) IS 'Replaces charactes given in s_search with characters given in s_replace at the same array position. The function is an alias for replace_encoding.';

/**
 * Creates a function which returns a distinct array with all non latin1 characters .
 */
CREATE OR REPLACE FUNCTION return_not_part_of_encoding(s text, e text) RETURNS text[] AS $$
DECLARE
	i INTEGER := 0;
	res text[];
	current_s text := NULL::text[];
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
COMMENT ON FUNCTION return_not_part_of_encoding(s text, e text) IS 'Creates a function which returns a distinct array with all characters which are not part of the encoding give in e';

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
 CREATE OR REPLACE FUNCTION date_de(d DATE) RETURNS text AS $$
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
 CREATE OR REPLACE FUNCTION datetime_de(t TIMESTAMP WITH TIME ZONE, with_tz BOOLEAN DEFAULT TRUE) RETURNS text AS $$
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
 * The function is installed with a different name, is_empty_b when the
 * extension pgtap is installed as it also has an is_empty function, but with
 * a different implementation.
 * The b in is_empty_b stands for the boolean result, that the function is
 * returning.
 */
DO $$
DECLARE
	pg_extension_installed BOOLEAN;
	function_source TEXT;
BEGIN

	SELECT count(*) pgtap_exists FROM pg_extension WHERE extname = 'pgtap' INTO pg_extension_installed;

	IF NOT pg_extension_installed THEN
		-- pgtap is not installed, is_empty will be installed
		function_source :=
$string$
CREATE OR REPLACE FUNCTION is_empty(s text) RETURNS BOOLEAN AS $f1$
BEGIN
        RETURN COALESCE(s, '') = '';
END;
$f1$
LANGUAGE plpgsql IMMUTABLE
;
$string$
;
		EXECUTE function_source;

		COMMENT ON FUNCTION is_empty(s text) IS 'Checks, whether the given parameter is NULL or ''''';
	ELSE
		-- pgtap is installed, is_empty will be installed as is_empty_b
		function_source :=
$string$
CREATE OR REPLACE FUNCTION is_empty_b(s text) RETURNS BOOLEAN AS $f1$
BEGIN
        RETURN COALESCE(s, '') = '';
END;
$f1$
LANGUAGE plpgsql IMMUTABLE
;
$string$
;
		EXECUTE function_source;

		COMMENT ON FUNCTION is_empty_b(s text) IS 'Checks, whether the given parameter is NULL or ''''';
	END IF;

END $$;

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

CREATE OR REPLACE FUNCTION array_trim(a text[], rd BOOLEAN DEFAULT FALSE) RETURNS text[] AS $$
DECLARE
	res text[];
BEGIN
	
	IF rd THEN
		WITH t1 AS
			(
				SELECT DISTINCT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE vals != ''
		INTO res;
	ELSE
		WITH t1 AS
			(
				SELECT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE vals != ''
		INTO res;
	END IF;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_trim(a text[], rd BOOLEAN) IS 'Removes empty entries from a text array, can remove duplicates, too';

CREATE OR REPLACE FUNCTION array_trim(a SMALLINT[], rd BOOLEAN DEFAULT FALSE) RETURNS SMALLINT[] AS $$
DECLARE
	res SMALLINT[];
BEGIN
	
	IF rd THEN
		WITH t1 AS
			(
				SELECT DISTINCT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	ELSE
		WITH t1 AS
			(
				SELECT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	END IF;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_trim(a SMALLINT[], rd BOOLEAN) IS 'Removes empty entries from a SMALLINT array, can remove duplicates, too';

CREATE OR REPLACE FUNCTION array_trim(a INTEGER[], rd BOOLEAN DEFAULT FALSE) RETURNS INTEGER[] AS $$
DECLARE
	res INTEGER[];
BEGIN
	
	IF rd THEN
		WITH t1 AS
			(
				SELECT DISTINCT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	ELSE
		WITH t1 AS
			(
				SELECT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	END IF;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_trim(a INTEGER[], rd BOOLEAN) IS 'Removes empty entries from a INTEGER array, can remove duplicates, too';

CREATE OR REPLACE FUNCTION array_trim(a BIGINT[], rd BOOLEAN DEFAULT FALSE) RETURNS BIGINT[] AS $$
DECLARE
	res BIGINT[];
BEGIN
	
	IF rd THEN
		WITH t1 AS
			(
				SELECT DISTINCT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	ELSE
		WITH t1 AS
			(
				SELECT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	END IF;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_trim(a BIGINT[], rd BOOLEAN) IS 'Removes empty entries from a BIGINT array, can remove duplicates, too';

CREATE OR REPLACE FUNCTION array_trim(a NUMERIC[], rd BOOLEAN DEFAULT FALSE) RETURNS NUMERIC[] AS $$
DECLARE
	res NUMERIC[];
BEGIN
	
	IF rd THEN
		WITH t1 AS
			(
				SELECT DISTINCT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	ELSE
		WITH t1 AS
			(
				SELECT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	END IF;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_trim(a NUMERIC[], rd BOOLEAN) IS 'Removes empty entries from a NUMERIC array, can remove duplicates, too';

CREATE OR REPLACE FUNCTION array_trim(a REAL[], rd BOOLEAN DEFAULT FALSE) RETURNS REAL[] AS $$
DECLARE
	res REAL[];
BEGIN
	
	IF rd THEN
		WITH t1 AS
			(
				SELECT DISTINCT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	ELSE
		WITH t1 AS
			(
				SELECT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	END IF;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_trim(a REAL[], rd BOOLEAN) IS 'Removes empty entries from a REAL array, can remove duplicates, too';

CREATE OR REPLACE FUNCTION array_trim(a DOUBLE PRECISION[], rd BOOLEAN DEFAULT FALSE) RETURNS DOUBLE PRECISION[] AS $$
DECLARE
	res DOUBLE PRECISION[];
BEGIN
	
	IF rd THEN
		WITH t1 AS
			(
				SELECT DISTINCT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	ELSE
		WITH t1 AS
			(
				SELECT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	END IF;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_trim(a DOUBLE PRECISION[], rd BOOLEAN) IS 'Removes empty entries from a DOUBLE PRECISION array, can remove duplicates, too';

CREATE OR REPLACE FUNCTION array_trim(a DATE[], rd BOOLEAN DEFAULT FALSE) RETURNS DATE[] AS $$
DECLARE
	res DATE[];
BEGIN
	
	IF rd THEN
		WITH t1 AS
			(
				SELECT DISTINCT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	ELSE
		WITH t1 AS
			(
				SELECT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	END IF;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_trim(a DATE[], rd BOOLEAN) IS 'Removes empty entries from a DATE array, can remove duplicates, too';

CREATE OR REPLACE FUNCTION array_trim(a TIMESTAMP[], rd BOOLEAN DEFAULT FALSE) RETURNS TIMESTAMP[] AS $$
DECLARE
	res TIMESTAMP[];
BEGIN
	
	IF rd THEN
		WITH t1 AS
			(
				SELECT DISTINCT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	ELSE
		WITH t1 AS
			(
				SELECT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	END IF;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_trim(a TIMESTAMP[], rd BOOLEAN) IS 'Removes empty entries from a TIMESTAMP array, can remove duplicates, too';

CREATE OR REPLACE FUNCTION array_trim(a TIMESTAMP WITH TIME ZONE[], rd BOOLEAN DEFAULT FALSE) RETURNS TIMESTAMP WITH TIME ZONE[] AS $$
DECLARE
	res TIMESTAMP WITH TIME ZONE[];
BEGIN
	
	IF rd THEN
		WITH t1 AS
			(
				SELECT DISTINCT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	ELSE
		WITH t1 AS
			(
				SELECT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	END IF;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_trim(a TIMESTAMP WITH TIME ZONE[], rd BOOLEAN) IS 'Removes empty entries from a TIMESTAMP WITH TIME ZONE array, can remove duplicates, too';

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

/**
 * Creates a view to get the ownership of all objects in the current database.
 * This is the script handles the different installations which are needed for
 * PostgreSQL 11 or newer and PostgreSQL 10 or older.
 */
DO $$
DECLARE
	version_greater_11 BOOLEAN;
	version_greater_10 BOOLEAN;
BEGIN
	SELECT to_number((string_to_array(version(), ' '))[2], '999.99') >= 11 INTO version_greater_11;
	SELECT to_number((string_to_array(version(), ' '))[2], '999.99') >= 10 INTO version_greater_10;

	IF version_greater_11 THEN
		-- Create the view pg_object_ownership for PostgreSQL 11 or newer
		CREATE OR REPLACE VIEW pg_object_ownership AS
		WITH dbobjects AS
			(
				SELECT cls.oid
					, nsp.nspname AS object_schema
					, cls.relname AS object_name
					, rol.rolname AS owner
					, CASE cls.relkind
						WHEN 'I' THEN
							'PARTITIONED INDEX'
						WHEN 'S' THEN
							'SEQUENCE'
						WHEN 'c' THEN
							'COMPOSITE TYPE'
						WHEN 'f' THEN
							'FOREIGN TABLE'
						WHEN 'i' THEN
							'INDEX'
						WHEN 'm' THEN
							'MATERIALIZED_VIEW'
						WHEN 'p' THEN
							'PARTITIONED TABLE'
						WHEN 'r' THEN
							'TABLE'
						WHEN 'v' THEN
							'VIEW'
						ELSE
							cls.relkind::text
					END AS object_type
				FROM pg_catalog.pg_class AS cls
				INNER JOIN pg_roles AS rol
					ON cls.relowner = rol.oid
				INNER JOIN pg_catalog.pg_namespace AS nsp
					ON cls.relnamespace = nsp.oid
				UNION ALL
				SELECT db.oid
					, NULL AS object_schema
					, db.datname AS object_name
					, rol.rolname AS owner
					, 'DATABASE' AS object_type
				FROM pg_catalog.pg_database AS db
				INNER JOIN pg_roles AS rol
					ON db.datdba = rol.oid
				UNION ALL
				SELECT ext.oid
					, NULL AS object_schema
					, ext.extname
					, rol.rolname AS owner
					, 'EXTENSION' AS object_type
				FROM pg_catalog.pg_extension AS ext
				INNER JOIN pg_roles AS rol
					ON ext.extowner = rol.oid
				UNION ALL
				SELECT fdw.oid
					, NULL AS object_schema
					, fdw.fdwname AS object_name
					, rol.rolname AS owner
					, 'FOREIGN DATA WRAPPER' AS object_type
				FROM pg_catalog.pg_foreign_data_wrapper AS fdw
				INNER JOIN pg_roles AS rol
					ON fdw.fdwowner = rol.oid
				UNION ALL
				SELECT srv.oid
					, NULL AS object_schema
					, srv.srvname AS object_name
					, rol.rolname AS owner
					, 'FOREIGN SERVER' AS object_type
				FROM pg_catalog.pg_foreign_server AS srv
				INNER JOIN pg_roles AS rol
					ON srv.srvowner = rol.oid
				UNION ALL
				SELECT lang.oid
					, NULL AS object_schema
					, lang.lanname AS object_name
					, rol.rolname AS owner
					, 'LANGUAGE' AS object_type
				FROM pg_catalog.pg_language AS lang
				INNER JOIN pg_roles AS rol
					ON lang.lanowner = rol.oid
				UNION ALL
				SELECT nsp.oid
					, NULL AS object_schema
					, nsp.nspname AS object_name
					, rol.rolname AS owner
					, 'SCHEMA' AS object_type
				FROM pg_catalog.pg_namespace AS nsp
				INNER JOIN pg_roles AS rol
					ON nsp.nspowner = rol.oid
				UNION ALL
				SELECT opc.oid
					, NULL AS object_schema
					, opc.opcname AS object_name
					, rol.rolname AS owner
					, 'OPERATOR CLASS' AS object_type
				FROM pg_catalog.pg_opclass AS opc
				INNER JOIN pg_roles AS rol
					ON opc.opcowner = rol.oid
				UNION ALL
				SELECT pro.oid
					, nsp.nspname AS object_schema
					, pro.proname AS object_name
					, rol.rolname AS owner
					, CASE lower(pro.prokind)
						WHEN 'f' THEN
							'FUNCTION'
						WHEN 'p' THEN
							'PROCEDURE'
						WHEN 'a' THEN
							'AGGREGATE FUNCTION'
						WHEN 'w' THEN
							'WINDOW FUNCTION'
						ELSE
							lower(pro.prokind)
					END AS object_type
				FROM pg_catalog.pg_proc AS pro
				INNER JOIN pg_roles AS rol
					ON pro.proowner = rol.oid
				INNER JOIN pg_catalog.pg_namespace nsp
					ON pro.pronamespace = nsp.oid
					WHERE nsp.nspname NOT IN ('pg_catalog', 'information_schema')
				UNION ALL
				SELECT col.oid
					, NULL AS object_schema
					, col.collname AS object_name
					, rol.rolname AS owner
					, 'COLLATION' AS object_type
				FROM pg_catalog.pg_collation AS col
				INNER JOIN pg_roles AS rol
					ON col.collowner = rol.oid
				UNION ALL
				SELECT con.oid
					, NULL AS object_schema
					, con.conname AS object_name
					, rol.rolname AS owner
					, 'CONVERSION' AS object_type
				FROM pg_catalog.pg_conversion AS con
				INNER JOIN pg_roles AS rol
					ON con.conowner = rol.oid
				UNION ALL
				SELECT evt.oid
					, NULL AS object_schema
					, evt.evtname AS object_name
					, rol.rolname AS owner
					, 'EVENT TRIGGER' AS object_type
				FROM pg_catalog.pg_event_trigger AS evt
				INNER JOIN pg_roles AS rol
					ON evt.evtowner = rol.oid
				UNION ALL
				SELECT opf.oid
					, NULL AS object_schema
					, opf.opfname AS object_name
					, rol.rolname AS owner
					, 'OPERATION FAMILY' AS object_type
				FROM pg_catalog.pg_opfamily AS opf
				INNER JOIN pg_roles AS rol
					ON opf.opfowner = rol.oid
				UNION ALL
				SELECT pub.oid
					, NULL AS object_schema
					, pub.pubname AS object_name
					, rol.rolname AS owner
					, 'PUBLICATIONS' AS object_type
				FROM pg_catalog.pg_publication AS pub
				INNER JOIN pg_roles AS rol
					ON pub.pubowner = rol.oid
			)
		SELECT dbobjects.oid
			, dbobjects.object_schema
			, dbobjects.owner
			, dbobjects.object_type
			, depend.deptype
			, CASE depend.deptype
				WHEN 'n' THEN
					'DEPENDENCY_NORMAL'
				WHEN 'a' THEN
					'DEPENDENCY_AUTO'
				WHEN 'i' THEN
					'DEPENDENCY_INTERNAL'
				WHEN 'P' THEN
					'DEPENDENCY_PARTITION_PRI'
				WHEN 'S' THEN
					'DEPENDENCY_PARTITION_SEC'
				WHEN 'e' THEN
					'DEPENDENCY_EXTENSION'
				WHEN 'x' THEN
					'DEPENDENCY_EXTENSION'
				WHEN 'p' THEN
					'DEPENDENCY_PIN'
				ELSE
					'NOT DEFINED, SEE DOCUMENTATION'
			END AS dependency_type
		FROM dbobjects
		LEFT OUTER JOIN pg_catalog.pg_depend AS depend
			ON dbobjects.oid = depend.objid
		WHERE object_schema NOT IN ('information_schema', 'pg_catalog')
			AND object_schema NOT LIKE 'pg_toast%'
		;

		-- Add a comment
		COMMENT ON VIEW pg_object_ownership IS 'The view returns all objects, its type, and its ownership in the current database, excluding those in the schema pg_catalog and information_schema';

	ELSIF version_greater_10 THEN
		-- Create the view pg_object_ownership for PostgreSQL older than 11
		CREATE OR REPLACE VIEW pg_object_ownership AS
		WITH dbobjects AS
			(
				SELECT cls.oid
					, nsp.nspname AS object_schema
					, cls.relname AS object_name
					, rol.rolname AS owner
					, CASE cls.relkind
						WHEN 'I' THEN
							'PARTITIONED INDEX'
						WHEN 'S' THEN
							'SEQUENCE'
						WHEN 'c' THEN
							'COMPOSITE TYPE'
						WHEN 'f' THEN
							'FOREIGN TABLE'
						WHEN 'i' THEN
							'INDEX'
						WHEN 'm' THEN
							'MATERIALIZED_VIEW'
						WHEN 'p' THEN
							'PARTITIONED TABLE'
						WHEN 'r' THEN
							'TABLE'
						WHEN 'v' THEN
							'VIEW'
						ELSE
							cls.relkind::text
					END AS object_type
				FROM pg_catalog.pg_class AS cls
				INNER JOIN pg_roles AS rol
					ON cls.relowner = rol.oid
				INNER JOIN pg_catalog.pg_namespace AS nsp
					ON cls.relnamespace = nsp.oid
				UNION ALL
				SELECT db.oid
					, NULL AS object_schema
					, db.datname AS object_name
					, rol.rolname AS owner
					, 'DATABASE' AS object_type
				FROM pg_catalog.pg_database AS db
				INNER JOIN pg_roles AS rol
					ON db.datdba = rol.oid
				UNION ALL
				SELECT ext.oid
					, NULL AS object_schema
					, ext.extname
					, rol.rolname AS owner
					, 'EXTENSION' AS object_type
				FROM pg_catalog.pg_extension AS ext
				INNER JOIN pg_roles AS rol
					ON ext.extowner = rol.oid
				UNION ALL
				SELECT fdw.oid
					, NULL AS object_schema
					, fdw.fdwname AS object_name
					, rol.rolname AS owner
					, 'FOREIGN DATA WRAPPER' AS object_type
				FROM pg_catalog.pg_foreign_data_wrapper AS fdw
				INNER JOIN pg_roles AS rol
					ON fdw.fdwowner = rol.oid
				UNION ALL
				SELECT srv.oid
					, NULL AS object_schema
					, srv.srvname AS object_name
					, rol.rolname AS owner
					, 'FOREIGN SERVER' AS object_type
				FROM pg_catalog.pg_foreign_server AS srv
				INNER JOIN pg_roles AS rol
					ON srv.srvowner = rol.oid
				UNION ALL
				SELECT lang.oid
					, NULL AS object_schema
					, lang.lanname AS object_name
					, rol.rolname AS owner
					, 'LANGUAGE' AS object_type
				FROM pg_catalog.pg_language AS lang
				INNER JOIN pg_roles AS rol
					ON lang.lanowner = rol.oid
				UNION ALL
				SELECT nsp.oid
					, NULL AS object_schema
					, nsp.nspname AS object_name
					, rol.rolname AS owner
					, 'SCHEMA' AS object_type
				FROM pg_catalog.pg_namespace AS nsp
				INNER JOIN pg_roles AS rol
					ON nsp.nspowner = rol.oid
				UNION ALL
				SELECT opc.oid
					, NULL AS object_schema
					, opc.opcname AS object_name
					, rol.rolname AS owner
					, 'OPERATOR CLASS' AS object_type
				FROM pg_catalog.pg_opclass AS opc
				INNER JOIN pg_roles AS rol
					ON opc.opcowner = rol.oid
				UNION ALL
				SELECT col.oid
					, NULL AS object_schema
					, col.collname AS object_name
					, rol.rolname AS owner
					, 'COLLATION' AS object_type
				FROM pg_catalog.pg_collation AS col
				INNER JOIN pg_roles AS rol
					ON col.collowner = rol.oid
				UNION ALL
				SELECT con.oid
					, NULL AS object_schema
					, con.conname AS object_name
					, rol.rolname AS owner
					, 'CONVERSION' AS object_type
				FROM pg_catalog.pg_conversion AS con
				INNER JOIN pg_roles AS rol
					ON con.conowner = rol.oid
				UNION ALL
				SELECT evt.oid
					, NULL AS object_schema
					, evt.evtname AS object_name
					, rol.rolname AS owner
					, 'EVENT TRIGGER' AS object_type
				FROM pg_catalog.pg_event_trigger AS evt
				INNER JOIN pg_roles AS rol
					ON evt.evtowner = rol.oid
				UNION ALL
				SELECT opf.oid
					, NULL AS object_schema
					, opf.opfname AS object_name
					, rol.rolname AS owner
					, 'OPERATION FAMILY' AS object_type
				FROM pg_catalog.pg_opfamily AS opf
				INNER JOIN pg_roles AS rol
					ON opf.opfowner = rol.oid
				UNION ALL
				SELECT pub.oid
					, NULL AS object_schema
					, pub.pubname AS object_name
					, rol.rolname AS owner
					, 'PUBLICATIONS' AS object_type
				FROM pg_catalog.pg_publication AS pub
				INNER JOIN pg_roles AS rol
					ON pub.pubowner = rol.oid
			)
		SELECT dbobjects.oid
			, dbobjects.object_schema
			, dbobjects.owner
			, dbobjects.object_type
			, depend.deptype
			, CASE depend.deptype
				WHEN 'n' THEN
					'DEPENDENCY_NORMAL'
				WHEN 'a' THEN
					'DEPENDENCY_AUTO'
				WHEN 'i' THEN
					'DEPENDENCY_INTERNAL'
				WHEN 'P' THEN
					'DEPENDENCY_PARTITION_PRI'
				WHEN 'S' THEN
					'DEPENDENCY_PARTITION_SEC'
				WHEN 'e' THEN
					'DEPENDENCY_EXTENSION'
				WHEN 'x' THEN
					'DEPENDENCY_EXTENSION'
				WHEN 'p' THEN
					'DEPENDENCY_PIN'
				ELSE
					'NOT DEFINED, SEE DOCUMENTATION'
			END AS dependency_type
		FROM dbobjects
		LEFT OUTER JOIN pg_catalog.pg_depend AS depend
			ON dbobjects.oid = depend.objid
		WHERE object_schema NOT IN ('information_schema', 'pg_catalog')
			AND object_schema NOT LIKE 'pg_toast%'
		;


		-- Add a comment
		COMMENT ON VIEW pg_object_ownership IS 'The view returns all objects, its type, and its ownership in the current database, excluding those in the schema pg_catalog and information_schema';
	END IF;

END $$;

/**
 * The view shows bloat in tables and indexes.
 */
CREATE OR REPLACE VIEW pg_bloat_info AS
WITH constants AS
	(
		SELECT current_setting('block_size')::numeric AS bs
			, 23 AS hdr
			, 4 AS ma
	)
, bloat_info AS
	(
		SELECT ma
			,bs
			,schemaname
			,tablename
			, (datawidth + (hdr + ma - (case when hdr%ma = 0 THEN ma ELSE hdr%ma END)))::numeric AS datahdr
			, (maxfracsum * (nullhdr + ma - (case when nullhdr%ma = 0 THEN ma ELSE nullhdr%ma END))) AS nullhdr2
		FROM
			(
				SELECT schemaname
					, tablename
					, hdr
					, ma
					, bs
					, sum ((1 - null_frac) * avg_width) AS datawidth
					, max (null_frac) AS maxfracsum
					, hdr +
						(
        						SELECT 1 + count(*) / 8
							FROM pg_stats s2
							WHERE null_frac != 0
							AND s2.schemaname = s.schemaname
							AND s2.tablename = s.tablename
						) AS nullhdr
				FROM pg_stats AS s, constants
				GROUP BY 1
					,2
					,3
					,4
					,5
			) AS foo
	)
, table_bloat AS
	(
		SELECT schemaname
			, tablename
			, cc.relpages
			, bs
			, CEIL ((cc.reltuples * ((datahdr + ma - (CASE WHEN datahdr%ma = 0 THEN ma ELSE datahdr%ma END)) + nullhdr2 + 4)) / (bs - 20::float)) AS otta
		FROM bloat_info
		INNER JOIN pg_class cc
			ON cc.relname = bloat_info.tablename
		INNER JOIN pg_namespace nn
			ON cc.relnamespace = nn.oid
			AND nn.nspname = bloat_info.schemaname
			AND nn.nspname NOT IN
				(
					'information_schema',
					'pg_catalog'
				)
	)
, index_bloat AS
	(
		SELECT schemaname
			, tablename
			, bs
			, COALESCE (c2.relname,'?') AS iname
			, COALESCE (c2.reltuples,0) AS ituples
			, COALESCE (c2.relpages,0) AS ipages
			, COALESCE (CEIL ((c2.reltuples * (datahdr - 12)) / (bs - 20::float)), 0) AS iotta -- very rough approximation, assumes all cols
		FROM bloat_info
		INNER JOIN pg_class AS cc
			ON cc.relname = bloat_info.tablename
		INNER JOIN pg_namespace AS nn
			ON cc.relnamespace = nn.oid
			AND nn.nspname = bloat_info.schemaname
			AND nn.nspname NOT IN
				(
					'information_schema',
					'pg_catalog'
				)
		INNER JOIN pg_index AS i
			ON indrelid = cc.oid
		INNER JOIN pg_class AS c2
			ON c2.oid = i.indexrelid
	)
SELECT type
	, schemaname
	, object_name
	, bloat
	, pg_size_pretty(raw_waste) AS waste
FROM
	(
		SELECT 'table' AS type
			, schemaname
			, tablename AS object_name
			, ROUND (CASE WHEN otta = 0 THEN 0.0 ELSE table_bloat.relpages/otta::numeric END, 1) AS bloat
			, CASE WHEN relpages < otta THEN '0' ELSE (bs * (table_bloat.relpages-otta)::bigint)::bigint END AS raw_waste
		FROM table_bloat
		UNION
		SELECT 'index' AS type
			, schemaname
			, tablename || '::' || iname as object_name
			, ROUND (CASE WHEN iotta = 0 OR ipages = 0 THEN 0.0 ELSE ipages / iotta::numeric END, 1) AS bloat
			, CASE WHEN ipages < iotta THEN '0' ELSE (bs*(ipages-iotta))::bigint END AS raw_waste
		FROM index_bloat
	) AS bloat_summary
ORDER BY raw_waste DESC
	, bloat DESC
;
COMMENT ON VIEW pg_bloat_info IS 'The view shows bloat in tables and indexes.';

/**
 * The view shows unused indexes with further information about the table.
 */
CREATE OR REPLACE VIEW pg_unused_indexes AS
SELECT schemaname
	, relname AS table_name
	, indexrelname AS index_name
	, idx_scan
	, pg_size_pretty (pg_table_size ('"' || schemaname || '"."' || relname || '"')) AS table_size
	, pg_size_pretty (pg_total_relation_size ('"' || schemaname || '"."' || relname || '"')) AS table_total_size
	, pg_size_pretty (pg_indexes_size ('"' || schemaname || '"."' || relname || '"')) AS all_indexes_size
	, pg_size_pretty (pg_relation_size (indexrelid)) AS index_size
	, pg_size_pretty (sum (pg_relation_size (indexrelid)) over ()) AS  size_of_all_indexes
FROM pg_stat_all_indexes
WHERE idx_scan = 0
AND schemaname NOT IN
	(
		'information_schema',
		'pg_catalog',
		'pg_toast'
	)
;
COMMENT ON VIEW pg_unused_indexes IS 'The view shows unused indexes with further information about the table.';

/**
 * Creates a function to convert a hexadicimal number given as string into a BIGINT.
 */
 CREATE OR REPLACE FUNCTION hex2bigint(s TEXT) RETURNS BIGINT AS $$
 	WITH RECURSIVE hex_sep AS
 		(
 			SELECT
 			  	cast (cast (cast ('x0' || substring (s, length (s), 1) AS BIT(8)) AS INT) * POWER(16, 0) AS BIGINT ) int_res
 				, substring (s, 1 , length (s) - 1) AS rest
 				, length (s) - 1 AS len
 				, 1 AS row_num
 			UNION ALL
 			SELECT
 				cast (cast (cast ('x0' || substring (rest, length (rest), 1) AS BIT(8)) AS INT)  * POWER(16, row_num) AS BIGINT) int_res
 				, substring (rest, 1 , length (rest) - 1) AS rest
 				, length (rest) - 1 AS len
 				, row_num + 1 AS row_num
 			FROM hex_sep
 			WHERE len > 0
 		)
 	SELECT cast (sum(int_res)AS BIGINT)
 	FROM hex_sep
 	;
 $$ LANGUAGE sql IMMUTABLE STRICT
 ;
COMMENT ON FUNCTION hex2bigint(s TEXT) IS 'Converts a hexadicimal number given as string into a BIGINT';

/**
* Creates a function to check hexadeciaml numbers passed as strings for being hexadeciaml fitting into a 0BIGINT.
*/
CREATE OR REPLACE FUNCTION is_hex(s TEXT) RETURNS BOOLEAN AS $$
BEGIN
   PERFORM hex2bigint (s);
   RETURN TRUE;
EXCEPTION WHEN others THEN
   RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_hex(s TEXT) IS 'Checks, whether the given parameter is a hexadeciaml number fitting into a BIGINT';

/**
 * Creates a function to check strings for being a BIGINT array.
 */
CREATE OR REPLACE FUNCTION is_bigint_array(s text) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::BIGINT[];
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_bigint_array(s text) IS 'Checks, whether the given parameter is a BIGINT array';

/**
 * Creates a function to check strings for being an INTEGER array.
 */
CREATE OR REPLACE FUNCTION is_integer_array(s text) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::INTEGER[];
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_integer_array(s text) IS 'Checks, whether the given parameter is an INTEGER array';

/**
 * Creates a function to check strings for being an SMALLINT array.
 */
CREATE OR REPLACE FUNCTION is_smallint_array(s text) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::SMALLINT[];
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_smallint_array(s text) IS 'Checks, whether the given parameter is a SMALLINT array';

/**
 * Creates a function to check strings for being an SMALLINT array.
 */
CREATE OR REPLACE FUNCTION is_text_array(s text) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::TEXT[];
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_text_array(s text) IS 'Checks, whether the given parameter is a TEXT array';

