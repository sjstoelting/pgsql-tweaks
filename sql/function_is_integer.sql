/**
 * Creates a function to check strings for being INTEGER.
 */
CREATE OR REPLACE FUNCTION is_integer(s text) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::INTEGER;
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_integer(s text) IS 'Checks, whether the given parameter is an INTEGER';
