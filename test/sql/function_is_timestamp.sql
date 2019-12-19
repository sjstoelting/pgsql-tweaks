/**
 * Test for function is_timestamp
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
		WHERE proname = 'is_timestamp'
	)
SELECT
	CASE
		WHEN 2 / test.exist = 1 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test if all implementations exists
WITH test AS
	(
		SELECT COUNT(*) AS exist
			, 0 AS zero
		FROM pg_catalog.pg_proc
		WHERE proname = 'is_timestamp'
	)
SELECT
	CASE
		WHEN test.exist = 2 THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with timestamp in default format
WITH test AS
	(
		SELECT is_timestamp('2018-01-01 00:00:00') AS istimestamp
			, 0 AS zero
	)
SELECT
	CASE
		WHEN istimestamp THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with wrong timestamp in default format
WITH test AS
	(
		SELECT is_timestamp('2018-01-01 25:00:00') AS istimestamp
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT istimestamp THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with timestamp in German format
WITH test AS
	(
		SELECT is_timestamp('01.01.2018 00:00:00', 'DD.MM.YYYY HH24.MI.SS') AS istimestamp
			, 0 AS zero
	)
SELECT
	CASE
		WHEN istimestamp THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with wrong timestamp in German format
/**
 * As there has been a behaviour change in PostgreSQL 10, the result is only
 * false with version 10 in <9 it would be true a call to
 * SELECT to_timestamp('01.01.2018 25:00:00', 'DD.MM.YYYY HH24.MI.SS')::TIMESTAMP;
 * would return 2018-01-02 01:00:00
 */
WITH test AS
	(
		SELECT is_timestamp('01.01.2018 25:00:00', 'DD.MM.YYYY HH24.MI.SS') AS istimestamp
			, 0 AS zero
			, current_setting('server_version_num')::INTEGER as version_num
	)
SELECT
	CASE
		WHEN version_num >= 100000 THEN
			CASE
				WHEN NOT istimestamp THEN
					TRUE
				ELSE
					(1 / zero)::BOOLEAN
			END
/*			
		ELSE
			CASE
				WHEN istimestamp THEN
					TRUE
				ELSE
					(1 / zero)::BOOLEAN
		END
*/
	END AS res
FROM test
;
WITH test AS
	(
		SELECT is_timestamp('01.01.2018 25:00:00', 'DD.MM.YYYY HH24.MI.SS') AS istimestamp
			, 0 AS zero
			, current_setting('server_version_num')::INTEGER as version_num
	)
SELECT
	CASE
		WHEN version_num < 100000 THEN
			CASE
				WHEN istimestamp THEN
					TRUE
				ELSE
					NULL--(1 / zero)::BOOLEAN
		END
	END AS res
FROM test
;


 
ROLLBACK;
