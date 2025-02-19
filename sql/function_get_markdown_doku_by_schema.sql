/**
 * Function to generate a documentation from database comments as Markdown for
 * a given Schema.
 * The result is a text in Markdown format.
 *
 * Currently the following objects are supported:
 * 	- Database
 * 	- Schema
 * 	- Tables with columns
 * 	- Views with columns
 * 	- Materialized Views with columns
 * 	- Foreign Tables with columns
 * 	- Functions
 * 	- Procedures
 *
 * Author: Stefanie Janine Stölting <Stefanie@ProOpenSource.eu>
 */
CREATE OR REPLACE FUNCTION get_markdown_doku_by_schema(in_schema_name TEXT, time_zone TEXT DEFAULT 'Europe/Berlin')
RETURNS TEXT
LANGUAGE PLPGSQL
AS
$$
DECLARE
	res TEXT DEFAULT '';
	current_table_name TEXT DEFAULT '';
	current_table_type TEXT DEFAULT '';
	current_program_name TEXT DEFAULT '';
	current_mv_name TEXT DEFAULT '';
	table_header TEXT;
	time_zone_exists BOOLEAN;
	curs_tables CURSOR FOR
		WITH indexes AS
			(
				SELECT schemaname
					, tablename
					, array_agg(indexname) AS indexes
				FROM pg_indexes
				GROUP BY schemaname
					, tablename
			)
		SELECT t.table_type
			, c.table_catalog AS database_name
			, c.table_schema AS schema_name
			, c.table_name
			, c.column_name
			, COALESCE (array_to_string (i.indexes, ';'), '') AS indexes
			, COALESCE (c.column_default, '') AS column_default
			, c.is_nullable
			, c.data_type
			, COALESCE (c.character_maximum_length::TEXT, '') AS character_maximum_length
			, COALESCE (de.description, '') AS database_description
			, obj_description(('"' || c.table_schema || '"')::regnamespace) AS schema_description
			, COALESCE (OBJ_DESCRIPTION(('"' || c.table_schema || '"."' || c.table_name || '"')::regclass), '') AS table_description
			, COALESCE (COL_DESCRIPTION(('"' || c.table_schema || '"."' || c.table_name || '"')::regclass, c.ordinal_position), '') AS column_description
		FROM information_schema.columns AS c
		INNER JOIN information_schema."tables" AS t
			USING (table_catalog, table_schema, table_name)
		INNER JOIN pg_catalog.pg_database AS d
			ON c.table_catalog = d.datname
		LEFT OUTER JOIN pg_catalog.pg_shdescription AS de
			ON d."oid" = de.objoid		LEFT OUTER JOIN indexes AS i
			ON c.table_schema = i.schemaname
			AND c.table_name = i.tablename
		WHERE c.table_schema = in_schema_name
		ORDER BY t.table_type
			, c.table_name
			, c.ordinal_position
		;
	table_record RECORD;
	curs_programs CURSOR FOR
		SELECT (current_database())::information_schema.sql_identifier AS database_name
			, pg_namespace.nspname AS schema_name
			, pg_proc.proname AS program_name
			, COALESCE (pg_catalog.pg_get_function_arguments(pg_proc.oid), '') AS parameters
			, COALESCE (pg_catalog.pg_get_function_result(pg_proc.oid), '') AS returning_data_type
			, CASE
					WHEN pg_proc.prokind = 'a' THEN
						'AGGREGATE'
					WHEN pg_proc.prokind = 'w' THEN
						'WINDOW'
					WHEN pg_proc.prokind = 'f' THEN
						'FUNCTION'
					WHEN pg_proc.prorettype = 'pg_catalog.trigger'::pg_catalog.regtype THEN
						'TRIGGER'
					ELSE
						'UNKNOWN'
				END as program_type
			, pg_language.lanname AS program_language
			, COALESCE (pg_description.description, '') AS program_description
		FROM pg_catalog.pg_proc
		INNER JOIN pg_catalog.pg_language
			ON pg_proc.prolang = pg_language.oid
		LEFT OUTER JOIN pg_catalog.pg_namespace
			ON pg_proc.pronamespace = pg_namespace.oid
		LEFT OUTER JOIN pg_catalog.pg_description
			ON pg_proc.oid = pg_description.objoid
		WHERE pg_catalog.pg_function_is_visible(pg_proc.oid)
			AND pg_namespace.nspname = in_schema_name
		ORDER BY schema_name
			, program_name
			, parameters
		;
	program_record RECORD;
	curs_mv CURSOR FOR
		WITH indexes AS
			(
				SELECT schemaname
					, tablename
					, array_agg(indexname) AS indexes
				FROM pg_indexes
				GROUP BY schemaname
					, tablename
			)
		SELECT (current_database())::information_schema.sql_identifier AS database_name
			, n.nspname AS schema_name
		    , c.relname AS table_name
		    , col.attname AS column_name
			, COALESCE (array_to_string (i.indexes, ';'), '') AS indexes
		    , format_type (col.atttypid, col.atttypmod) as data_type
			, COALESCE (obj_description (c."oid"), '') AS materialized_view_description
			, COALESCE (COL_DESCRIPTION(('"' || n.nspname || '"."' || c.relname || '"')::regclass, col.attnum), '') AS column_description
		FROM pg_catalog.pg_class AS c
		INNER JOIN pg_catalog.pg_namespace AS n
			ON c.relnamespace = n.oid
		INNER JOIN pg_catalog.pg_attribute AS col
			ON c.oid = col.attrelid
		LEFT OUTER JOIN indexes AS i
			ON n.nspname = i.schemaname
			AND c.relname = i.tablename
		WHERE c.relkind = 'm'
		    AND col.attnum >= 1
		    AND n.nspname = in_schema_name
		ORDER BY schema_name
		    , table_name
		    , column_name
		;
	mv_record RECORD;
BEGIN
	-- Check given time zone for existence
	EXECUTE 'SELECT count (*) = 1 AS exist
		FROM pg_catalog.pg_timezone_names
		WHERE name::TEXT = $1'
		USING time_zone
		INTO time_zone_exists
	;

	IF NOT time_zone_exists THEN
		RAISE EXCEPTION 'Time zone % does not exist!', time_zone;
	END IF;

	table_header = '| Column | Default | Is Nullable | Data Type | Maximum Length | Description |' || CHR(13) || '|--|--|--|--|--|--|'  || CHR(13);

	-- TABLES and VIEWS
	OPEN curs_tables;

	FETCH NEXT FROM curs_tables INTO table_record;
	WHILE FOUND LOOP
		IF current_table_name = '' THEN
			res = '# DATABASE ' ||
				table_record.database_name || ' SCHEMA ' || table_record.schema_name ||
				CHR(13) || CHR(13) ||
				'Generated: ' || TO_CHAR (now() AT time ZONE time_zone, 'YYYY-MM-DD HH24:MI') ||
				CHR(13) || CHR(13) ||
				'## Database Description' ||
				CHR(13) || CHR(13) ||
				table_record.database_description ||
				CHR(13) || CHR(13) ||
				'## Schema Description' ||
				CHR(13) || CHR(13) ||
				table_record.schema_description ||
				CHR(13) || CHR(13)
			;

		END IF;

		IF current_table_type <> table_record.table_type THEN
			current_table_type = table_record.table_type;
			CASE table_record.table_type
				WHEN 'BASE TABLE' THEN
					res = res ||
						'## Tables in Schema ' || table_record.schema_name ||
						CHR(13) || CHR(13)
					;

				WHEN 'VIEW' THEN
					res = res ||
						'## Views in Schema ' || table_record.schema_name ||
						CHR(13) || CHR(13)
					;

				WHEN 'FOREIGN' THEN
					res = res ||
						'## Foreign Tables in Schema ' || table_record.schema_name ||
						CHR(13) || CHR(13)
					;
				ELSE
					res = res;
			END CASE;
		END IF;

		IF current_table_name <> table_record.table_name THEN
			current_table_name = table_record.table_name;
			res = res || '### ' || table_record.table_name
				|| CHR(13) || CHR(13)
			;

			res = res || table_record.table_description ||
				CHR(13) || CHR(13)
			;

			IF table_record.indexes <> '' THEN
				res = res || 'Indexes: ' || table_record.indexes ||
					CHR(13) || CHR(13)
				;
			END IF;

			res = res || table_header;

		END IF;

		res = res || '| ' || table_record.column_name || ' | ' ||
			table_record.column_default || ' | ' ||
			table_record.is_nullable || ' | ' ||
			table_record.data_type || ' | ' ||
			table_record.character_maximum_length || ' | ' ||
			table_record.column_description || ' |' ||
			CHR(13)
		;

		FETCH NEXT FROM curs_tables INTO table_record;
	END LOOP;

	CLOSE curs_tables;

	-- MATERIALIZED VIEWS
	OPEN curs_mv;

	FETCH NEXT FROM curs_mv INTO mv_record;
	WHILE FOUND LOOP

			IF current_mv_name = '' THEN
			res = res || CHR(13) ||
				'## MATERIALIZED VIEWS in DATABASE ' ||
				mv_record.database_name ||
				' SCHEMA ' ||
				mv_record.schema_name ||
				CHR(13) || CHR(13)
			;
		END IF;

		IF current_mv_name <> mv_record.table_name THEN
			current_mv_name = mv_record.table_name;
			res = res || '### ' || mv_record.table_name ||
				CHR(13) || CHR(13) ||
				mv_record.materialized_view_description ||
				CHR(13) || CHR(13)
			;

			IF mv_record.indexes <> '' THEN
				res = res || 'Indexes: ' || mv_record.indexes ||
					CHR(13) || CHR(13)
				;
			END IF;

			res = res || '| Column | Data Type |  | Description |' || CHR(13) ||
				'|--|--|--|'  || CHR(13)
			;
		END IF;


		res = res || '| ' || mv_record.column_name || ' | ' ||
			mv_record.data_type || ' | ' ||
			mv_record.column_description || ' |' ||
			CHR(13)
		;

		FETCH NEXT FROM curs_mv INTO mv_record;
	END LOOP;

	CLOSE curs_mv;

	-- PROGRAMS AND FUNCTIONS
	OPEN curs_programs;
	FETCH NEXT FROM curs_programs INTO program_record;
	WHILE FOUND LOOP


		IF current_program_name = '' THEN
			current_program_name = program_record.program_name;
			res = res || CHR(13) || '## FUNCTIONS and PROCEDURES in DATABASE ' || program_record.database_name || ' SCHEMA ' || program_record.schema_name ||
				CHR(13) || CHR(13) ||
				'| Program Name | Type | Language | Parameters | Returning | Description |' || CHR(13) ||
				'|--|--|--|--|--|--|' || CHR(13)
			;
		END IF;
		res = res || '| ' || program_record.program_name || ' | ' ||
			program_record.program_type || ' | ' ||
			program_record.program_language || ' | ' ||
			program_record.parameters || ' | ' ||
			program_record.returning_data_type || ' |' ||
			program_record.program_description || ' | ' ||
			CHR(13)
		;

		FETCH NEXT FROM curs_programs INTO program_record;
	END LOOP;

	CLOSE curs_programs;

	RETURN res;
END;
$$
;

COMMENT ON FUNCTION get_markdown_doku_by_schema(TEXT, TEXT) IS 'Function to generate a documentation from database comments as Markdown. The result is a text in Markdown format.';
