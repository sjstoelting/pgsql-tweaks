/**
 * Test for the aggregate gap_fill
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT count(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'gap_fill_internal'
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

-- Test if the aggregate exists
WITH test AS
	(
		SELECT count(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'gap_fill'
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

-- Create a table with some test values
CREATE TABLE test_gap_fill(id INTEGER, some_value text);

INSERT INTO test_gap_fill(id, some_value) VALUES
	(1, 'value 1'),
	(1, NULL),
	(2, 'value 2'),
	(2, NULL),
	(2, NULL),
	(3, 'value 3')
;

-- Select the test data and return filled columns, the count of colums should be
-- the same number as the count of not empty ones
WITH t1 AS
	(
		SELECT id
			, gap_fill(some_value) OVER (ORDER BY id) AS some_value
			, 0 AS zero
		FROM test_gap_fill
	)
SELECT
	CASE
		WHEN count(*) / count(*) FILTER (WHERE NOT some_value IS NULL) = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM t1
GROUP BY zero
;

ROLLBACK;
