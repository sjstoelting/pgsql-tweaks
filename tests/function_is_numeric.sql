/**
 * Test for function is_numeric
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'is_numeric'
  )
SELECT 1 / test.exist = 1 AS res
FROM test
;

-- Test integer
WITH test AS
	(
		SELECT is_numeric('123') AS isnum, 0 AS zero
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

-- Test a number with decimal separator
WITH test AS
	(
		SELECT is_numeric('123.456') AS isnum, 0 AS zero
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

-- Test not a number
WITH test AS
	(
		SELECT is_numeric('1 2') AS isnum, 0 AS zero
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
