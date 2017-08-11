CREATE OR REPLACE FUNCTION pg_schema_size(text) RETURNS BIGINT AS $$
  SELECT SUM(pg_total_relation_size(quote_ident(schemaname) || '.' || quote_ident(tablename)))::BIGINT
  FROM pg_tables
  WHERE schemaname = $1
$$ LANGUAGE SQL;
