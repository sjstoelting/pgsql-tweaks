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
