/**
 * Creates a function which returns a SHA256 hash for the given string.
 *
 * The function needs the pgcrypto package.
 */
CREATE OR REPLACE FUNCTION sha256(bytea) RETURNS text AS $$
    SELECT ENCODE(digest($1, 'sha256'), 'hex')
$$ LANGUAGE SQL STRICT IMMUTABLE
;
COMMENT ON FUNCTION sha256(bytea) IS 'Returns a SHA254 hash for the given string';
