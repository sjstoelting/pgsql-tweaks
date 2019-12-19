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
