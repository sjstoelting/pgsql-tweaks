/**
 * Test for function pg_schema_size
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
		WHERE proname = 'pg_schema_size'
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

-- Prevent no result because of an empty database without any tables
-- Create at table
CREATE TABLE test_pg_schema_size(id INTEGER, some_value text);

-- Insert some data
INSERT INTO test_pg_schema_size(id, some_value) VALUES
	(1, 'value 1'),
	(1, NULL),
	(2, 'value 2'),
	(2, NULL),
	(2, NULL),
	(3, 'value 3')
;


-- Test with date in default format
WITH test AS
	(
		SELECT pg_schema_size('public') AS schema_size
			, 0 AS zero
	)
SELECT
	CASE
		WHEN schema_size > 0 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;
