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
SELECT 1 / test.exist AS res
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
