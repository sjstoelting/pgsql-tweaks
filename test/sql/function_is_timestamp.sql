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
