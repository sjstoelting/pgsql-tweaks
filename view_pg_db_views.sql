/**
 * Creates a view to get all views of the current database but excluding system views and all views which do start with 'pg' or '_pg'.
 */
CREATE OR REPLACE VIEW pg_db_views AS
SELECT table_catalog AS view_catalog
	, table_schema AS view_schema
	, table_name AS view_name
FROM INFORMATION_SCHEMA.views
WHERE NOT table_name LIKE 'pg%'
	AND NOT table_name LIKE '\\_pg%'
	AND table_schema NOT IN ('pg_catalog', 'information_schema')
ORDER BY table_catalog
	, table_schema
	, table_name
;
COMMENT ON VIEW pg_db_views IS 'Creates a view to get all views of the current database but excluding system views and all views which do start with ''pg'' or ''_pg''';
