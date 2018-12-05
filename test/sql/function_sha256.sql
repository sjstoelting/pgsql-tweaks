/**
 * Test for function sha256
 *
 * Every test does raise division by zero if it failes
 */
DO $$
DECLARE
	pg_extension_installed BOOLEAN;
BEGIN

	SELECT count(*) = 1 AS pgcrypto_installed FROM pg_extension WHERE extname = 'pgcrypto' INTO pg_extension_installed;

	IF pg_extension_installed THEN
		-- The pgcrypto extension is installed, sha256 should be installed, that will be tested
		WITH test AS
			(
				SELECT COUNT(*) AS exist
				FROM pg_catalog.pg_proc
				WHERE proname = 'sha256'
			)
		SELECT 1 / test.exist = 1 AS res
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

	END IF;

END $$;
