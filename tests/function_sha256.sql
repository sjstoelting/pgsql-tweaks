/**
 * Test for function sha256
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the pgcrypto package is installed
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_extension
    WHERE extname = 'pgcrypto'
  )
SELECT 1 / test.exist AS res
FROM test
;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'sha256'
  )
SELECT 1 / test.exist AS res
FROM test
;

-- Test with a test string
WITH test AS
	(
		SELECT sha256('test-string'::bytea) AS hashed, 'test-string'::bytea AS test_case, 0 AS zero
	)
SELECT
	CASE
		WHEN hashed = ENCODE(digest(test_case, 'sha256'), 'hex') THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;
