/**
 * Test for the functions array_max
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
	(
		SELECT count(*) AS exist
		FROM pg_catalog.pg_proc
		WHERE proname = 'array_max'
  )
SELECT 7 / test.exist = 1 AS res
FROM test
;

-- Test if all seven implementations exists
WITH test AS
  (
    SELECT count(*) AS exist
      , 0 AS zero
    FROM pg_catalog.pg_proc
    WHERE proname = 'array_max'
  )
SELECT
	CASE
    	WHEN test.exist = 7 THEN
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
		SELECT array_max(ARRAY[45, 60, 43, 99]::SMALLINT[]) AS max_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN max_value = 99 THEN
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
		SELECT array_max(ARRAY[45, 60, 43, 99]::INTEGER[]) AS max_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN max_value = 99 THEN
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
		SELECT array_max(ARRAY[45, 60, 43, 99]::BIGINT[]) AS max_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN max_value = 99 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

-- Test of the fourth implementation
-- TEXT ARRAY
WITH test AS
	(
		SELECT array_max(ARRAY['def', 'abc', 'ghi']::TEXT[]) AS max_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN max_value = 'ghi' THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

-- Test of the fifth implementation
-- REAL ARRAY
WITH test AS
	(
		SELECT array_max(ARRAY[45.6, 60.8, 43, 99.3]::REAL[]) AS max_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN max_value = 99.3 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

-- Test of the sixth implementation
-- DOUBLE PRECISION ARRAY
WITH test AS
	(
		SELECT array_max(ARRAY[45.6, 60.8, 43, 99.3]::DOUBLE PRECISION[]) AS max_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN max_value = 99.3 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

-- Test of the seventh implementation
-- NUMERIC ARRAY
WITH test AS
	(
		SELECT array_max(ARRAY[45.6, 60.8, 43, 99.3]::NUMERIC[]) AS max_value
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN max_value = 99.3 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
  END AS res_1
FROM test
;

ROLLBACK;
