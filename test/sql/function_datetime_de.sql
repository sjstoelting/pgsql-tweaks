/**
 * Test for function datetime_de
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
		WHERE proname = 'datetime_de'
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

-- Uses function is_timestamp which is part of this repository
WITH test AS
	(
		SELECT datetime_de('2018-01-01 13:30:30 GMT') AS ts_de
			, 0 AS zero
	)
SELECT
	CASE
		WHEN is_timestamp(ts_de, 'DD.MM.YYYY HH24:MI:SS') THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;
