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
