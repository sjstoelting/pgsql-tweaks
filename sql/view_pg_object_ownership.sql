/**
 * Creates a view to get the ownership of all objects in the current database.
 * This is the script handles the different installations which are needed for
 * PostgreSQL 11 or newer and PostgreSQL 10 or older.
 */
DO $$
DECLARE
	version_greater_11 BOOLEAN;
BEGIN
	SELECT to_number((string_to_array(version(), ' '))[2], '999.99') >= 11 INTO version_greater_11;

	IF version_greater_11 THEN
		-- Create the view pg_object_ownership for PostgreSQL 11 or newer
		CREATE OR REPLACE VIEW pg_object_ownership AS
		WITH dbobjects AS
			(
				SELECT nsp.nspname AS object_schema
					, cls.relname AS object_name
					, rol.rolname AS owner
					, CASE cls.relkind
						WHEN 'I' THEN
							'PARTITIONED INDEX'
						WHEN 'S' THEN
							'SEQUENCE'
						WHEN 'c' THEN
							'COMPOSITE TYPE'
						WHEN 'f' THEN
							'FOREIGN TABLE'
						WHEN 'i' THEN
							'INDEX'
						WHEN 'm' THEN
							'MATERIALIZED VIEW'
						WHEN 'p' THEN
							'PARTITIONED TABLE'
						WHEN 'r' THEN
							'TABLE'
						WHEN 'v' THEN
							'VIEW'
						ELSE
							cls.relkind::text
					END AS object_type
				FROM pg_catalog.pg_class AS cls
				INNER JOIN pg_roles AS rol
					ON cls.relowner = rol.oid
				INNER JOIN pg_catalog.pg_namespace AS nsp
					ON cls.relnamespace = nsp.oid
				UNION ALL
				SELECT NULL AS object_schema
					, db.datname AS object_name
					, rol.rolname AS owner
					, 'DATABASE' AS object_type
				FROM pg_catalog.pg_database AS db
				INNER JOIN pg_roles AS rol
					ON db.datdba = rol.oid
				UNION ALL
				SELECT NULL AS object_schema
					, ext.extname
					, rol.rolname AS owner
					, 'EXTENSION' AS object_type
				FROM pg_catalog.pg_extension AS ext
				INNER JOIN pg_roles AS rol
					ON ext.extowner = rol.oid
				UNION ALL
				SELECT NULL AS object_schema
					, fdw.fdwname AS object_name
					, rol.rolname AS owner
					, 'FOREIGN DATA WRAPPER' AS object_type
				FROM pg_catalog.pg_foreign_data_wrapper AS fdw
				INNER JOIN pg_roles AS rol
					ON fdw.fdwowner = rol.oid
				UNION ALL
				SELECT NULL AS object_schema
					, srv.srvname AS object_name
					, rol.rolname AS owner
					, 'FOREIGN SERVER' AS object_type
				FROM pg_catalog.pg_foreign_server AS srv
				INNER JOIN pg_roles AS rol
					ON srv.srvowner = rol.oid
				UNION ALL
				SELECT NULL AS object_schema
					, lang.lanname AS object_name
					, rol.rolname AS owner
					, 'LANGUAGE' AS object_type
				FROM pg_catalog.pg_language AS lang
				INNER JOIN pg_roles AS rol
					ON lang.lanowner = rol.oid
				UNION ALL
				SELECT NULL AS object_schema
					, nsp.nspname AS object_name
					, rol.rolname AS owner
					, 'SCHEMA' AS object_type
				FROM pg_catalog.pg_namespace AS nsp
				INNER JOIN pg_roles AS rol
					ON nsp.nspowner = rol.oid
				UNION ALL
				SELECT NULL AS object_schema
					, opc.opcname AS object_name
					, rol.rolname AS owner
					, 'OPERATOR CLASS' AS object_type
				FROM pg_catalog.pg_opclass AS opc
				INNER JOIN pg_roles AS rol
					ON opc.opcowner = rol.oid
				UNION ALL
				SELECT nsp.nspname AS object_schema
					, pro.proname AS object_name
					, rol.rolname AS owner
					, CASE lower(pro.prokind)
						WHEN 'f' THEN
							'FUNCTION'
						WHEN 'p' THEN
							'PROCEDURE'
						WHEN 'a' THEN
							'AGGREGATE FUNCTION'
						WHEN 'w' THEN
							'WINDOW FUNCTION'
						ELSE
							lower(pro.prokind)
					END AS object_type
				FROM pg_catalog.pg_proc AS pro
				INNER JOIN pg_roles AS rol
					ON pro.proowner = rol.oid
				INNER JOIN pg_catalog.pg_namespace nsp
					ON pro.pronamespace = nsp.oid
				UNION ALL
				SELECT NULL AS object_schema
					, col.collname AS object_name
					, rol.rolname AS owner
					, 'COLLATION' AS object_type
				FROM pg_catalog.pg_collation AS col
				INNER JOIN pg_roles AS rol
					ON col.collowner = rol.oid
				UNION ALL
				SELECT NULL AS object_schema
					, con.conname AS object_name
					, rol.rolname AS owner
					, 'CONVERSION' AS object_type
				FROM pg_catalog.pg_conversion AS con
				INNER JOIN pg_roles AS rol
					ON con.conowner = rol.oid
					UNION ALL
				SELECT NULL AS object_schema
					, evt.evtname AS object_name
					, rol.rolname AS owner
					, 'EVENT TRIGGER' AS object_type
				FROM pg_catalog.pg_event_trigger AS evt
				INNER JOIN pg_roles AS rol
					ON evt.evtowner = rol.oid
				UNION ALL
				SELECT NULL AS object_schema
					, opf.opfname AS object_name
					, rol.rolname AS owner
					, 'OPERATION FAMILY' AS object_type
				FROM pg_catalog.pg_opfamily AS opf
				INNER JOIN pg_roles AS rol
					ON opf.opfowner = rol.oid
				UNION ALL
				SELECT NULL AS object_schema
					, pub.pubname AS object_name
					, rol.rolname AS owner
					, 'PUBLICATIONS' AS object_type
				FROM pg_catalog.pg_publication AS pub
				INNER JOIN pg_roles AS rol
					ON pub.pubowner = rol.oid
			)
		SELECT *
		FROM dbobjects
		WHERE object_schema NOT IN ('information_schema', 'pg_catalog')
			AND object_schema NOT LIKE 'pg_toast%'
		;
	ELSE
		-- Create the view pg_object_ownership for PostgreSQL older than 11
		CREATE OR REPLACE VIEW pg_object_ownership AS
		WITH dbobjects AS
			(
				SELECT nsp.nspname AS object_schema
					, cls.relname AS object_name
					, rol.rolname AS owner
					, CASE cls.relkind
						WHEN 'I' THEN
							'PARTITIONED INDEX'
						WHEN 'S' THEN
							'SEQUENCE'
						WHEN 'c' THEN
							'COMPOSITE TYPE'
						WHEN 'f' THEN
							'FOREIGN TABLE'
						WHEN 'i' THEN
							'INDEX'
						WHEN 'm' THEN
							'MATERIALIZED VIEW'
						WHEN 'p' THEN
							'PARTITIONED TABLE'
						WHEN 'r' THEN
							'TABLE'
						WHEN 'v' THEN
							'VIEW'
						ELSE
							cls.relkind::text
					END AS object_type
				FROM pg_catalog.pg_class AS cls
				INNER JOIN pg_roles AS rol
					ON cls.relowner = rol.oid
				INNER JOIN pg_catalog.pg_namespace AS nsp
					ON cls.relnamespace = nsp.oid
				UNION ALL
				SELECT NULL AS object_schema
					, db.datname AS object_name
					, rol.rolname AS owner
					, 'DATABASE' AS object_type
				FROM pg_catalog.pg_database AS db
				INNER JOIN pg_roles AS rol
					ON db.datdba = rol.oid
				UNION ALL
				SELECT NULL AS object_schema
					, ext.extname
					, rol.rolname AS owner
					, 'EXTENSION' AS object_type
				FROM pg_catalog.pg_extension AS ext
				INNER JOIN pg_roles AS rol
					ON ext.extowner = rol.oid
				UNION ALL
				SELECT NULL AS object_schema
					, fdw.fdwname AS object_name
					, rol.rolname AS owner
					, 'FOREIGN DATA WRAPPER' AS object_type
				FROM pg_catalog.pg_foreign_data_wrapper AS fdw
				INNER JOIN pg_roles AS rol
					ON fdw.fdwowner = rol.oid
				UNION ALL
				SELECT NULL AS object_schema
					, srv.srvname AS object_name
					, rol.rolname AS owner
					, 'FOREIGN SERVER' AS object_type
				FROM pg_catalog.pg_foreign_server AS srv
				INNER JOIN pg_roles AS rol
					ON srv.srvowner = rol.oid
				UNION ALL
				SELECT NULL AS object_schema
					, lang.lanname AS object_name
					, rol.rolname AS owner
					, 'LANGUAGE' AS object_type
				FROM pg_catalog.pg_language AS lang
				INNER JOIN pg_roles AS rol
					ON lang.lanowner = rol.oid
				UNION ALL
				SELECT NULL AS object_schema
					, nsp.nspname AS object_name
					, rol.rolname AS owner
					, 'SCHEMA' AS object_type
				FROM pg_catalog.pg_namespace AS nsp
				INNER JOIN pg_roles AS rol
					ON nsp.nspowner = rol.oid
				UNION ALL
				SELECT NULL AS object_schema
					, opc.opcname AS object_name
					, rol.rolname AS owner
					, 'OPERATOR CLASS' AS object_type
				FROM pg_catalog.pg_opclass AS opc
				INNER JOIN pg_roles AS rol
					ON opc.opcowner = rol.oid
				UNION ALL
				SELECT nsp.nspname AS object_schema
					, pro.proname AS object_name
					, rol.rolname AS owner
					, 'FUNCTION' AS object_type
				FROM pg_catalog.pg_proc AS pro
				INNER JOIN pg_roles AS rol
					ON pro.proowner = rol.oid
				INNER JOIN pg_catalog.pg_namespace nsp
					ON pro.pronamespace = nsp.oid
					UNION ALL
				SELECT NULL AS object_schema
					, col.collname AS object_name
					, rol.rolname AS owner
					, 'COLLATION' AS object_type
				FROM pg_catalog.pg_collation AS col
				INNER JOIN pg_roles AS rol
					ON col.collowner = rol.oid
				UNION ALL
				SELECT NULL AS object_schema
					, con.conname AS object_name
					, rol.rolname AS owner
					, 'CONVERSION' AS object_type
				FROM pg_catalog.pg_conversion AS con
				INNER JOIN pg_roles AS rol
					ON con.conowner = rol.oid
				UNION ALL
				SELECT NULL AS object_schema
					, evt.evtname AS object_name
					, rol.rolname AS owner
					, 'EVENT TRIGGER' AS object_type
				FROM pg_catalog.pg_event_trigger AS evt
				INNER JOIN pg_roles AS rol
					ON evt.evtowner = rol.oid
				UNION ALL
				SELECT NULL AS object_schema
					, opf.opfname AS object_name
					, rol.rolname AS owner
					, 'OPERATION FAMILY' AS object_type
				FROM pg_catalog.pg_opfamily AS opf
				INNER JOIN pg_roles AS rol
					ON opf.opfowner = rol.oid
				UNION ALL
				SELECT NULL AS object_schema
					, pub.pubname AS object_name
					, rol.rolname AS owner
					, 'PUBLICATIONS' AS object_type
				FROM pg_catalog.pg_publication AS pub
				INNER JOIN pg_roles AS rol
					ON pub.pubowner = rol.oid
			)
		SELECT *
		FROM dbobjects
		WHERE object_schema NOT IN ('information_schema', 'pg_catalog')
			AND object_schema NOT LIKE 'pg_toast%'
		;
	END IF;

-- Add a comment
COMMENT ON VIEW pg_object_ownership IS 'The view returns all objects, its type, and its ownership in the current database, excluding those in the schema pg_catalog and information_schema';

END $$;
