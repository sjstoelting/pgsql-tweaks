/**
 * Creates a function to check strings for being JSON.
 */
CREATE OR REPLACE FUNCTION is_json(s text) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::JSON;
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_json(s text) IS 'Checks, whether the given text is a JSON';
