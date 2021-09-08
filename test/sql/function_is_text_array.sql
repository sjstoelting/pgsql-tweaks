/**
 * Test for function is_text_array
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
		WHERE proname = 'is_text_array'
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

-- Test text array
WITH test AS
	(
		SELECT is_text_array('{a,b,c}') AS istext_array
			, 0 AS zero
	)
SELECT
	CASE
		WHEN istext_array THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a with wrong brackets, not an integer array
WITH test AS
	(
		SELECT is_text_array('[123,456]') AS istext_array
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT istext_array THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test a number, an integer array
WITH test AS
	(
		SELECT is_text_array('{3243546343,789879}') AS istext_array
			, 0 AS zero
	)
SELECT
	CASE
		WHEN istext_array THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;
