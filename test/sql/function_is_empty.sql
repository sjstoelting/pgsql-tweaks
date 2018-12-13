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
