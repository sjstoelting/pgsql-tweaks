/**
 * Test for function is_json
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
		WHERE proname = 'is_json'
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

-- Test with a test string containing no JSON
WITH test AS
	(
		SELECT is_json('Not a JSON') AS isjson
			, 0 AS zero
	)
SELECT
	CASE
		WHEN NOT isjson THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

-- Test with a test string containing JSON
WITH test AS
	(
		SELECT is_json('{"review": {"date": "1970-12-30", "votes": 10, "rating": 5, "helpful_votes": 0}, "product": {"id": "1551803542", "group": "Book", "title": "Start and Run a Coffee Bar (Start & Run a)", "category": "Business & Investing", "sales_rank": 11611, "similar_ids": ["0471136174", "0910627312", "047112138X", "0786883561", "0201570483"], "subcategory": "General"}, "customer_id": "AE22YDHSBFYIP"}') AS isjson
			, 0 AS zero
	)
SELECT
	CASE
		WHEN isjson THEN
			TRUE
		ELSE
			(1 / zero)::BOOLEAN
	END AS res
FROM test
;

ROLLBACK;
