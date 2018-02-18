/**
 * Test for the functions array_avg
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT count(*) AS exist
		FROM pg_catalog.pg_proc
		WHERE proname = 'array_avg'
  )
SELECT 3 / test.exist = 1 AS res
FROM test
;

-- Test if all three implementations exists
WITH test AS
  (
    SELECT count(*) AS exist
      , 0 AS zero
    FROM pg_catalog.pg_proc
    WHERE proname = 'array_avg'
  )
SELECT
	CASE
    	WHEN test.exist = 3 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res
FROM test
;

-- Test of the first implementation
-- SMALLINT ARRAY
WITH test AS
	(
		SELECT array_avg(ARRAY[45, 60, 43, 99]::SMALLINT[]) AS avg_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN avg_value = 62 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

-- Test of the second implementation
-- INTEGER ARRAY
WITH test AS
	(
		SELECT array_avg(ARRAY[45, 60, 43, 99]::INTEGER[]) AS avg_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN avg_value = 62 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

-- Test of the third implementation
-- BIGINT ARRAY
WITH test AS
	(
		SELECT array_avg(ARRAY[45, 60, 43, 99]::BIGINT[]) AS avg_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN avg_value = 62 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

ROLLBACK;
