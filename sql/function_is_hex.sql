/**
* Creates a function to check hexadeciaml numbers passed as strings for being hexadeciaml fitting into a 0BIGINT.
*/
CREATE OR REPLACE FUNCTION is_hex(s TEXT) RETURNS BOOLEAN AS $$
BEGIN
   PERFORM hex2bigint (s);
   RETURN TRUE;
EXCEPTION WHEN others THEN
   RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_hex(s TEXT) IS 'Checks, whether the given parameter is a hexadeciaml number fitting into a BIGINT';
