/**
 * Creates a function to check strings for being INTEGER.
 */
CREATE OR REPLACE FUNCTION is_real(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
    PERFORM s::REAL;
    RETURN TRUE;
EXCEPTION WHEN others THEN
    RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_real(s VARCHAR) IS 'Checks, whether the given parameter is a REAL';
