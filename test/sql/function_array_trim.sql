/**
 * Test for the functions array_trim
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
		WHERE proname = 'array_trim'
	)
SELECT
	CASE
		WHEN 10 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test if all six implementations exists
WITH test AS
	(
		SELECT count(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'array_trim'
		)
SELECT
	CASE
		WHEN test.exist = 10 THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res
FROM test
;

-- Test of the first implementation
-- VARCHAR ARRAY
WITH test AS
	(
		SELECT array_trim(ARRAY['test',NULL,'test']) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY['test','test']::VARCHAR[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;
-- VARCHAR ARRAY WITHOUT DUPLICATES
WITH test AS
	(
		SELECT array_trim(ARRAY['test',NULL,'test'], TRUE) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY['test']::VARCHAR[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the second implementation
-- SMALLINT ARRAY
WITH test AS
	(
		SELECT array_trim(ARRAY[1,NULL,1]::SMALLINT[]) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[1,1]::SMALLINT[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;
-- SMALLINT ARRAY WITHOUT DUPLICATES
WITH test AS
	(
		SELECT array_trim(ARRAY[1,NULL,1]::SMALLINT[], TRUE) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[1]::SMALLINT[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the third implementation
-- INTEGER ARRAY
WITH test AS
	(
		SELECT array_trim(ARRAY[1,NULL,1]) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[1,1]::INTEGER[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;
-- INTEGER ARRAY WITHOUT DUPLICATES
WITH test AS
	(
		SELECT array_trim(ARRAY[1,NULL,1], TRUE) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[1]::INTEGER[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the fourth implementation
-- BIGINT ARRAY
WITH test AS
	(
		SELECT array_trim(ARRAY[123456789012,NULL,123456789012]) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[123456789012,123456789012]::BIGINT[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;
-- BIGINT ARRAY WITHOUT DUPLICATES
WITH test AS
	(
		SELECT array_trim(ARRAY[123456789012,NULL,123456789012], TRUE) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[123456789012]::BIGINT[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the fifth implementation
-- NUMERIC ARRAY
WITH test AS
	(
		SELECT array_trim(ARRAY[1.23456789012,NULL,1.23456789012]) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[1.23456789012,1.23456789012]::NUMERIC[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;
-- NUMERIC ARRAY WITHOUT DUPLICATES
WITH test AS
	(
		SELECT array_trim(ARRAY[1.23456789012,NULL,1.23456789012], TRUE) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[1.23456789012]::NUMERIC[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the sixth implementation
-- REAL ARRAY
WITH test AS
	(
		SELECT array_trim(ARRAY[1.23456789012::REAL,NULL,1.23456789012::REAL]) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[1.23456789012::REAL,1.23456789012::REAL] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;
-- REAL ARRAY WITHOUT DUPLICATES
WITH test AS
	(
		SELECT array_trim(ARRAY[1.23456789012::REAL,NULL,1.23456789012::REAL], TRUE) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[1.23456789012::REAL] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the seventh implementation
-- DOUBLE PRECISION ARRAY
WITH test AS
	(
		SELECT array_trim(ARRAY[1.23456789012::DOUBLE PRECISION,NULL,1.23456789012::DOUBLE PRECISION]) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[1.23456789012::DOUBLE PRECISION,1.23456789012::DOUBLE PRECISION] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;
-- DOUBLE PRECISION ARRAY WITHOUT DUPLICATES
WITH test AS
	(
		SELECT array_trim(ARRAY[1.23456789012::DOUBLE PRECISION,NULL,1.23456789012::DOUBLE PRECISION], TRUE) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY[1.23456789012::DOUBLE PRECISION] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the eigth implementation
-- DATE ARRAY
WITH test AS
	(
		SELECT array_trim(ARRAY['2018-11-11',NULL,'2018-11-11']::DATE[]) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY['2018-11-11','2018-11-11']::DATE[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;
-- DATE ARRAY WITHOUT DUPLICATES
WITH test AS
	(
		SELECT array_trim(ARRAY['2018-11-11',NULL,'2018-11-11']::DATE[], TRUE) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY['2018-11-11']::DATE[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the ninth implementation
-- TIMESTAMP ARRAY
WITH test AS
	(
		SELECT array_trim(ARRAY['2018-11-11 11:00:00',NULL,'2018-11-11 11:00:00']::TIMESTAMP[]) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY['2018-11-11 11:00:00','2018-11-11 11:00:00']::TIMESTAMP[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;
-- TIMESTAMP ARRAY WITHOUT DUPLICATES
WITH test AS
	(
		SELECT array_trim(ARRAY['2018-11-11 11:00:00',NULL,'2018-11-11 11:00:00']::TIMESTAMP[], TRUE) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY['2018-11-11 11:00:00']::TIMESTAMP[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

-- Test of the tenth implementation
-- TIMESTAMP WITH TIME ZONE ARRAY
WITH test AS
	(
		SELECT array_trim(ARRAY['2018-11-11 11:00:00 MEZ',NULL,'2018-11-11 11:00:00 MEZ']::TIMESTAMP WITH TIME ZONE[]) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY['2018-11-11 11:00:00 MEZ','2018-11-11 11:00:00 MEZ']::TIMESTAMP WITH TIME ZONE[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;
-- TIMESTAMP WITH TIME ZONE ARRAY WITHOUT DUPLICATES
WITH test AS
	(
		SELECT array_trim(ARRAY['2018-11-11 11:00:00 MEZ',NULL,'2018-11-11 11:00:00 MEZ']::TIMESTAMP WITH TIME ZONE[], TRUE) AS trim_value
		, 0 AS zero
	)
SELECT
	CASE
		WHEN trim_value = ARRAY['2018-11-11 11:00:00 MEZ']::TIMESTAMP WITH TIME ZONE[] THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
FROM test
;

ROLLBACK;
