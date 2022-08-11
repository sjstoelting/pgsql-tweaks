SET client_min_messages TO warning;
SET log_min_messages    TO warning;

/*** files with test statements ***/

/**
 * Test for function is_date
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'is_date'
  )
SELECT 2 / test.exist = 1 AS res
FROM test
;

-- Test with date in default format
WITH test AS
	(
		SELECT is_date('2018-01-01') AS isdate, 0 AS zero
	)
SELECT
	CASE
		WHEN isdate THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test if all implementations exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'is_date'
  )
SELECT test.exist = 2 AS res
FROM test
;

-- Test with wrong date in default format
WITH test AS
	(
		SELECT is_date('2018-02-31') AS isdate, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isdate THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with date in German format
WITH test AS
	(
		SELECT is_date('01.01.2018', 'DD.MM.YYYY') AS isdate, 0 AS zero
	)
SELECT
	CASE
		WHEN isdate THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with wrong date in German format
WITH test AS
	(
		SELECT is_date('31.02.2018', 'DD.MM.YYYY') AS isdate, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isdate THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

/**
 * Test for function is_time
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'is_time'
  )
SELECT 2 / test.exist = 1 AS res
FROM test
;

-- Test if all implementations exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'is_time'
  )
SELECT test.exist = 2 AS res
FROM test
;

-- Test with time in default format
WITH test AS
	(
		SELECT is_time('14:33:55.456574') AS istime
      , 0 AS zero
	)
SELECT
	CASE
		WHEN istime THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with wrong time in default format
WITH test AS
	(
		SELECT is_time('25:33:55.456574') AS istime
      , 0 AS zero
	)
SELECT
	CASE
		WHEN NOT istime THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with time in some format
WITH test AS
	(
    SELECT is_time('14.33.55,456574', 'HH24.MI.SS,US') AS istime
      , 0 AS zero
	)
SELECT
	CASE
		WHEN istime THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with wrong time in some format
WITH test AS
	(
    SELECT is_time('25.33.55,456574', 'HH24.MI.SS,US') AS istime
      , 0 AS zero
	)
SELECT
	CASE
		WHEN NOT istime THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

/**
 * Test for function is_timestamp
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'is_timestamp'
  )
SELECT 2 / test.exist = 1 AS res
FROM test
;

-- Test if all implementations exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'is_timestamp'
  )
SELECT test.exist = 2 AS res
FROM test
;

-- Test with timestamp in default format
WITH test AS
	(
		SELECT is_timestamp('2018-01-01 00:00:00') AS istimestamp, 0 AS zero
	)
SELECT
	CASE
		WHEN istimestamp THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with wrong timestamp in default format
WITH test AS
	(
		SELECT is_timestamp('2018-01-01 25:00:00') AS istimestamp, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT istimestamp THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with timestamp in German format
WITH test AS
	(
		SELECT is_timestamp('01.01.2018 00:00:00', 'DD.MM.YYYY HH24.MI.SS') AS istimestamp, 0 AS zero
	)
SELECT
	CASE
		WHEN istimestamp THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with wrong timestamp in German format
WITH test AS
	(
		SELECT is_timestamp('01.01.2018 25:00:00', 'DD.MM.YYYY HH24.MI.SS') AS istimestamp, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT istimestamp THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

/**
 * Test for function is_numeric
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'is_numeric'
  )
SELECT 1 / test.exist = 1 AS res
FROM test
;

-- Test integer
WITH test AS
	(
		SELECT is_numeric('123') AS isnum, 0 AS zero
	)
SELECT
	CASE
		WHEN isnum THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with decimal separator
WITH test AS
	(
		SELECT is_numeric('123.456') AS isnum, 0 AS zero
	)
SELECT
	CASE
		WHEN isnum THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test not a number
WITH test AS
	(
		SELECT is_numeric('1 2') AS isnum, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isnum THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

/**
 * Test for function is_integer
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'is_integer'
  )
SELECT 1 / test.exist = 1 AS res
FROM test
;

-- Test integer
WITH test AS
	(
		SELECT is_integer('123') AS isnum, 0 AS zero
	)
SELECT
	CASE
		WHEN isnum THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with decimal separator, not an integer
WITH test AS
	(
		SELECT is_integer('123.456') AS isnum, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isnum THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

/**
 * Test for function pg_schema_size
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'pg_schema_size'
  )
SELECT 1 / test.exist = 1 AS res
FROM test
;

-- Test with date in default format
WITH test AS
	(
		SELECT pg_schema_size('public') AS schema_size, 0 AS zero
	)
SELECT
	CASE
		WHEN schema_size > 0 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

/**
 * Test for view pg_db_views
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_views
    WHERE viewname = 'pg_db_views'
  )
SELECT 1 / test.exist = 1 AS res
FROM test
;

-- Test if the view runs without errors
WITH test AS
	(
		SELECT count(*) as key_count
      , 0 AS zero
    FROM pg_db_views
	)
SELECT
	CASE
		WHEN key_count >= 0 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

/**
 * Test for view pg_foreign_keys
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_views
    WHERE viewname = 'pg_foreign_keys'
  )
SELECT 1 / test.exist = 1 AS res
FROM test
;

-- Test if the view runs without errors
WITH test AS
	(
		SELECT count(*) as key_count
      , 0 AS zero
    FROM pg_foreign_keys
	)
SELECT
	CASE
		WHEN key_count >= 0 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

/**
 * Test for view pg_functions
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_views
    WHERE viewname = 'pg_functions'
  )
SELECT 1 / test.exist = 1 AS res
FROM test
;

-- Test if the view runs without errors
WITH test AS
	(
    SELECT count(*) as key_count
			, 0 AS zero
    FROM pg_functions
	)
SELECT
	CASE
		WHEN key_count >= 0 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

/**
 * Test for function is_encoding
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'is_encoding'
  )
SELECT 2 / test.exist = 1 AS res
FROM test
;

-- Test if all implementations exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'is_encoding'
  )
SELECT test.exist = 2 AS res
FROM test
;

-- Test with a test string containing only latin1
WITH test AS
	(
		SELECT is_encoding('Some characters', 'LATIN1') AS isencoding, 0 AS zero
	)
SELECT
	CASE
		WHEN isencoding THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with a test string containing non latin1 characters
WITH test AS
	(
		SELECT is_encoding('Some characters, ğ is Turkish and not latin1', 'LATIN1') AS isencoding, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isencoding THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with a test string containing only latin1
WITH test AS
	(
		SELECT is_encoding('Some characters', 'LATIN1', 'UTF8') AS isencoding, 0 AS zero
	)
SELECT
	CASE
		WHEN isencoding THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with a test string containing non latin1 characters
WITH test AS
	(
		SELECT is_encoding('Some characters, ğ is Turkish and not latin1', 'LATIN1', 'UTF8') AS isencoding, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isencoding THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

/**
 * Test for function is_latin1
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'is_latin1'
  )
SELECT 1 / test.exist = 1 AS res
FROM test
;

-- Test with a test string containing only latin1
WITH test AS
	(
		SELECT is_latin1('Some characters') AS islatin1, 0 AS zero
	)
SELECT
	CASE
		WHEN islatin1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with a test string containing non latin1 characters
WITH test AS
	(
		SELECT is_latin1('Some characters, ğ is Turkish and not latin1') AS islatin1, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT islatin1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

/**
 * Test for the functions return_not_part_of_latin1
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT count(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'return_not_part_of_latin1'
  )
SELECT 1 / test.exist = 1 AS res
FROM test
;

-- Test the returning result which should contain two array elements
with test AS
  (
    SELECT return_not_part_of_latin1('ağbƵcğeƵ') AS res
      , 0 AS zero
  )
SELECT
  CASE
    WHEN array_length(res, 1) = 2 THEN
      TRUE
    ELSE
      (1 / test.zero)::BOOLEAN
      END as res_1
      , CASE
      	WHEN 'ğ' = ANY (res) AND 'Ƶ' = ANY (res) THEN
      		TRUE
        ELSE
          (1 / test.zero)::BOOLEAN
      END as res_2
FROM test
;

END;

/**
 * Test for the functions replace_encoding
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT count(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'replace_encoding'
  )
SELECT 3 / test.exist = 1 AS res
FROM test
;

-- Test if all three implementations exists
WITH test AS
  (
    SELECT count(*) AS exist
      , 0 AS zero
    FROM pg_catalog.pg_proc
    WHERE proname = 'replace_encoding'
  )
SELECT
  CASE
    WHEN test.exist = 3 THEN
      TRUE
    ELSE
      (1 / test.zero)::BOOLEAN
  END AS res
FROM test
;

-- Test of the first implementation which replaces none latin1 characters with
-- empty strings
WITH test AS
	(
		SELECT 'ağbƵcğeƵ' AS test_string
      , 'latin1' AS enc
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN length(test_string) = 8 AND length(replace_encoding(test_string, enc)) = 4 THEN
			TRUE
		ELSE
      (1 / test.zero)::BOOLEAN
  END AS res_1
  , CASE
		WHEN is_encoding(replace_encoding(test_string, enc), enc) THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_2
FROM test
;

-- Test of the second implementation which replaces none latin1 characters with
-- second parameter
WITH test AS
	(
		SELECT 'ağbcğe' AS test_string
      , 'latin1' AS enc
			, 'g' AS replacement
			, 0 AS zero
	)
SELECT
	CASE
		WHEN length(test_string) = length(replace_encoding(test_string, enc, replacement)) THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
  , CASE
		WHEN is_encoding(replace_encoding(test_string, enc, replacement), enc) THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_2
FROM test
;

-- Test of the third implementation which replaces given none latin1 characters
-- in an array as second parameter with latin1 characters given in an array as
-- the third paramater
WITH test AS
	(
		SELECT 'ağbƵcğeƵ' AS test_string
			, string_to_array('ğ,Ƶ', ',') AS to_replace
			, string_to_array('g,Z', ',') AS replacement
			, 0 AS zero
	)
SELECT
	CASE
		WHEN length(test_string) = length(replace_encoding(test_string, to_replace, replacement)) THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
	, CASE
		WHEN is_latin1(replace_encoding(test_string, to_replace, replacement)) THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_2
FROM test
;

ROLLBACK;

/**
 * Test for the functions replace_latin1
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT count(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'replace_latin1'
  )
SELECT 3 / test.exist = 1 AS res
FROM test
;

-- Test if all three implementations exists
WITH test AS
  (
    SELECT count(*) AS exist
      , 0 AS zero
    FROM pg_catalog.pg_proc
    WHERE proname = 'replace_latin1'
  )
SELECT
  CASE
    WHEN test.exist = 3 THEN
      TRUE
    ELSE
      (1 / test.zero)::BOOLEAN
  END AS res
FROM test
;

-- Test of the first implementation which replaces none latin1 characters with
-- empty strings
WITH test AS
	(
		SELECT 'ağbƵcğeƵ' AS test_string
			, 0 AS zero
	)
SELECT
	CASE
		WHEN length(test_string) = 8 AND length(replace_latin1(test_string)) = 4 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
  , CASE
		WHEN is_latin1(replace_latin1(test_string)) THEN
			TRUE
		ELSE
    (1 / test.zero)::BOOLEAN
	END AS res_2
FROM test
;

-- Test of the second implementation which replaces none latin1 characters with
-- second parameter
WITH test AS
	(
		SELECT 'ağbcğe' AS test_string
			, 'g' AS replacement
			, 0 AS zero
	)
SELECT
	CASE
		WHEN length(test_string) = length(replace_latin1(test_string, replacement)) THEN
			TRUE
		ELSE
    (1 / test.zero)::BOOLEAN
	END AS res_1
  , CASE
		WHEN is_latin1(replace_latin1(test_string, replacement)) THEN
			TRUE
		ELSE
    (1 / test.zero)::BOOLEAN
	END AS res_2
FROM test
;

-- Test of the third implementation which replaces given none latin1 characters
-- in an array as second parameter with latin1 characters given in an array as
-- the third paramater
WITH test AS
	(
		SELECT 'ağbƵcğeƵ' AS test_string
			, string_to_array('ğ,Ƶ', ',') AS to_replace
			, string_to_array('g,Z', ',') AS replacement
			, 0 AS zero
	)
SELECT
	CASE
		WHEN length(test_string) = length(replace_latin1(test_string, to_replace, replacement)) THEN
			TRUE
		ELSE
    (1 / test.zero)::BOOLEAN
	END AS res_1
	, CASE
		WHEN is_latin1(replace_latin1(test_string, to_replace, replacement)) THEN
			TRUE
		ELSE
    (1 / test.zero)::BOOLEAN
	END AS res_2
FROM test
;

ROLLBACK;

/**
 * Test for the functions return_not_part_of_encoding
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT count(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'return_not_part_of_encoding'
  )
SELECT 1 / test.exist = 1 AS res
FROM test
;

-- Test the returning result which should contain two array elements
WITH test AS
  (
    SELECT return_not_part_of_encoding('ağbƵcğeƵ', 'latin1') AS res
      , 0 AS zero
  )
SELECT
  CASE
    WHEN array_length(res, 1) = 2 THEN
      TRUE
    ELSE
      (1 / test.zero)::BOOLEAN
  END as res_1
  , CASE
  	WHEN 'ğ' = ANY (res) AND 'Ƶ' = ANY (res) THEN
  		TRUE
    ELSE
      (1 / test.zero)::BOOLEAN
  END as res_2
FROM test
;

ROLLBACK;

/**
 * Test for the aggregate gap_fill
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT count(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'gap_fill_internal'
  )
SELECT 1 / test.exist = 1 AS res
FROM test
;

-- Test if the aggregate exists
WITH test AS
  (
    SELECT count(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'gap_fill'
  )
SELECT 1 / test.exist = 1 AS res
FROM test
;

-- Create a table with some test values
CREATE TABLE test_gap_fill(id INTEGER, some_value VARCHAR);

INSERT INTO test_gap_fill(id, some_value) VALUES
  (1, 'value 1'),
  (1, NULL),
  (2, 'value 2'),
  (2, NULL),
  (2, NULL),
  (3, 'value 3')
;

-- Select the test data and return filled columns, the count of colums should be
-- the same number as the count of not empty ones
WITH t1 AS
  (
    SELECT id
      , gap_fill(some_value) OVER (ORDER BY id) AS some_value
    FROM test_gap_fill
  )
SELECT count(*) / count(*) FILTER (WHERE NOT some_value IS NULL) = 1 AS res
FROM t1
;

ROLLBACK;

/**
 * Test for function date_de
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'date_de'
  )
SELECT 1 / test.exist = 1 AS res
FROM test
;

-- Uses function is_date which is part of this repository
WITH test AS
	(
		SELECT date_de('2018-01-01') AS d_de
			, 0 AS zero
	)
SELECT
	CASE
		WHEN is_date(d_de, 'DD.MM.YYYY') THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
		END AS res
FROM test
;

ROLLBACK;

/**
 * Test for function datetime_de
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'datetime_de'
  )
SELECT 2 / test.exist = 1 AS res
FROM test
;

-- Test if all implementations exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'is_time'
  )
SELECT test.exist = 2 AS res
FROM test
;

-- Uses function is_timestamp which is part of this repository
WITH test AS
	(
		SELECT datetime_de('2018-01-01 13:30:30 GMT') AS ts_de
			, 0 AS zero
	)
SELECT
	CASE
		WHEN is_timestamp(ts_de, 'DD.MM.YYYY HH24:MI:SS') THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
		END AS res
FROM test
;

ROLLBACK;

/**
 * Test for functions to_unix_timestamp
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'to_unix_timestamp'
  )
SELECT 2 / test.exist = 1 AS res
FROM test
;

-- Test with timestamp without time zone
WITH test AS
	(
		SELECT to_unix_timestamp('2018-01-01 00:00:00') AS unix_timestamp, 0 AS zero
	)
SELECT
	CASE
		WHEN unix_timestamp > 0 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with timestamp with time zone
WITH test AS
	(
		SELECT to_unix_timestamp(now()) AS unix_timestamp, 0 AS zero
	)
SELECT
	CASE
		WHEN unix_timestamp > 0 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

/**
 * Test for function is_empty
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'is_empty'
  )
SELECT 1 / test.exist = 1 AS res
FROM test
;

-- Test not empty
WITH test AS
	(
		SELECT is_empty('abc') AS isempty, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isempty THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test empty string
WITH test AS
	(
		SELECT is_empty('') AS isempty, 0 AS zero
	)
SELECT
	CASE
		WHEN isempty THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test NULL
WITH test_data AS
	(
		SELECT NULL AS test_value
	)
, test AS
	(
		SELECT is_empty(test_value) AS isempty, 0 AS zero
		FROM test_data
	)
SELECT
	CASE
		WHEN isempty THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

/**
 * Test for the functions array_max
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT count(*) AS exist
		FROM pg_catalog.pg_proc
		WHERE proname = 'array_max'
  )
SELECT 4 / test.exist = 1 AS res
FROM test
;

-- Test if all three implementations exists
WITH test AS
  (
    SELECT count(*) AS exist
      , 0 AS zero
    FROM pg_catalog.pg_proc
    WHERE proname = 'array_max'
  )
SELECT
	CASE
    	WHEN test.exist = 4 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res
FROM test
;

-- Test of the first implementation
-- SMALLINT ARRAY
WITH test AS
	(
		SELECT array_max(ARRAY[45, 60, 43, 99]::SMALLINT[]) AS min_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN min_value = 99 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

-- Test of the second implementation
-- INTEGER ARRAY
WITH test AS
	(
		SELECT array_max(ARRAY[45, 60, 43, 99]::INTEGER[]) AS min_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN min_value = 99 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

-- Test of the third implementation
-- BIGINT ARRAY
WITH test AS
	(
		SELECT array_max(ARRAY[45, 60, 43, 99]::BIGINT[]) AS min_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN min_value = 99 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

-- Test of the fourth implementation
-- TEXT ARRAY
WITH test AS
	(
		SELECT array_max(ARRAY['def', 'abc', 'ghi']::TEXT[]) AS min_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN min_value = 'ghi' THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

ROLLBACK;

/**
 * Test for the functions array_min
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT count(*) AS exist
		FROM pg_catalog.pg_proc
		WHERE proname = 'array_min'
  )
SELECT 4 / test.exist = 1 AS res
FROM test
;

-- Test if all three implementations exists
WITH test AS
  (
    SELECT count(*) AS exist
      , 0 AS zero
    FROM pg_catalog.pg_proc
    WHERE proname = 'array_min'
  )
SELECT
	CASE
    	WHEN test.exist = 4 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res
FROM test
;

-- Test of the first implementation
-- SMALLINT ARRAY
WITH test AS
	(
		SELECT array_min(ARRAY[45, 60, 43, 99]::SMALLINT[]) AS min_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN min_value = 43 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

-- Test of the second implementation
-- INTEGER ARRAY
WITH test AS
	(
		SELECT array_min(ARRAY[45, 60, 43, 99]::INTEGER[]) AS min_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN min_value = 43 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

-- Test of the third implementation
-- BIGINT ARRAY
WITH test AS
	(
		SELECT array_min(ARRAY[45, 60, 43, 99]::BIGINT[]) AS min_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN min_value = 43 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

-- Test of the fourth implementation
-- TEXT ARRAY
WITH test AS
	(
		SELECT array_min(ARRAY['def', 'abc', 'ghi']::TEXT[]) AS min_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN min_value = 'abc' THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

ROLLBACK;

/**
 * Test for the functions array_avg
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT count(*) AS exist
		FROM pg_catalog.pg_proc
		WHERE proname = 'array_avg'
  )
SELECT 3 / test.exist = 1 AS res
FROM test
;

-- Test if all three implementations exists
WITH test AS
  (
    SELECT count(*) AS exist
      , 0 AS zero
    FROM pg_catalog.pg_proc
    WHERE proname = 'array_avg'
  )
SELECT
	CASE
    	WHEN test.exist = 3 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res
FROM test
;

-- Test of the first implementation
-- SMALLINT ARRAY
WITH test AS
	(
		SELECT array_avg(ARRAY[45, 60, 43, 99]::SMALLINT[]) AS avg_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN avg_value = 62 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

-- Test of the second implementation
-- INTEGER ARRAY
WITH test AS
	(
		SELECT array_avg(ARRAY[45, 60, 43, 99]::INTEGER[]) AS avg_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN avg_value = 62 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

-- Test of the third implementation
-- BIGINT ARRAY
WITH test AS
	(
		SELECT array_avg(ARRAY[45, 60, 43, 99]::BIGINT[]) AS avg_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN avg_value = 62 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

ROLLBACK;

/**
 * Test for the functions array_sum
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT count(*) AS exist
		FROM pg_catalog.pg_proc
		WHERE proname = 'array_sum'
  )
SELECT 3 / test.exist = 1 AS res
FROM test
;

-- Test if all three implementations exists
WITH test AS
  (
    SELECT count(*) AS exist
      , 0 AS zero
    FROM pg_catalog.pg_proc
    WHERE proname = 'array_sum'
  )
SELECT
	CASE
    	WHEN test.exist = 3 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res
FROM test
;

-- Test of the first implementation
-- SMALLINT ARRAY
WITH test AS
	(
		SELECT array_sum(ARRAY[45, 60, 43, 99]::SMALLINT[]) AS sum_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN sum_value = 247 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

-- Test of the second implementation
-- INTEGER ARRAY
WITH test AS
	(
		SELECT array_sum(ARRAY[45, 60, 43, 99]::INTEGER[]) AS sum_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN sum_value = 247 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

-- Test of the third implementation
-- BIGINT ARRAY
WITH test AS
	(
		SELECT array_sum(ARRAY[45, 60, 43, 99]::BIGINT[]) AS sum_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN sum_value = 247 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

ROLLBACK;

/**
 * Test for view pg_active_locks
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_views
    WHERE viewname = 'pg_active_locks'
  )
SELECT 1 / test.exist = 1 AS res
FROM test
;

-- Test if the view runs without errors
WITH test AS
	(
    SELECT count(*) as key_count
			, 0 AS zero
    FROM pg_active_locks
	)
SELECT
	CASE
		WHEN key_count >= 0 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

