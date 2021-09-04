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
