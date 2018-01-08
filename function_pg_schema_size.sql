/**
 * Creates a function which returns the size of a schema.
 */
CREATE OR REPLACE FUNCTION pg_schema_size(text) RETURNS BIGINT AS $$
  SELECT SUM(pg_total_relation_size(quote_ident(schemaname) || '.' || quote_ident(tablename)))::BIGINT
  FROM pg_tables
  WHERE schemaname = $1
$$ LANGUAGE SQL STRICT IMMUTABLE;
COMMENT ON FUNCTION pg_schema_size(text) IS 'Returns the size for given schema name';
