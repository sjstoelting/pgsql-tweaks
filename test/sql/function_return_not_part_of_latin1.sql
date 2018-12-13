/**
 * Test for the functions return_not_part_of_latin1
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT count(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'return_not_part_of_latin1'
	)
SELECT
	CASE
		WHEN 1 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res
FROM test
;

-- Test the returning result which should contain two array elements
with test AS
	(
		SELECT return_not_part_of_latin1('ağbƵcğeƵ') AS res
			, 0 AS zero
	)
SELECT
	CASE
		WHEN array_length(res, 1) = 2 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END as res_1
	, CASE
		WHEN 'ğ' = ANY (res) AND 'Ƶ' = ANY (res) THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END as res_2
FROM test
;

ROLLBACK;
