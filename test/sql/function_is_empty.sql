/**
 * Test for function is_empty/is_empty_b
 *
 * Every test does raise division by zero if it failes
 */
DO $$
DECLARE
	pg_extension_installed BOOLEAN;
	function_source TEXT;
BEGIN

	SELECT count(*) = 1 AS pgcrypto_installed
	FROM pg_extension
	WHERE extname = 'pgtap'
	INTO pg_extension_installed
	;

	IF NOT pg_extension_installed THEN
		-- pgtap is not installed, is_empty should be installed

		function_source :=
$string$
		-- Test if the function exists
		WITH test AS
			(
				SELECT COUNT(*) AS exist
					, 0 AS zero
				FROM pg_catalog.pg_proc
				WHERE proname = 'is_empty'
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
;
$string$
;
		EXECUTE function_source;

		-- Test not empty
		function_source :=
$string$
		WITH test AS
			(
				SELECT is_empty('abc') AS isempty
					, 0 AS zero
			)
		SELECT
			CASE
				WHEN NOT isempty THEN
					TRUE
				ELSE
					(1 / zero)::BOOLEAN
			END AS res
		FROM test
		;
$string$
;
		EXECUTE function_source;

		-- Test empty string
		function_source :=
$string$
		WITH test AS
			(
				SELECT is_empty('') AS isempty
					, 0 AS zero
			)
		SELECT
			CASE
				WHEN isempty THEN
					TRUE
				ELSE
					(1 / zero)::BOOLEAN
			END AS res
		FROM test
		;
$string$
;
		EXECUTE function_source;

		-- Test NULL
		function_source :=
$string$
		WITH test_data AS
			(
				SELECT NULL::TEXT AS test_value
			)
		, test AS
			(
				SELECT is_empty(test_value) AS isempty
					, 0 AS zero
				FROM test_data
			)
		SELECT
			CASE
				WHEN isempty THEN
					TRUE
				ELSE
					(1 / zero)::BOOLEAN
			END AS res
		FROM test
		;
$string$
;
		EXECUTE function_source;

	ELSE

		-- pgtap is installed, is_empty_b should be installed
		function_source :=
$string$
		-- Test if the function exists
		WITH test AS
			(
				SELECT COUNT(*) AS exist
					, 0 AS zero
				FROM pg_catalog.pg_proc
				WHERE proname = 'is_empty_b'
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
;
$string$
;
		EXECUTE function_source;

		-- Test not empty
		function_source :=
$string$
		WITH test AS
			(
				SELECT is_empty_b('abc') AS isempty
					, 0 AS zero
			)
		SELECT
			CASE
				WHEN NOT isempty THEN
					TRUE
				ELSE
					(1 / zero)::BOOLEAN
			END AS res
		FROM test
		;
$string$
;
		EXECUTE function_source;

		-- Test empty string
		function_source :=
$string$
		WITH test AS
			(
				SELECT is_empty_b('') AS isempty
					, 0 AS zero
			)
		SELECT
			CASE
				WHEN isempty THEN
					TRUE
				ELSE
					(1 / zero)::BOOLEAN
			END AS res
		FROM test
$string$
;
		EXECUTE function_source;

		-- Test NULL
		function_source :=
$string$
		WITH test_data AS
			(
				SELECT NULL::TEXT AS test_value
			)
		, test AS
			(
				SELECT is_empty_b(test_value) AS isempty
					, 0 AS zero
				FROM test_data
			)
		SELECT
			CASE
				WHEN isempty THEN
					TRUE
				ELSE
					(1 / zero)::BOOLEAN
			END AS res
		FROM test
		;
$string$
;
		EXECUTE function_source;

	END IF;

END $$;
