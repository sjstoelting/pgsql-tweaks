/**
 * Test for function get_markdown_doku_by_schema
 *
 * Every test does raise division by zero if it failes
 */
DO $$
BEGIN

	WITH test AS
		(
			SELECT COUNT(*) AS exist
				, 0 AS zero
			FROM pg_catalog.pg_proc
			WHERE proname = 'get_markdown_doku_by_schema'
		)
	SELECT
		CASE
			WHEN test.exist > 0 THEN
				TRUE
			ELSE
				(1 / zero)::BOOLEAN
		END AS res
	FROM test
	;

	-- Test Markdown generaton for the current schema
	WITH test AS
		(
			SELECT get_markdown_doku_by_schema(current_schema) AS markdown
			, 0 AS zero
		)
	SELECT
		CASE
			WHEN length(markdown) > 0 THEN
				TRUE
			ELSE
				(1 / zero)::BOOLEAN
		END AS res
	FROM test
	;

END $$;
