/**
 * Test for the functions replace_encoding
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT count(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'replace_encoding'
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
    WHERE proname = 'replace_encoding'
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

-- Test of the first implementation which replaces none latin1 characters with
-- empty strings
WITH test AS
	(
		SELECT 'ağbƵcğeƵ' AS test_string
      , 'latin1' AS enc
	    , 0 AS zero
	)
SELECT
	CASE
		WHEN length(test_string) = 8 AND length(replace_encoding(test_string, enc)) = 4 THEN
			TRUE
		ELSE
      (1 / test.zero)::BOOLEAN
  END AS res_1
  , CASE
		WHEN is_encoding(replace_encoding(test_string, enc), enc) THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_2
FROM test
;

-- Test of the second implementation which replaces none latin1 characters with
-- second parameter
WITH test AS
	(
		SELECT 'ağbcğe' AS test_string
      , 'latin1' AS enc
			, 'g' AS replacement
			, 0 AS zero
	)
SELECT
	CASE
		WHEN length(test_string) = length(replace_encoding(test_string, enc, replacement)) THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
  , CASE
		WHEN is_encoding(replace_encoding(test_string, enc, replacement), enc) THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_2
FROM test
;

-- Test of the third implementation which replaces given none latin1 characters
-- in an array as second parameter with latin1 characters given in an array as
-- the third paramater
WITH test AS
	(
		SELECT 'ağbƵcğeƵ' AS test_string
			, string_to_array('ğ,Ƶ', ',') AS to_replace
			, string_to_array('g,Z', ',') AS replacement
			, 0 AS zero
	)
SELECT
	CASE
		WHEN length(test_string) = length(replace_encoding(test_string, to_replace, replacement)) THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_1
	, CASE
		WHEN is_latin1(replace_encoding(test_string, to_replace, replacement)) THEN
			TRUE
		ELSE
			(1 / test.zero)::BOOLEAN
	END AS res_2
FROM test
;

ROLLBACK;
