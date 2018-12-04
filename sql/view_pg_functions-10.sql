/**
 * Creates a view to get all functions of the current database.
 * This is the script for PostgreSQL 10 or older
 */
CREATE OR REPLACE VIEW pg_functions AS
SELECT pg_namespace.nspname AS schema_name
	, pg_proc.proname AS function_name
	, pg_catalog.pg_get_function_result(pg_proc.oid) AS returning_data_type
	, pg_catalog.pg_get_function_arguments(pg_proc.oid) AS parameters
	, CASE
			WHEN pg_proc.proisagg THEN
				'aggregate'
			WHEN pg_proc.proiswindow THEN
				'window'
			 WHEN pg_proc.prorettype = 'pg_catalog.trigger'::pg_catalog.regtype THEN
			 	'trigger'
			 ELSE
			 	'function'
		END as function_type
	, pg_description.description AS function_comment
FROM pg_catalog.pg_proc
	LEFT OUTER JOIN pg_catalog.pg_namespace
		ON pg_proc.pronamespace = pg_namespace.oid
	LEFT OUTER JOIN pg_catalog.pg_description
		ON pg_proc.oid = pg_description.objoid
WHERE pg_catalog.pg_function_is_visible(pg_proc.oid)
	AND pg_namespace.nspname NOT IN ('pg_catalog', 'information_schema')
ORDER BY schema_name
	, function_name
	, parameters
;
COMMENT ON VIEW pg_functions IS 'The view returns all functions of the current database, excluding those in the schema pg_catalog and information_schema';
