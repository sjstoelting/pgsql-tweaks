/**
 * Test for function is_smallint
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'is_smallint'
  )
SELECT 1 / test.exist = 1 AS res
FROM test
;

-- Test integer
WITH test AS
	(
		SELECT is_smallint('123') AS isnum, 0 AS zero
	)
SELECT
	CASE
		WHEN isnum THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with decimal separator, not a smallint
WITH test AS
	(
		SELECT is_smallint('123.456') AS isnum, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isnum THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with out of range value, not a smallint
WITH test AS
	(
		SELECT is_smallint('3243546343') AS isnum, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isnum THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;
