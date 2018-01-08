/**
 * Test for function is_encoding
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'is_encoding'
  )
SELECT 1 / test.exist AS res
FROM test
;

-- Test with a test string containing only latin1
WITH test AS
	(
		SELECT is_encoding('Some characters', 'LATIN1') AS isencoding, 0 AS zero
	)
SELECT
	CASE
		WHEN isencoding THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with a test string containing non latin1 characters
WITH test AS
	(
		SELECT is_encoding('Some characters, ğ is Turkish and not latin1', 'LATIN1') AS isencoding, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isencoding THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with a test string containing only latin1
WITH test AS
	(
		SELECT is_encoding('Some characters', 'LATIN1', 'UTF8') AS isencoding, 0 AS zero
	)
SELECT
	CASE
		WHEN isencoding THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with a test string containing non latin1 characters
WITH test AS
	(
		SELECT is_encoding('Some characters, ğ is Turkish and not latin1', 'LATIN1', 'UTF8') AS isencoding, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isencoding THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;
