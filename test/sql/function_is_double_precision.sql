/**
 * Test for function is_double_precision
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'is_double_precision'
  )
SELECT 1 / test.exist = 1 AS res
FROM test
;

-- Test integer
WITH test AS
	(
		SELECT is_double_precision('123') AS isdoubleprecision, 0 AS zero
	)
SELECT
	CASE
		WHEN isdoubleprecision THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with decimal separator
WITH test AS
	(
		SELECT is_double_precision('123.456') AS isdoubleprecision, 0 AS zero
	)
SELECT
	CASE
		WHEN isdoubleprecision THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with out of range value, not an integer
WITH test AS
	(
		SELECT is_double_precision('123,456') AS isdoubleprecision, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isdoubleprecision THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;
