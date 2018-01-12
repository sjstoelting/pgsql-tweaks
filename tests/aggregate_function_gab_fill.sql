/**
 * Test for the aggregate GapFill
 *
 * Every test does raise division by zero if it failes
 */
BEGIN;

-- Test if the function exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'gap_fill_internal'
  )
SELECT 1 / test.exist AS res
FROM test
;

-- Test if the aggregate exists
WITH test AS
  (
    SELECT COUNT(*) AS exist
    FROM pg_catalog.pg_proc
    WHERE proname = 'gap_fill'
  )
SELECT 1 / test.exist AS res
FROM test
;


END;
