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
/**
 * As there has been a behaviour change in PostgreSQL 10, the result is only
 * false with version 10 in <9 it would be true a call to
 * SELECT to_timestamp('25:33:55.456574', 'HH24.MI.SS,US')::TIME;
 * would return 01:33:55.456574
 */
WITH test AS
	(
	SELECT is_time('25.33.55,456574', 'HH24.MI.SS,US') AS istime
		, 0 AS zero
		, current_setting('server_version_num')::INTEGER as version_num
	)
SELECT
	CASE
		WHEN version_num >= 100000 THEN
			CASE
				WHEN NOT istime THEN
					TRUE
				ELSE
					(1 / zero)::BOOLEAN
			END
		ELSE
			CASE
				WHEN istime THEN
					TRUE
				ELSE
					(1 / zero)::BOOLEAN
			END
	END AS res
FROM test
;

ROLLBACK;
