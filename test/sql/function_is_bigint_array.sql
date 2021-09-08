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
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_bigint_array'
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

-- Test integer array
WITH test AS
	(
		SELECT is_bigint_array('{1,2}') AS isbigint_array
			, 0 AS zero
	)
SELECT
	CASE
		WHEN isbigint_array THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a with wrong brackets, not a bigint array
WITH test AS
	(
		SELECT is_bigint_array('[123,456]') AS isbigint_array
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isbigint_array THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number with out of range value, not a bigint array
WITH test AS
	(
		SELECT is_bigint_array('{32435463435745636545,1}') AS isbigint_array
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isbigint_array THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;
