/**
 * Creates a function to check strings for being an INTEGER array.
 */
CREATE OR REPLACE FUNCTION is_integer_array(s text) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::INTEGER[];
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_integer_array(s text) IS 'Checks, whether the given parameter is an INTEGER array';
