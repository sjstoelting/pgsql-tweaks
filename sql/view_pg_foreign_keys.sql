/**
 * Creates a view to get all foreign keys of the current database.
 */
DROP VIEW IF EXISTS pg_foreign_keys;
CREATE OR REPLACE VIEW pg_foreign_keys AS
SELECT tc.table_catalog
	, tc.table_schema
	, tc.table_name
	, kcu.column_name
	, ccu.table_schema AS foreign_table_schema
	, ccu.TABLE_NAME AS foreign_table_name
	, ccu.COLUMN_NAME AS foreign_column_name
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
	INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu
		ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
		INNER JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE AS ccu
			ON ccu.CONSTRAINT_NAME = tc.CONSTRAINT_NAME
WHERE tc.CONSTRAINT_TYPE = 'FOREIGN KEY'
;
COMMENT ON VIEW pg_foreign_keys IS 'The view returns all foreign keys of the current database';
