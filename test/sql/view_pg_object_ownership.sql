/**
 * Test for view pg_object_ownership
 *
 * Every test does raise division by zero if it failes
 */
DO $$
DECLARE
	version_greater_10 BOOLEAN;
	res BOOLEAN;
BEGIN
	SELECT to_number((string_to_array(version(), ' '))[2], '999.99') >= 10 INTO version_greater_10;

	IF version_greater_10 THEN
		-- Test if the view exists
		WITH test AS
			(
				SELECT COUNT(*) AS exist
					, 0 AS zero
				FROM pg_catalog.pg_views
				WHERE viewname = 'pg_object_ownership'
			)
		SELECT
			CASE
				WHEN 1 / test.exist = 1 THEN
					TRUE
				ELSE
					(1 / zero)::BOOLEAN
			END AS res
		FROM test
		INTO res
		;

		-- Test if the view runs without errors
		WITH test AS
			(
			SELECT count(*) as key_count
					, 0 AS zero
			FROM pg_object_ownership
			)
		SELECT
			CASE
				WHEN key_count >= 0 THEN
					TRUE
				ELSE
					(1 / zero)::BOOLEAN
			END AS res
		FROM test
		INTO res
		;

		ROLLBACK;
	END IF;

END $$;
