/**
 * Creates a function to check strings for being BOOLEAN.
 */
CREATE OR REPLACE FUNCTION is_boolean(s text) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::BOOLEAN;
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_boolean(s text) IS 'Checks, whether the given parameter is a BOOLEAN';
