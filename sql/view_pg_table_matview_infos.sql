/**
 * Creates a view to get information about table and materialized views in the
 * current database. It includes their sizes and indexes.
 */
CREATE OR REPLACE VIEW pg_table_matview_infos AS
WITH indexes AS
	(
		SELECT schemaname
			, tablename
			, array_agg(indexname) AS indexes
		FROM pg_indexes
		GROUP BY schemaname
			, tablename
	)
SELECT 'table' AS type
	, n.nspname AS schemaname
	, c.relname AS tablename
	, pg_get_userbyid (c.relowner) AS tableowner
	, t.spcname AS TABLESPACE
	, i.indexes
	, pg_table_size (c.oid) AS table_size
	, pg_indexes_size(c.oid) AS indexes_size
	, pg_total_relation_size(c.oid) AS total_relation_size
	, pg_size_pretty(pg_table_size(c.oid)) AS table_size_pretty
	, pg_size_pretty(pg_indexes_size(c.oid)) AS indexes_size_pretty
	, pg_size_pretty(pg_total_relation_size(c.oid)) AS total_relation_size_pretty
FROM pg_class AS c
	LEFT OUTER JOIN pg_namespace AS n
		ON n.oid = c.relnamespace
	LEFT OUTER JOIN pg_tablespace AS t
		ON t.oid = c.reltablespace
	LEFT OUTER JOIN indexes AS i
		ON n.nspname = i.schemaname
		AND c.relname = i.tablename
WHERE c.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])
	AND n.nspname NOT IN ('pg_catalog', 'information_schema')
UNION ALL
SELECT 'matview' AS type
	, n.nspname AS schemaname
	, c.relname AS matviewname
	, pg_get_userbyid(c.relowner) AS matviewowner
	, t.spcname AS tablespace
	, i.indexes
	, pg_table_size(c.oid) AS table_size
	, pg_indexes_size(c.oid) AS indexes_size
	, pg_total_relation_size(c.oid) AS total_relation_size
	, pg_size_pretty(pg_table_size(c.oid)) AS table_size_pretty
	, pg_size_pretty(pg_indexes_size(c.oid)) AS indexes_size_pretty
	, pg_size_pretty(pg_total_relation_size(c.oid)) AS total_relation_size_pretty
FROM pg_class AS c
	LEFT OUTER JOIN pg_namespace AS n
		ON n.oid = c.relnamespace
	LEFT OUTER JOIN pg_tablespace t
		ON t.oid = c.reltablespace
	LEFT OUTER JOIN indexes AS i
		ON n.nspname = i.schemaname
		AND c.relname = i.tablename
WHERE c.relkind = 'm'::"char"
;
COMMENT ON VIEW pg_table_matview_infos IS 'The view shows detailed information about sizes and indexes of tables and materialized views';
