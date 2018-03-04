/**
 * Test for function is_bigint
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'is_bigint'
  )
SELECT 1 / test.exist = 1 AS res
FROM test
;

-- Test integer
WITH test AS
	(
		SELECT is_bigint('123') AS isbigint, 0 AS zero
	)
SELECT
	CASE
		WHEN isbigint THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with decimal separator, not a bigint
WITH test AS
	(
		SELECT is_bigint('123.456') AS isbigint, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isbigint THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with out of range value, not a bigint
WITH test AS
	(
		SELECT is_bigint('32435463435745636545') AS isbigint, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isbigint THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;
