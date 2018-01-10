/**
 * Creates a function to check strings for being integers with bigint.
 */
CREATE OR REPLACE FUNCTION is_integer(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
    PERFORM s::bigint;
    RETURN TRUE;
EXCEPTION WHEN others THEN
    RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_integer(s VARCHAR) IS 'Checks, whether the given parameter is an integer (u)';
