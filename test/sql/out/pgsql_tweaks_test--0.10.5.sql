SET client_min_messages TO warning;
SET log_min_messages    TO warning;

/*** files with test statements ***/

SELECT 'Test starting: function_is_date' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_date'
	)
SELECT
	CASE
		WHEN 2 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with date in default format
WITH test AS
	(
		SELECT is_date('2018-01-01') AS isdate
			, 0 AS zero
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
		SELECT is_date('2018-02-31') AS isdate
			, 0 AS zero
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
		SELECT is_date('01.01.2018', 'DD.MM.YYYY') AS isdate
			, 0 AS zero
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
/**
 * As there has been a behaviour change in PostgreSQL 10, the result is only
 * false with version 10 in <9 it would be true a call to
 * SELECT to_date('31.02.2018', 'DD.MM.YYYY')::DATE;
 * would return 2018-03-03
 */
WITH test AS
	(
		SELECT is_date('31.02.2018', 'DD.MM.YYYY') AS isdate
			, 0 AS zero
			, current_setting('server_version_num')::INTEGER as version_num
	)
SELECT
	CASE
		WHEN (version_num >= 100000 AND NOT isdate) OR (version_num < 100000 AND isdate) THEN
			TRUE
		ELSE
			NULL --(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_is_time' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_time'
	)
SELECT
	CASE
		WHEN 2 / test.exist = 1 THEN
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
			, 0 AS zero
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
/**
 * As there has been a behaviour change in PostgreSQL 10, the result is only
 * false with version 10 in <9 it would be true a call to
 * SELECT to_timestamp('25:33:55.456574', 'HH24.MI.SS,US')::TIME;
 * would return 01:33:55.456574
 */
WITH t1 AS
	(
	SELECT is_time('25.33.55,456574', 'HH24.MI.SS,US') AS istime
		, current_setting('server_version_num')::INTEGER as version_num
	)
, test AS
	(
		SELECT
			CASE
				WHEN (NOT istime AND version_num >= 100000) OR (istime AND version_num < 100000) THEN
					1
				ELSE
					0
			END AS res
		FROM t1
	)
SELECT (1 / res)::BOOLEAN AS res
FROM test
;

WITH t1 AS
	(
	SELECT is_time('25.33.55,456574', 'HH24.MI.SS,US') AS istime
		, current_setting('server_version_num')::INTEGER as version_num
	)
, test AS
	(
		SELECT
			CASE
				WHEN (NOT istime AND version_num >= 100000) OR (istime AND version_num < 100000) THEN
					1
				ELSE
					0
			END AS res
		FROM t1
	)
SELECT (1 / res)::BOOLEAN AS res
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_is_timestamp' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_timestamp'
	)
SELECT
	CASE
		WHEN 2 / test.exist = 1 THEN
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_timestamp'
	)
SELECT
	CASE
		WHEN test.exist = 2 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with timestamp in default format
WITH test AS
	(
		SELECT is_timestamp('2018-01-01 00:00:00') AS istimestamp
			, 0 AS zero
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
		SELECT is_timestamp('2018-01-01 25:00:00') AS istimestamp
			, 0 AS zero
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
		SELECT is_timestamp('01.01.2018 00:00:00', 'DD.MM.YYYY HH24.MI.SS') AS istimestamp
			, 0 AS zero
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
/**
 * As there has been a behaviour change in PostgreSQL 10, the result is only
 * false with version 10 in <9 it would be true a call to
 * SELECT to_timestamp('01.01.2018 25:00:00', 'DD.MM.YYYY HH24.MI.SS')::TIMESTAMP;
 * would return 2018-01-02 01:00:00
 */
WITH test AS
	(
		SELECT is_timestamp('01.01.2018 25:00:00', 'DD.MM.YYYY HH24.MI.SS') AS istimestamp
			, 0 AS zero
			, current_setting('server_version_num')::INTEGER as version_num
	)
SELECT
	CASE
		WHEN version_num >= 100000 THEN
			CASE
				WHEN NOT istimestamp THEN
					TRUE
				ELSE
					(1 / zero)::BOOLEAN
			END
/*			
		ELSE
			CASE
				WHEN istimestamp THEN
					TRUE
				ELSE
					(1 / zero)::BOOLEAN
		END
*/
	END AS res
FROM test
;
WITH test AS
	(
		SELECT is_timestamp('01.01.2018 25:00:00', 'DD.MM.YYYY HH24.MI.SS') AS istimestamp
			, 0 AS zero
			, current_setting('server_version_num')::INTEGER as version_num
	)
SELECT
	CASE
		WHEN version_num < 100000 THEN
			CASE
				WHEN istimestamp THEN
					TRUE
				ELSE
					NULL--(1 / zero)::BOOLEAN
		END
	END AS res
FROM test
;


 
ROLLBACK;

SELECT 'Test starting: function_is_numeric' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_numeric'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test integer
WITH test AS
	(
		SELECT is_numeric('123') AS isnumeric
			, 0 AS zero
	)
SELECT
	CASE
		WHEN isnumeric THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with decimal separator
WITH test AS
	(
		SELECT is_numeric('123.456') AS isnumeric
			, 0 AS zero
	)
SELECT
	CASE
		WHEN isnumeric THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test not a number
WITH test AS
	(
		SELECT is_numeric('1 2') AS isnumeric
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isnumeric THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_is_bigint' AS next_test;
/**
 * Test for function is_bigint
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT COUNT(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_bigint'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test integer
WITH test AS
	(
		SELECT is_bigint('123') AS isbigint
			, 0 AS zero
	)
SELECT
	CASE
		WHEN isbigint THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with decimal separator, not a bigint
WITH test AS
	(
		SELECT is_bigint('123.456') AS isbigint
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isbigint THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with out of range value, not a bigint
WITH test AS
	(
		SELECT is_bigint('32435463435745636545') AS isbigint
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isbigint THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_is_integer' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_integer'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test integer
WITH test AS
	(
		SELECT is_integer('123') AS isinteger
			, 0 AS zero
	)
SELECT
	CASE
		WHEN isinteger THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with decimal separator, not an integer
WITH test AS
	(
		SELECT is_integer('123.456') AS isinteger
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isinteger THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with out of range value, not an integer
WITH test AS
	(
		SELECT is_integer('3243546343') AS isinteger
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isinteger THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_is_smallint' AS next_test;
/**
 * Test for function is_smallint
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT COUNT(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_smallint'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test integer
WITH test AS
	(
		SELECT is_smallint('123') AS issmallint
			, 0 AS zero
	)
SELECT
	CASE
		WHEN issmallint THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with decimal separator, not a smallint
WITH test AS
	(
		SELECT is_smallint('123.456') AS issmallint
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT issmallint THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with out of range value, not a smallint
WITH test AS
	(
		SELECT is_smallint('3243546343') AS issmallint
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT issmallint THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_is_real' AS next_test;
/**
 * Test for function is_real
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT COUNT(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_real'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test integer
WITH test AS
	(
		SELECT is_real('123') AS isreal
			, 0 AS zero
	)
SELECT
	CASE
		WHEN isreal THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with decimal separator
WITH test AS
	(
		SELECT is_real('123.456') AS isreal
			, 0 AS zero
	)
SELECT
	CASE
		WHEN isreal THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with out of range value, not an integer
WITH test AS
	(
		SELECT is_real('123,456') AS isreal
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isreal THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_is_double_precision' AS next_test;
/**
 * Test for function is_double_precision
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT COUNT(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_double_precision'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test integer
WITH test AS
	(
		SELECT is_double_precision('123') AS isdoubleprecision
			, 0 AS zero
	)
SELECT
	CASE
		WHEN isdoubleprecision THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with decimal separator
WITH test AS
	(
		SELECT is_double_precision('123.456') AS isdoubleprecision
			, 0 AS zero
	)
SELECT
	CASE
		WHEN isdoubleprecision THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with out of range value, not an integer
WITH test AS
	(
		SELECT is_double_precision('123,456') AS isdoubleprecision
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isdoubleprecision THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_is_boolean' AS next_test;
/**
 * Test for function is_boolean
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT COUNT(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_boolean'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test single letters beeing boolean
WITH test AS
	(
		SELECT is_boolean('t') AS isboolean_0
			, is_boolean('f') AS isboolean_1
			, is_boolean('T') AS isboolean_2
			, is_boolean('F') AS isboolean_3
			, is_boolean('y') AS isboolean_4
			, is_boolean('n') AS isboolean_5
			, is_boolean('Y') AS isboolean_6
			, is_boolean('N') AS isboolean_7
			, 0 AS zero
	)
SELECT
	CASE
		WHEN isboolean_0 AND isboolean_1 AND isboolean_2 AND isboolean_3 AND
			isboolean_4 AND isboolean_5 AND isboolean_6 AND isboolean_7
		THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test words being boolean
WITH test AS
	(
		SELECT is_boolean('TRUE') AS isboolean_0
			, is_boolean('FALSE') AS isboolean_1
			, is_boolean('true') AS isboolean_2
			, is_boolean('false') AS isboolean_3
			, is_boolean('YES') AS isboolean_4
			, is_boolean('NO') AS isboolean_5
			, is_boolean('yes') AS isboolean_6
			, is_boolean('no') AS isboolean_7
			, 0 AS zero
	)
SELECT
CASE
	WHEN isboolean_0 AND isboolean_1 AND isboolean_2 AND isboolean_3 AND
		isboolean_4 AND isboolean_5 AND isboolean_6 AND isboolean_7
	THEN
		TRUE
	ELSE
		(1 / zero)::BOOLEAN
END AS res
FROM test
;

-- Test text for not beeing boolean
WITH test AS
	(
		SELECT is_boolean('Not a BOOLEAN') AS isboolean, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isboolean THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test positive number for not beeing boolean
WITH test AS
	(
		SELECT is_boolean('3') AS isboolean, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isboolean THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test negative number for not beeing boolean
WITH test AS
	(
		SELECT is_boolean('-1') AS isboolean, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isboolean THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_is_json' AS next_test;
/**
 * Test for function is_json
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT COUNT(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_json'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with a test string containing no JSON
WITH test AS
	(
		SELECT is_json('Not a JSON') AS isjson
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isjson THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with a test string containing JSON
WITH test AS
	(
		SELECT is_json('{"review": {"date": "1970-12-30", "votes": 10, "rating": 5, "helpful_votes": 0}, "product": {"id": "1551803542", "group": "Book", "title": "Start and Run a Coffee Bar (Start & Run a)", "category": "Business & Investing", "sales_rank": 11611, "similar_ids": ["0471136174", "0910627312", "047112138X", "0786883561", "0201570483"], "subcategory": "General"}, "customer_id": "AE22YDHSBFYIP"}') AS isjson
			, 0 AS zero
	)
SELECT
	CASE
		WHEN isjson THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_is_jsonb' AS next_test;
/**
 * Test for function is_jsonb
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT COUNT(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_jsonb'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with a test string containing no JSON
WITH test AS
	(
		SELECT is_jsonb('Not a JSONB') AS isjsonb
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isjsonb THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with a test string containing JSON
WITH test AS
	(
		SELECT is_jsonb('{"review": {"date": "1970-12-30", "votes": 10, "rating": 5, "helpful_votes": 0}, "product": {"id": "1551803542", "group": "Book", "title": "Start and Run a Coffee Bar (Start & Run a)", "category": "Business & Investing", "sales_rank": 11611, "similar_ids": ["0471136174", "0910627312", "047112138X", "0786883561", "0201570483"], "subcategory": "General"}, "customer_id": "AE22YDHSBFYIP"}') AS isjsonb
			, 0 AS zero
	)
SELECT
	CASE
		WHEN isjsonb THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_is_uuid' AS next_test;
/**
 * Test for function is_uuid
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT COUNT(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_uuid'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test uuid
WITH test AS
	(
		SELECT is_uuid('1eb2f229-e013-4e5a-9f51-15a81c820155') AS isuuid
			, 0 AS zero
	)
SELECT
	CASE
		WHEN isuuid THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with out of range value, not a uuid
WITH test AS
	(
		SELECT is_smallint('3243546343') AS isuuid
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isuuid THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_sha256' AS next_test;
/**
 * Test for function sha256
 *
 * Every test does raise division by zero if it failes
 */
DO $$
DECLARE
	pg_extension_installed BOOLEAN;
BEGIN

	SELECT count(*) = 1 AS pgcrypto_installed FROM pg_extension WHERE extname = 'pgcrypto' INTO pg_extension_installed;

	IF pg_extension_installed THEN
		-- The pgcrypto extension is installed, sha256 should be installed, that will be tested
		WITH test AS
			(
				SELECT COUNT(*) AS exist
					, 0 AS zero
				FROM pg_catalog.pg_proc
				WHERE proname = 'sha256'
			)
		SELECT
			CASE
				WHEN 1 / test.exist = 1 THEN
					TRUE
				ELSE
					(1 / zero)::BOOLEAN
			END AS res
		FROM test
		;
		
		-- Test with a test string
		WITH test AS
			(
				SELECT sha256('test-string'::bytea) AS hashed, 'test-string'::bytea AS test_case, 0 AS zero
			)
		SELECT
			CASE
				WHEN hashed = ENCODE(digest(test_case, 'sha256'), 'hex') THEN
					TRUE
				ELSE
					(1 / zero)::BOOLEAN
			END AS res
		FROM test
		;

	END IF;

END $$;

SELECT 'Test starting: function_pg_schema_size' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'pg_schema_size'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Prevent no result because of an empty database without any tables
-- Create at table
CREATE TABLE test_pg_schema_size(id INTEGER, some_value text);

-- Insert some data
INSERT INTO test_pg_schema_size(id, some_value) VALUES
	(1, 'value 1'),
	(1, NULL),
	(2, 'value 2'),
	(2, NULL),
	(2, NULL),
	(3, 'value 3')
;


-- Test with date in default format
WITH test AS
	(
		SELECT pg_schema_size('public') AS schema_size
			, 0 AS zero
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

SELECT 'Test starting: view_pg_db_views' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_views
		WHERE viewname = 'pg_db_views'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
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

SELECT 'Test starting: view_pg_foreign_keys' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_views
		WHERE viewname = 'pg_foreign_keys'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
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

SELECT 'Test starting: view_pg_functions' AS next_test;
/**
 * Test for view pg_functions
 *
 * Every test does raise division by zero if it failes
 */
DO $$
DECLARE
	version_greater_11 BOOLEAN;
	res BOOLEAN;
BEGIN
	SELECT to_number((string_to_array(version(), ' '))[2], '999.99') >= 11 INTO version_greater_11;

	IF version_greater_11 THEN
		-- Test if the function exists
		WITH test AS
			(
				SELECT COUNT(*) AS exist
					, 0 AS zero
				FROM pg_catalog.pg_views
				WHERE viewname = 'pg_functions'
			)
		SELECT
			CASE
				WHEN 1 / test.exist = 1 THEN
					TRUE
				ELSE
					(1 / zero)::BOOLEAN
			END AS res
		FROM test
		INTO res
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
		INTO res
		;

		ROLLBACK;
	END IF;

END $$;

SELECT 'Test starting: view_pg_table_matview_infos' AS next_test;
/**
 * Test for view pg_table_matview_infos
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT COUNT(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_views
		WHERE viewname = 'pg_table_matview_infos'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test if the view runs without errors
WITH test AS
	(
	SELECT count(*) as key_count
			, 0 AS zero
	FROM pg_table_matview_infos
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

SELECT 'Test starting: view_pg_partitioned_tables_infos' AS next_test;
/**
 * Test for view pg_partitioned_tables_infos
 *
 * Every test does raise division by zero if it failes
 */

DO $$
DECLARE
	version_greater_11 BOOLEAN;
	res BOOLEAN;
BEGIN
	SELECT to_number((string_to_array(version(), ' '))[2], '999.99') >= 11 INTO version_greater_11;

	IF version_greater_11 THEN
		-- Test if the function exists
		WITH test AS
			(
				SELECT COUNT(*) AS exist
					, 0 AS zero
				FROM pg_catalog.pg_views
				WHERE viewname = 'pg_partitioned_tables_infos'
			)
		SELECT
			CASE
				WHEN 1 / test.exist = 1 THEN
					TRUE
				ELSE
					(1 / zero)::BOOLEAN
			END AS res
		FROM test
		INTO res
		;

		-- Test if the view runs without errors
		WITH test AS
			(
			SELECT count(*) as key_count
					, 0 AS zero
			FROM pg_partitioned_tables_infos
			)
		SELECT
			CASE
				WHEN key_count >= 0 THEN
					TRUE
				ELSE
					(1 / zero)::BOOLEAN
			END AS res
		FROM test
		INTO res
		;

		ROLLBACK;
	END IF;

END $$;

SELECT 'Test starting: function_is_encoding' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_encoding'
	)
SELECT
	CASE
		WHEN 2 / test.exist = 1 THEN
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_encoding'
	)
SELECT
	CASE
		WHEN test.exist = 2 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with a test string containing only latin1
WITH test AS
	(
		SELECT is_encoding('Some characters', 'LATIN1') AS isencoding
			, 0 AS zero
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
		SELECT is_encoding('Some characters, ğ is Turkish and not latin1', 'LATIN1') AS isencoding
			, 0 AS zero
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
		SELECT is_encoding('Some characters', 'LATIN1', 'UTF8') AS isencoding
			, 0 AS zero
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
		SELECT is_encoding('Some characters, ğ is Turkish and not latin1', 'LATIN1', 'UTF8') AS isencoding
			, 0 AS zero
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

SELECT 'Test starting: function_is_latin1' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_latin1'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with a test string containing only latin1
WITH test AS
	(
		SELECT is_latin1('Some characters') AS islatin1
			, 0 AS zero
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
		SELECT is_latin1('Some characters, ğ is Turkish and not latin1') AS islatin1
			, 0 AS zero
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

SELECT 'Test starting: function_return_not_part_of_latin1' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'return_not_part_of_latin1'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res
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

ROLLBACK;

SELECT 'Test starting: function_replace_encoding' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'replace_encoding'
	)
SELECT
	CASE
		WHEN 3 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
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
		SELECT 'ağbƵcğeƵ'::TEXT AS test_string
			, 'latin1'::TEXT AS enc
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
		SELECT 'ağbcğe'::TEXT AS test_string
			, 'latin1'::TEXT AS enc
			, 'g'::TEXT AS replacement
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
		SELECT 'ağbƵcğeƵ'::TEXT AS test_string
			, string_to_array('ğ,Ƶ'::TEXT, ',') AS to_replace
			, string_to_array('g,Z'::TEXT, ',') AS replacement
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

SELECT 'Test starting: function_replace_latin1' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'replace_latin1'
	)
SELECT
	CASE
		WHEN 3 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res
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
		SELECT 'ağbƵcğeƵ'::TEXT AS test_string
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
		SELECT 'ağbcğe'::TEXT AS test_string
			, 'g'::TEXT AS replacement
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
		SELECT 'ağbƵcğeƵ'::TEXT AS test_string
			, string_to_array('ğ,Ƶ'::TEXT, ',') AS to_replace
			, string_to_array('g,Z'::TEXT, ',') AS replacement
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

SELECT 'Test starting: function_return_not_part_of_encoding' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'return_not_part_of_encoding'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res
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

SELECT 'Test starting: aggregate_function_gap_fill' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'gap_fill_internal'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test if the aggregate exists
WITH test AS
	(
		SELECT count(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'gap_fill'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Create a table with some test values
CREATE TABLE test_gap_fill(id INTEGER, some_value text);

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
			, 0 AS zero
		FROM test_gap_fill
	)
SELECT
	CASE
		WHEN count(*) / count(*) FILTER (WHERE NOT some_value IS NULL) = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM t1
GROUP BY zero
;

ROLLBACK;

SELECT 'Test starting: function_date_de' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'date_de'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
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

SELECT 'Test starting: function_datetime_de' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'datetime_de'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
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

SELECT 'Test starting: function_to_unix_timestamp' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'to_unix_timestamp'
	)
SELECT
	CASE
		WHEN 2 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with timestamp without time zone
WITH test AS
	(
		SELECT to_unix_timestamp('2018-01-01 00:00:00') AS unix_timestamp
			, 0 AS zero
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
WITH t1 AS
	(
		SELECT to_unix_timestamp(now()) AS unix_timestamp
	)
, test AS
	(
		SELECT
			CASE
				WHEN unix_timestamp > 0 THEN
					1
				ELSE
					0
			END AS res
		FROM t1
	)
SELECT (1 / res)::BOOLEAN AS res
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_is_empty' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_empty'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test not empty
WITH test AS
	(
		SELECT is_empty('abc') AS isempty
			, 0 AS zero
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
		SELECT is_empty('') AS isempty
			, 0 AS zero
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
		SELECT NULL::TEXT AS test_value
	)
, test AS
	(
		SELECT is_empty(test_value) AS isempty
			, 0 AS zero
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

SELECT 'Test starting: function_array_max' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'array_max'
	)
SELECT
	CASE
		WHEN 7 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res
FROM test
;

-- Test if all seven implementations exists
WITH test AS
	(
		SELECT count(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'array_max'
	)
SELECT
	CASE
		WHEN test.exist = 7 THEN
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
		SELECT array_max(ARRAY[45, 60, 43, 99]::SMALLINT[]) AS max_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN max_value = 99 THEN
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
		SELECT array_max(ARRAY[45, 60, 43, 99]::INTEGER[]) AS max_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN max_value = 99 THEN
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
		SELECT array_max(ARRAY[45, 60, 43, 99]::BIGINT[]) AS max_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN max_value = 99 THEN
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
		SELECT array_max(ARRAY['def', 'abc', 'ghi']::TEXT[]) AS max_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN max_value = 'ghi' THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the fifth implementation
-- REAL ARRAY
WITH test AS
	(
		SELECT array_max(ARRAY[45.6, 60.8, 43, 99.3]::REAL[]) AS max_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN max_value = 99.3 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the sixth implementation
-- DOUBLE PRECISION ARRAY
WITH test AS
	(
		SELECT array_max(ARRAY[45.6, 60.8, 43, 99.3]::DOUBLE PRECISION[]) AS max_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN max_value = 99.3 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the seventh implementation
-- NUMERIC ARRAY
WITH test AS
	(
		SELECT array_max(ARRAY[45.6, 60.8, 43, 99.3]::NUMERIC[]) AS max_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN max_value = 99.3 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_array_min' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'array_min'
	)
SELECT
	CASE
		WHEN 7 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res
FROM test
;

-- Test if all seven implementations exists
WITH test AS
	(
		SELECT count(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'array_min'
	)
SELECT
	CASE
		WHEN test.exist = 7 THEN
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

-- Test of the fifth implementation
-- REAL ARRAY
WITH test AS
	(
		SELECT array_min(ARRAY[45.6, 60.8, 43.7, 99.3]::REAL[]) AS min_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN min_value = 43.7 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the sixth implementation
-- DOUBLE PRECISION ARRAY
WITH test AS
	(
		SELECT array_min(ARRAY[45.6, 60.8, 43.7, 99.3]::DOUBLE PRECISION[]) AS min_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN min_value = 43.7 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the seventh implementation
-- NUMERIC ARRAY
WITH test AS
	(
		SELECT array_min(ARRAY[45.6, 60.8, 43.7, 99.3]::NUMERIC[]) AS min_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN min_value = 43.7 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_array_avg' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'array_avg'
	)
SELECT
	CASE
		WHEN 6 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res
FROM test
;

-- Test if all six implementations exists
WITH test AS
	(
		SELECT count(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'array_avg'
	)
SELECT
	CASE
		WHEN test.exist = 6 THEN
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
		WHEN avg_value = 61.75 THEN
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
		WHEN avg_value = 61.75 THEN
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
		WHEN avg_value = 61.75 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the fourth implementation
-- REAL ARRAY
WITH test_data AS
	(
		SELECT 45.6::REAL AS val
		UNION ALL
		SELECT 60.8::REAL
		UNION ALL
		SELECT 43::REAL
		UNION ALL
		SELECT 99.3::REAL
	)
, test AS
	(
		SELECT array_avg(ARRAY[45.6, 60.8, 43, 99.3]::REAL[]) AS avg_value
			, 0 AS zero
			, avg(val) AS test_val
		FROM test_data
	)
SELECT
	CASE
		WHEN avg_value::NUMERIC = test_val::NUMERIC THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
		END AS res_1
FROM test
;

-- Test of the fifth implementation
-- DOUBLE PRECISION ARRAY
WITH test_data AS
	(
		SELECT 45.6::DOUBLE PRECISION AS val
		UNION ALL
		SELECT 60.8::DOUBLE PRECISION
		UNION ALL
		SELECT 43::DOUBLE PRECISION
		UNION ALL
		SELECT 99.3::DOUBLE PRECISION
	)
, test AS
	(
		SELECT array_avg(ARRAY[45.6, 60.8, 43, 99.3]::DOUBLE PRECISION[]) AS avg_value
			, 0 AS zero
			, avg(val) AS test_val
			FROM test_data
	)
SELECT
	CASE
		WHEN avg_value::NUMERIC = test_val::NUMERIC THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the sicth implementation
-- NUMERIC ARRAY
WITH test_data AS
	(
		SELECT 45.6::NUMERIC AS val
		UNION ALL
		SELECT 60.8::NUMERIC
		UNION ALL
		SELECT 43::NUMERIC
		UNION ALL
		SELECT 99.3::NUMERIC
	)
, test AS
	(
		SELECT array_avg(ARRAY[45.6, 60.8, 43, 99.3]::NUMERIC[]) AS avg_value
			, 0 AS zero
			, avg(val) AS test_val
			FROM test_data
	)
SELECT
	CASE
		WHEN avg_value::NUMERIC = test_val::NUMERIC THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_array_sum' AS next_test;
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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'array_sum'
	)
SELECT
	CASE
		WHEN 6 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res
FROM test
;

-- Test if all six implementations exists
WITH test AS
	(
		SELECT count(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'array_sum'
		)
SELECT
	CASE
		WHEN test.exist = 6 THEN
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

-- Test of the fourth implementation
-- REAL ARRAY
WITH test AS
	(
		SELECT array_sum(ARRAY[45.6, 60.8, 43.7, 99.3]::REAL[]) AS sum_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN sum_value = 249.4 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the fifth implementation
-- DOUBLE PRECISION ARRAY
WITH test AS
	(
		SELECT array_sum(ARRAY[45.6, 60.8, 43.7, 99.3]::DOUBLE PRECISION[]) AS sum_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN sum_value = 249.4 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the sixth implementation
-- NUMERIC ARRAY
WITH test AS
	(
		SELECT array_sum(ARRAY[45.6, 60.8, 43.7, 99.3]::NUMERIC[]) AS sum_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN sum_value = 249.4 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_array_trim' AS next_test;
/**
 * Test for the functions array_trim
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT count(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'array_trim'
	)
SELECT
	CASE
		WHEN 10 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test if all six implementations exists
WITH test AS
	(
		SELECT count(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'array_trim'
		)
SELECT
	CASE
		WHEN test.exist = 10 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res
FROM test
;

-- Test of the first implementation
-- text ARRAY
WITH test AS
	(
		SELECT array_trim(ARRAY['test',NULL,'test']) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY['test','test']::text[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;
-- text ARRAY WITHOUT DUPLICATES
WITH test AS
	(
		SELECT array_trim(ARRAY['test',NULL,'test'], TRUE) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY['test']::text[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the second implementation
-- SMALLINT ARRAY
WITH test AS
	(
		SELECT array_trim(ARRAY[1,NULL,1]::SMALLINT[]) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[1,1]::SMALLINT[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;
-- SMALLINT ARRAY WITHOUT DUPLICATES
WITH test AS
	(
		SELECT array_trim(ARRAY[1,NULL,1]::SMALLINT[], TRUE) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[1]::SMALLINT[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the third implementation
-- INTEGER ARRAY
WITH test AS
	(
		SELECT array_trim(ARRAY[1,NULL,1]) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[1,1]::INTEGER[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;
-- INTEGER ARRAY WITHOUT DUPLICATES
WITH test AS
	(
		SELECT array_trim(ARRAY[1,NULL,1], TRUE) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[1]::INTEGER[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the fourth implementation
-- BIGINT ARRAY
WITH test AS
	(
		SELECT array_trim(ARRAY[123456789012,NULL,123456789012]) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[123456789012,123456789012]::BIGINT[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;
-- BIGINT ARRAY WITHOUT DUPLICATES
WITH test AS
	(
		SELECT array_trim(ARRAY[123456789012,NULL,123456789012], TRUE) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[123456789012]::BIGINT[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the fifth implementation
-- NUMERIC ARRAY
WITH test AS
	(
		SELECT array_trim(ARRAY[1.23456789012,NULL,1.23456789012]) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[1.23456789012,1.23456789012]::NUMERIC[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;
-- NUMERIC ARRAY WITHOUT DUPLICATES
WITH test AS
	(
		SELECT array_trim(ARRAY[1.23456789012,NULL,1.23456789012], TRUE) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[1.23456789012]::NUMERIC[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the sixth implementation
-- REAL ARRAY
WITH test AS
	(
		SELECT array_trim(ARRAY[1.23456789012::REAL,NULL,1.23456789012::REAL]) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[1.23456789012::REAL,1.23456789012::REAL] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;
-- REAL ARRAY WITHOUT DUPLICATES
WITH test AS
	(
		SELECT array_trim(ARRAY[1.23456789012::REAL,NULL,1.23456789012::REAL], TRUE) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[1.23456789012::REAL] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the seventh implementation
-- DOUBLE PRECISION ARRAY
WITH test AS
	(
		SELECT array_trim(ARRAY[1.23456789012::DOUBLE PRECISION,NULL,1.23456789012::DOUBLE PRECISION]) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[1.23456789012::DOUBLE PRECISION,1.23456789012::DOUBLE PRECISION] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;
-- DOUBLE PRECISION ARRAY WITHOUT DUPLICATES
WITH test AS
	(
		SELECT array_trim(ARRAY[1.23456789012::DOUBLE PRECISION,NULL,1.23456789012::DOUBLE PRECISION], TRUE) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[1.23456789012::DOUBLE PRECISION] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the eigth implementation
-- DATE ARRAY
WITH test AS
	(
		SELECT array_trim(ARRAY['2018-11-11',NULL,'2018-11-11']::DATE[]) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY['2018-11-11','2018-11-11']::DATE[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;
-- DATE ARRAY WITHOUT DUPLICATES
WITH test AS
	(
		SELECT array_trim(ARRAY['2018-11-11',NULL,'2018-11-11']::DATE[], TRUE) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY['2018-11-11']::DATE[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the ninth implementation
-- TIMESTAMP ARRAY
WITH test AS
	(
		SELECT array_trim(ARRAY['2018-11-11 11:00:00',NULL,'2018-11-11 11:00:00']::TIMESTAMP[]) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY['2018-11-11 11:00:00','2018-11-11 11:00:00']::TIMESTAMP[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;
-- TIMESTAMP ARRAY WITHOUT DUPLICATES
WITH test AS
	(
		SELECT array_trim(ARRAY['2018-11-11 11:00:00',NULL,'2018-11-11 11:00:00']::TIMESTAMP[], TRUE) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY['2018-11-11 11:00:00']::TIMESTAMP[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the tenth implementation
-- TIMESTAMP WITH TIME ZONE ARRAY
WITH test AS
	(
		SELECT array_trim(ARRAY['2018-11-11 11:00:00 MEZ',NULL,'2018-11-11 11:00:00 MEZ']::TIMESTAMP WITH TIME ZONE[]) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY['2018-11-11 11:00:00 MEZ','2018-11-11 11:00:00 MEZ']::TIMESTAMP WITH TIME ZONE[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;
-- TIMESTAMP WITH TIME ZONE ARRAY WITHOUT DUPLICATES
WITH test AS
	(
		SELECT array_trim(ARRAY['2018-11-11 11:00:00 MEZ',NULL,'2018-11-11 11:00:00 MEZ']::TIMESTAMP WITH TIME ZONE[], TRUE) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY['2018-11-11 11:00:00 MEZ']::TIMESTAMP WITH TIME ZONE[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

ROLLBACK;

SELECT 'Test starting: view_pg_active_locks' AS next_test;
/**
 * Test for view pg_active_locks
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the view exists
WITH test AS
	(
		SELECT COUNT(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_views
		WHERE viewname = 'pg_active_locks'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
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

SELECT 'Test starting: view_pg_object_ownership' AS next_test;
/**
 * Test for view pg_object_ownership
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;
		WITH test AS
			(
				SELECT COUNT(*) AS exist
					, 0 AS zero
				FROM pg_catalog.pg_views
				WHERE viewname = 'pg_object_ownership'
			)
		SELECT
			CASE
				WHEN 1 / test.exist = 1 THEN
					TRUE
				ELSE
					(1 / zero)::BOOLEAN
			END AS res
		FROM test
		;

		-- Test if the view runs without errors
		WITH test AS
			(
			SELECT count(*) as key_count
					, 0 AS zero
			FROM pg_object_ownership
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

SELECT 'Test starting: view_pg_bloat_info' AS next_test;
/**
 * Test for view pg_bloat_info
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT COUNT(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_views
		WHERE viewname = 'pg_bloat_info'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
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

SELECT 'Test starting: view_pg_unused_indexes' AS next_test;
/**
 * Test for view pg_unused_indexes
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT COUNT(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_views
		WHERE viewname = 'pg_unused_indexes'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
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

SELECT 'Test starting: function_hex2bigint' AS next_test;
/**
 * Test for function hex2bigint
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT COUNT(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'hex2bigint'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test hexadicimal conversion
WITH test AS
	(
		SELECT hex2bigint('a1b0') = 41392 AS int_result
			, 0 AS zero
	)
SELECT
	CASE
		WHEN int_result THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_is_hex' AS next_test;
/**
 * Test for function is_hex
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT COUNT(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_hex'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test hexadicimal number
WITH test AS
	(
		SELECT is_hex('a1b0') AS ishex
			, 0 AS zero
	)
SELECT
	CASE
		WHEN ishex THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a non hexadeciaml number
WITH test AS
	(
		SELECT is_hex('a1b0w') AS ishex
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT ishex THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a hexadeciaml number, that is to big for BIGINT
WITH test AS
	(
		SELECT is_hex('a1b0c3c3c3c4b5d3') AS ishex
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT ishex THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_is_bigint_array' AS next_test;
/**
 * Test for function is_bigint
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT COUNT(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_bigint_array'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test integer array
WITH test AS
	(
		SELECT is_bigint_array('{1,2}') AS isbigint_array
			, 0 AS zero
	)
SELECT
	CASE
		WHEN isbigint_array THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a with wrong brackets, not a bigint array
WITH test AS
	(
		SELECT is_bigint_array('[123,456]') AS isbigint_array
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isbigint_array THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with out of range value, not a bigint array
WITH test AS
	(
		SELECT is_bigint_array('{32435463435745636545,1}') AS isbigint_array
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isbigint_array THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_is_integer_array' AS next_test;
/**
 * Test for function is_integer_array
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT COUNT(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_integer_array'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test integer array
WITH test AS
	(
		SELECT is_integer_array('{1,2,3}') AS isinteger_array
			, 0 AS zero
	)
SELECT
	CASE
		WHEN isinteger_array THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a with wrong brackets, not an integer array
WITH test AS
	(
		SELECT is_integer_array('[123,456]') AS isinteger_array
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isinteger_array THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with out of range value, not an integer array
WITH test AS
	(
		SELECT is_integer_array('{3243546343,789879}') AS isinteger_array
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isinteger_array THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_is_smallint_array' AS next_test;
/**
 * Test for function is_smallint_array
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT COUNT(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_smallint_array'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test smallint array
WITH test AS
	(
		SELECT is_smallint_array('{1,2,3}') AS issmallint_array
			, 0 AS zero
	)
SELECT
	CASE
		WHEN issmallint_array THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a with wrong brackets, not an integer array
WITH test AS
	(
		SELECT is_smallint_array('[123,456]') AS issmallint_array
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT issmallint_array THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with out of range value, not an integer array
WITH test AS
	(
		SELECT is_smallint_array('{3243546343,789879}') AS issmallint_array
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT issmallint_array THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

SELECT 'Test starting: function_is_text_array' AS next_test;
/**
 * Test for function is_text_array
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT COUNT(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_text_array'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test text array
WITH test AS
	(
		SELECT is_text_array('{a,b,c}') AS istext_array
			, 0 AS zero
	)
SELECT
	CASE
		WHEN istext_array THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a with wrong brackets, not an integer array
WITH test AS
	(
		SELECT is_text_array('[123,456]') AS istext_array
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT istext_array THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number, an integer array
WITH test AS
	(
		SELECT is_text_array('{3243546343,789879}') AS istext_array
			, 0 AS zero
	)
SELECT
	CASE
		WHEN istext_array THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;

