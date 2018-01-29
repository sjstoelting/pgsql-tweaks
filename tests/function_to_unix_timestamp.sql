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
