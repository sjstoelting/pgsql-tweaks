/**
 * Test for function is_hex
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
		WHERE proname = 'is_hex'
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

-- Test hexadicimal number
WITH test AS
	(
		SELECT is_hex('a1b0') AS ishex
			, 0 AS zero
	)
SELECT
	CASE
		WHEN ishex THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a non hexadeciaml number
WITH test AS
	(
		SELECT is_hex('a1b0w') AS ishex
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT ishex THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a hexadeciaml number, that is to big for BIGINT
WITH test AS
	(
		SELECT is_hex('a1b0c3c3c3c4b5d3') AS ishex
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT ishex THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;
