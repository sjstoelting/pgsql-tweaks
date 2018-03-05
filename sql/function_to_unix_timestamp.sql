/**
 * Creates two functions which returns unix timestamp for the a given timestamp
 * or a given timestamp with time zone.
 *
 * The function needs the pgcrypto package.
 */
CREATE OR REPLACE FUNCTION to_unix_timestamp(ts timestamp) RETURNS bigint AS $$
	SELECT EXTRACT (EPOCH FROM ts)::bigint;
$$ LANGUAGE SQL STRICT IMMUTABLE
;
COMMENT ON FUNCTION to_unix_timestamp(ts timestamp) IS 'Returns an unix timestamp for the given timestamp';

CREATE OR REPLACE FUNCTION to_unix_timestamp(ts timestamp with time zone) RETURNS bigint AS $$
	SELECT EXTRACT (EPOCH FROM ts)::bigint;
$$ LANGUAGE SQL STRICT IMMUTABLE
;
COMMENT ON FUNCTION to_unix_timestamp(ts timestamp with time zone) IS 'Returns an unix timestamp for the given timestamp with time zone';
