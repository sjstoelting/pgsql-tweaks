/**
 * Creates a view to get information about partitioned tables.
 */
DO $$
DECLARE
	version_greater_10 BOOLEAN;
BEGIN
	SELECT to_number((string_to_array(version(), ' '))[2], '999.99') >= 10 INTO version_greater_10;

	IF version_greater_10 THEN
		-- Create the view pg_functions for PostgreSQL 10 or newer
		CREATE OR REPLACE VIEW public.pg_partitioned_tables_infos AS
		SELECT cl.oid AS parent_relid
			, n.nspname AS parent_schemaname
			, cl.relname AS parent_tablename
			, r.rolname AS parent_owner
			, CASE pt.partstrat
				WHEN 'l' THEN
					'LIST'
				WHEN 'r' THEN
					'RANGE'
				WHEN 'h' THEN
					'HASH'
			END AS partition_strategy
			, count (cl2.oid) OVER (PARTITION BY cl.oid) AS count_of_partitions
			, COALESCE (sum (pg_relation_size (cl2.oid)) OVER (PARTITION BY cl.oid), 0) AS overall_size
			, cl2.oid AS child_relid
			, n2.nspname AS child_schemaname
			, cl2.relname AS child_tablename
			, r2.rolname AS child_owner
			, pg_relation_size (cl2.oid) AS child_size
		FROM pg_catalog.pg_class AS cl
		INNER JOIN pg_catalog.pg_partitioned_table AS pt
			ON cl.oid = pt.partrelid
		INNER JOIN pg_catalog.pg_namespace AS n
			ON cl.relnamespace = n.oid
		INNER JOIN pg_catalog.pg_roles AS r
			 ON cl.relowner = r.oid
		LEFT OUTER JOIN pg_catalog.pg_inherits AS i
			ON cl.oid = i.inhparent
		LEFT OUTER JOIN pg_catalog.pg_class AS cl2
			ON i.inhrelid = cl2.oid
			AND cl2.relispartition
			AND cl2.relkind = 'r'
		LEFT OUTER JOIN pg_catalog.pg_namespace AS n2
			ON cl2.relnamespace = n2.oid
		LEFT OUTER JOIN pg_catalog.pg_roles AS r2
			 ON cl2.relowner = r2.oid
		WHERE cl.relkind = 'p'
		;

		COMMENT ON VIEW pg_partitioned_tables_infos IS 'Creates a view to get information about partitioned tables';
	END IF;

END $$;
