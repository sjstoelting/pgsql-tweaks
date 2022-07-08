
/**
 * Tests for all example statements used in the README
 */
BEGIN;

SELECT is_date('31.02.2018', 'DD.MM.YYYY') AS res;

SELECT is_date('2018-01-01') AS res;

SELECT is_date('2018-02-31') AS res;

SELECT is_date('01.01.2018', 'DD.MM.YYYY') AS res;

SELECT is_date('31.02.2018', 'DD.MM.YYYY') AS res;

SELECT is_time('25.33.55,456574', 'HH24.MI.SS,US') AS res;

SELECT is_time('14:33:55.456574') AS res;

SELECT is_time('25:33:55.456574') AS res;

SELECT is_time('14.33.55,456574', 'HH24.MI.SS,US') AS res;

SELECT is_time('25.33.55,456574', 'HH24.MI.SS,US') AS res;

SELECT is_timestamp('2018-01-01 25:00:00') AS res;

SELECT is_timestamp('2018-01-01 00:00:00') AS res;

SELECT is_timestamp('2018-01-01 25:00:00') AS res;

SELECT is_timestamp('01.01.2018 00:00:00', 'DD.MM.YYYY HH24.MI.SS') AS res;

SELECT is_timestamp('01.01.2018 25:00:00', 'DD.MM.YYYY HH24.MI.SS') AS res;

SELECT is_real('123.456') AS res;

SELECT is_real('123,456') AS res;

SELECT is_double_precision('123.456') AS res;

SELECT is_double_precision('123,456') AS res;

SELECT is_numeric('123') AS res;

SELECT is_numeric('1 2') AS res;

SELECT is_bigint('3243546343') AS res;

SELECT is_bigint('123.456') AS res;

SELECT is_integer('123') AS res;

SELECT is_integer('123.456') AS res;

SELECT is_smallint('123') AS res;

SELECT is_smallint('123.456') AS res;

SELECT is_boolean('t') AS res;

SELECT is_boolean('F') AS res;

SELECT is_boolean('True') AS res;

SELECT is_boolean('False');

SELECT is_boolean('0') AS res;

SELECT is_boolean('1') AS res;

SELECT is_boolean('-1') AS res;

SELECT is_json('{"review": {"date": "1970-12-30", "votes": 10, "rating": 5, "helpful_votes": 0}, "product": {"id": "1551803542", "group": "Book", "title": "Start and Run a Coffee Bar (Start & Run a)", "category": "Business & Investing", "sales_rank": 11611, "similar_ids": ["0471136174", "0910627312", "047112138X", "0786883561", "0201570483"], "subcategory": "General"}, "customer_id": "AE22YDHSBFYIP"}') AS res;

SELECT is_json('Not a JSON') AS res;

SELECT is_jsonb('{"review": {"date": "1970-12-30", "votes": 10, "rating": 5, "helpful_votes": 0}, "product": {"id": "1551803542", "group": "Book", "title": "Start and Run a Coffee Bar (Start & Run a)", "category": "Business & Investing", "sales_rank": 11611, "similar_ids": ["0471136174", "0910627312", "047112138X", "0786883561", "0201570483"], "subcategory": "General"}, "customer_id": "AE22YDHSBFYIP"}') AS res;

SELECT is_jsonb('Not a JSONB') AS res;

SELECT is_empty('abc') AS res;

SELECT is_empty('') AS res;

SELECT is_empty(NULL) AS res;

SELECT is_hex('a1b0') AS res;

SELECT is_hex('a1b0w') AS res;

SELECT is_hex('a1b0c3c3c3c4b5d3') AS res;

SELECT sha256('test-string'::bytea) AS res;

SELECT pg_schema_size('public');

SELECT pg_size_pretty(pg_schema_size('public'));

SELECT *
FROM pg_db_views;

SELECT *
FROM pg_foreign_keys;

SELECT *
FROM pg_functions;

SELECT *
FROM pg_active_locks;

SELECT *
FROM pg_table_matview_infos;

SELECT *
FROM pg_object_ownership
WHERE owner = 'stefanie';

SELECT *
FROM pg_partitioned_tables_infos;

SELECT is_encoding('Some characters', 'LATIN1') AS res;

SELECT is_encoding('Some characters, ğ is Turkish and not latin1', 'LATIN1') AS res;

SELECT is_encoding('Some characters', 'LATIN1', 'UTF8') AS res;

SELECT is_encoding('Some characters, ğ is Turkish and not latin1', 'UTF8', 'LATIN1') AS res;

SELECT is_latin1('Some characters') AS res;

SELECT is_latin1('Some characters, ğ is Turkish and not latin1') AS res;

SELECT return_not_part_of_latin1('ağbƵcğeƵ') AS res;

SELECT replace_latin1('Some characters, ğ is Turkish and not latin1') AS res;

SELECT replace_latin1(
  'Some characters, ğ is Turkish and not latin1 and replaced with a g',
  'g'
) AS res;

SELECT return_not_part_of_latin1('ağbƵcğeƵ') AS res;

SELECT 'ağbƵcğeƵ' AS original
  , replace_latin1(
      'ağbƵcğeƵ',
      string_to_array('ğ,Ƶ', ','),
      string_to_array('g,Z', ',')
    ) AS res;

SELECT return_not_part_of_encoding('ağbƵcğeƵ', 'latin1') AS res;

SELECT replace_encoding(
  'Some characters, ğ is Turkish and not latin1',
  'latin1'
) AS res;

SELECT replace_encoding(
  'Some characters, ğ is Turkish and not latin1 and replaced with a g',
  'latin1',
  'g'
) AS res;

SELECT return_not_part_of_latin1('ağbƵcğeƵ') AS res;

SELECT 'ağbƵcğeƵ' AS original
  , replace_encoding(
      'ağbƵcğeƵ',
      string_to_array('ğ,Ƶ', ','),
      string_to_array('g,Z', ',')
  ) AS res;

CREATE TABLE test_gap_fill(id INTEGER, some_value text);

INSERT INTO test_gap_fill(id, some_value) VALUES
  (1, 'value 1'),
  (1, NULL),
  (2, 'value 2'),
  (2, NULL),
  (2, NULL),
  (3, 'value 3')
;

SELECT id
  , some_value
FROM test_gap_fill
;

DROP TABLE IF EXISTS test_gap_fill;

CREATE TABLE test_gap_fill(id INTEGER, some_value text);

INSERT INTO test_gap_fill(id, some_value) VALUES
  (1, 'value 1'),
  (1, NULL),
  (2, 'value 2'),
  (2, NULL),
  (2, NULL),
  (3, 'value 3')
;

SELECT id
  , gap_fill(some_value) OVER (ORDER BY id) AS some_value
FROM test_gap_fill
;

DROP TABLE IF EXISTS test_gap_fill;

SELECT array_min(ARRAY[45, 60, 43, 99]::SMALLINT[]);

SELECT array_min(ARRAY[45, 60, 43, 99]::INTEGER[]);

SELECT array_min(ARRAY[45, 60, 43, 99]::BIGINT[]);

SELECT array_min(ARRAY[45.6, 60.8, 43.7, 99.3]::REAL[]);

SELECT array_min(ARRAY[45.6, 60.8, 43.7, 99.3]::DOUBLE PRECISION[]);

SELECT array_min(ARRAY[45.6, 60.8, 43.7, 99.3]::NUMERIC[]);

SELECT array_min(ARRAY['def', 'abc', 'ghi']::TEXT[]);

SELECT array_max(ARRAY[45, 60, 43, 99]::SMALLINT[]);

SELECT array_max(ARRAY[45, 60, 43, 99]::INTEGER[]);

SELECT array_max(ARRAY[45, 60, 43, 99]::BIGINT[]);

SELECT array_max(ARRAY[45.6, 60.8, 43, 99.3]::REAL[]);

SELECT array_max(ARRAY[45.6, 60.8, 43, 99.3]::DOUBLE PRECISION[]);

SELECT array_max(ARRAY[45.6, 60.8, 43, 99.3]::NUMERIC[]);

SELECT array_max(ARRAY['def', 'abc', 'ghi']::TEXT[]);

SELECT array_avg(ARRAY[45, 60, 43, 99]::SMALLINT[]);

SELECT array_avg(ARRAY[45, 60, 43, 99]::INTEGER[]);

SELECT array_avg(ARRAY[45, 60, 43, 99]::BIGINT[]);

SELECT array_avg(ARRAY[45.6, 60.8, 43, 99.3]::REAL[]);

SELECT array_avg(ARRAY[45.6, 60.8, 43, 99.3]::DOUBLE PRECISION[]);

SELECT array_avg(ARRAY[45.6, 60.8, 43, 99.3]::NUMERIC[]);

SELECT array_sum(ARRAY[45, 60, 43, 99]::SMALLINT[]);

SELECT array_sum(ARRAY[45, 60, 43, 99]::INTEGER[]);

SELECT array_sum(ARRAY[45, 60, 43, 99]::BIGINT[]);

SELECT array_sum(ARRAY[45.6, 60.8, 43.7, 99.3]::REAL[]);

SELECT array_sum(ARRAY[45.6, 60.8, 43.7, 99.3]::DOUBLE PRECISION[]);

SELECT array_sum(ARRAY[45.6, 60.8, 43.7, 99.3]::NUMERIC[]);

SELECT date_de('2018-01-01') AS d_de;

SELECT datetime_de('2018-01-01 13:30:30 GMT') AS ts_de;

SELECT to_unix_timestamp('2018-01-01 00:00:00') AS unix_timestamp;

SELECT to_unix_timestamp('2018-01-01 00:00:00+01') AS unix_timestamp;

SELECT hex2bigint('a1b0') AS hex_as_bigint;

SELECT array_trim(ARRAY['2018-11-11 11:00:00 MEZ',NULL,'2018-11-11 11:00:00 MEZ']::TIMESTAMP WITH TIME ZONE[]) AS trimmed_array;

SELECT ARRAY['2018-11-11 11:00:00 MEZ',NULL,'2018-11-11 11:00:00 MEZ']::TIMESTAMP WITH TIME ZONE[] AS untrimmed_array;

SELECT array_trim(ARRAY['2018-11-11 11:00:00 MEZ',NULL,'2018-11-11 11:00:00 MEZ']::TIMESTAMP WITH TIME ZONE[], TRUE) AS trimmed_array_distinct;


ROLLBACK;
