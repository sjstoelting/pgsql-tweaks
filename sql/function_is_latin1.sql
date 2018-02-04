/**
 * Creates a function to check UTF-8 strings for containing only Latin1
 * characters.
 */
CREATE OR REPLACE FUNCTION is_latin1(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
    PERFORM convert(s::bytea, 'UTF8', 'LATIN1');
    RETURN TRUE;
EXCEPTION WHEN others THEN
    RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_latin1(s VARCHAR) IS 'Checks, whether the given parameter contains only latin1 characters';
