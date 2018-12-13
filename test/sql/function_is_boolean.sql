/**
 * Test for function is_boolean
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
		WHERE proname = 'is_boolean'
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

-- Test single letters beeing boolean
WITH test AS
	(
		SELECT is_boolean('t') AS isboolean_0
			, is_boolean('f') AS isboolean_1
			, is_boolean('T') AS isboolean_2
			, is_boolean('F') AS isboolean_3
			, is_boolean('y') AS isboolean_4
			, is_boolean('n') AS isboolean_5
			, is_boolean('Y') AS isboolean_6
			, is_boolean('N') AS isboolean_7
			, 0 AS zero
	)
SELECT
	CASE
		WHEN isboolean_0 AND isboolean_1 AND isboolean_2 AND isboolean_3 AND
			isboolean_4 AND isboolean_5 AND isboolean_6 AND isboolean_7
		THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test words being boolean
WITH test AS
	(
		SELECT is_boolean('TRUE') AS isboolean_0
			, is_boolean('FALSE') AS isboolean_1
			, is_boolean('true') AS isboolean_2
			, is_boolean('false') AS isboolean_3
			, is_boolean('YES') AS isboolean_4
			, is_boolean('NO') AS isboolean_5
			, is_boolean('yes') AS isboolean_6
			, is_boolean('no') AS isboolean_7
			, 0 AS zero
	)
SELECT
CASE
	WHEN isboolean_0 AND isboolean_1 AND isboolean_2 AND isboolean_3 AND
		isboolean_4 AND isboolean_5 AND isboolean_6 AND isboolean_7
	THEN
		TRUE
	ELSE
		(1 / zero)::BOOLEAN
END AS res
FROM test
;

-- Test text for not beeing boolean
WITH test AS
	(
		SELECT is_boolean('Not a BOOLEAN') AS isboolean, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isboolean THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test positive number for not beeing boolean
WITH test AS
	(
		SELECT is_boolean('3') AS isboolean, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isboolean THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test negative number for not beeing boolean
WITH test AS
	(
		SELECT is_boolean('-1') AS isboolean, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isboolean THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;
