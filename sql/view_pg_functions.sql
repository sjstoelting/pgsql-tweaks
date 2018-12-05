/**
 * Creates a view to get all functions of the current database.
 * This is the script handles the different installations which are needed for
 * PostgreSQL 11 or newer and PostgreSQL 10 or older.
 */
DO $$
DECLARE
	version_greater_11 BOOLEAN;
BEGIN
	SELECT to_number((string_to_array(version(), ' '))[2], '999.99') >= 11 INTO version_greater_11;

	IF version_greater_11 THEN
		-- Create the view pg_functions for PostgreSQL 11 or newer
		CREATE OR REPLACE VIEW pg_functions AS
		SELECT pg_namespace.nspname AS schema_name
			, pg_proc.proname AS function_name
			, pg_catalog.pg_get_function_result(pg_proc.oid) AS returning_data_type
			, pg_catalog.pg_get_function_arguments(pg_proc.oid) AS parameters
			, CASE
					WHEN pg_proc.prokind = 'a' THEN
						'aggregate'
					WHEN pg_proc.prokind = 'w' THEN
						'window'
					WHEN pg_proc.prokind = 'f' THEN
						'function'
					WHEN pg_proc.prorettype = 'pg_catalog.trigger'::pg_catalog.regtype THEN
						'trigger'
					ELSE
						'unknown'
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
	ELSE
		-- Create the view pg_functions for PostgreSQL older than 11
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
	END IF;

	-- Add a comment
	COMMENT ON VIEW pg_functions IS 'The view returns all functions of the current database, excluding those in the schema pg_catalog and information_schema';

END $$;
