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
