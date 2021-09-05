/**
 * The view shows unused indexes with further information about the table.
 */
CREATE OR REPLACE VIEW pg_unused_indexes AS
SELECT schemaname
	, relname AS table_name
	, indexrelname AS index_name
	, idx_scan
	, pg_size_pretty (pg_table_size ('"' || schemaname || '"."' || relname || '"')) AS table_size
	, pg_size_pretty (pg_total_relation_size ('"' || schemaname || '"."' || relname || '"')) AS table_total_size
	, pg_size_pretty (pg_indexes_size ('"' || schemaname || '"."' || relname || '"')) AS all_indexes_size
	, pg_size_pretty (pg_relation_size (indexrelid)) AS index_size
	, pg_size_pretty (sum (pg_relation_size (indexrelid)) over ()) AS  size_of_all_indexes
FROM pg_stat_all_indexes
WHERE idx_scan = 0
AND schemaname NOT IN
	(
		'information_schema',
		'pg_catalog',
		'pg_toast'
	)
;
COMMENT ON VIEW pg_unused_indexes IS 'The view shows unused indexes with further information about the table.';
