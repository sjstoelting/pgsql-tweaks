/**
 * Test for function is_latin1
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'is_latin1'
  )
SELECT 1 / test.exist = 1 AS res
FROM test
;

-- Test with a test string containing only latin1
WITH test AS
	(
		SELECT is_latin1('Some characters') AS islatin1, 0 AS zero
	)
SELECT
	CASE
		WHEN islatin1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with a test string containing non latin1 characters
WITH test AS
	(
		SELECT is_latin1('Some characters, ğ is Turkish and not latin1') AS islatin1, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT islatin1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;
