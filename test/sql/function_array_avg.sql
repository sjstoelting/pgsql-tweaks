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
SELECT 6 / test.exist = 1 AS res
FROM test
;

-- Test if all six implementations exists
WITH test AS
  (
    SELECT count(*) AS exist
      , 0 AS zero
    FROM pg_catalog.pg_proc
    WHERE proname = 'array_avg'
  )
SELECT
	CASE
    	WHEN test.exist = 6 THEN
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
		WHEN avg_value = 61.75 THEN
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
		WHEN avg_value = 61.75 THEN
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
		WHEN avg_value = 61.75 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

-- Test of the fourth implementation
-- REAL ARRAY
WITH test_data AS
	(
		SELECT 45.6::REAL AS val
		UNION ALL
		SELECT 60.8::REAL
		UNION ALL
		SELECT 43::REAL
		UNION ALL
		SELECT 99.3::REAL
	)
, test AS
	(
		SELECT array_avg(ARRAY[45.6, 60.8, 43, 99.3]::REAL[]) AS avg_value
	    	, 0 AS zero
			, avg(val) AS test_val
		FROM test_data
	)
SELECT
	CASE
		WHEN avg_value::NUMERIC = test_val::NUMERIC THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

-- Test of the fifth implementation
-- DOUBLE PRECISION ARRAY
WITH test_data AS
	(
		SELECT 45.6::DOUBLE PRECISION AS val
		UNION ALL
		SELECT 60.8::DOUBLE PRECISION
		UNION ALL
		SELECT 43::DOUBLE PRECISION
		UNION ALL
		SELECT 99.3::DOUBLE PRECISION
	)
, test AS
	(
		SELECT array_avg(ARRAY[45.6, 60.8, 43, 99.3]::DOUBLE PRECISION[]) AS avg_value
		    , 0 AS zero
			, avg(val) AS test_val
			FROM test_data
	)
SELECT
	CASE
		WHEN avg_value::NUMERIC = test_val::NUMERIC THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

-- Test of the sicth implementation
-- NUMERIC ARRAY
WITH test_data AS
	(
		SELECT 45.6::NUMERIC AS val
		UNION ALL
		SELECT 60.8::NUMERIC
		UNION ALL
		SELECT 43::NUMERIC
		UNION ALL
		SELECT 99.3::NUMERIC
	)
, test AS
	(
		SELECT array_avg(ARRAY[45.6, 60.8, 43, 99.3]::NUMERIC[]) AS avg_value
		    , 0 AS zero
			, avg(val) AS test_val
			FROM test_data
	)
SELECT
	CASE
		WHEN avg_value::NUMERIC = test_val::NUMERIC THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

ROLLBACK;
