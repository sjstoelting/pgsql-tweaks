/**
 * Test for function is_real
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'is_real'
  )
SELECT 1 / test.exist = 1 AS res
FROM test
;

-- Test integer
WITH test AS
	(
		SELECT is_real('123') AS isreal, 0 AS zero
	)
SELECT
	CASE
		WHEN isreal THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with decimal separator
WITH test AS
	(
		SELECT is_real('123.456') AS isreal, 0 AS zero
	)
SELECT
	CASE
		WHEN isreal THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with out of range value, not an integer
WITH test AS
	(
		SELECT is_real('123,456') AS isreal, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isreal THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;
