/**
 * Test for the functions return_not_part_of_encoding
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT count(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'return_not_part_of_encoding'
  )
SELECT 1 / test.exist  AS res
FROM test
;

-- Test the returning result which should contain two array elements
WITH test AS
  (
    SELECT return_not_part_of_encoding('ağbƵcğeƵ', 'latin1') AS res
      , 0 AS zero
  )
SELECT
  CASE
    WHEN array_length(res, 1) = 2 THEN
      1
    ELSE
      1 / zero
  END as res_1
  , CASE
  	WHEN 'ğ' = ANY (res) AND 'Ƶ' = ANY (res) THEN
  		1
    ELSE
      1 / zero
  END as res_2
FROM test
;

END;
