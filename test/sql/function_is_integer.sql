/**
 * Test for function is_integer
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
		WHERE proname = 'is_integer'
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

-- Test integer
WITH test AS
	(
		SELECT is_integer('123') AS isinteger
			, 0 AS zero
	)
SELECT
	CASE
		WHEN isinteger THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with decimal separator, not an integer
WITH test AS
	(
		SELECT is_integer('123.456') AS isinteger
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isinteger THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with out of range value, not an integer
WITH test AS
	(
		SELECT is_integer('3243546343') AS isinteger
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isinteger THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;
