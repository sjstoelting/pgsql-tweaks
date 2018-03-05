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
SELECT 2 / test.exist = 1 AS res
FROM test
;

-- Test if all implementations exists
WITH test AS
	(
		SELECT COUNT(*) AS exist
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_encoding'
	)
SELECT test.exist = 2 AS res
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
