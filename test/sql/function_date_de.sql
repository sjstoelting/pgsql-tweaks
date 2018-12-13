/**
 * Test for function date_de
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
		WHERE proname = 'date_de'
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

-- Uses function is_date which is part of this repository
WITH test AS
	(
		SELECT date_de('2018-01-01') AS d_de
			, 0 AS zero
	)
SELECT
	CASE
		WHEN is_date(d_de, 'DD.MM.YYYY') THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;
