/**
 * Creates a function to check strings for being nunbers.
 */
CREATE OR REPLACE FUNCTION is_numeric(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
    PERFORM s::NUMERIC;
    RETURN TRUE;
EXCEPTION WHEN others THEN
    RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_numeric(s VARCHAR) IS 'Checks, whether the given parameter is a number';
