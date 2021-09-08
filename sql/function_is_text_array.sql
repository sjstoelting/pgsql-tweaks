/**
 * Creates a function to check strings for being an SMALLINT array.
 */
CREATE OR REPLACE FUNCTION is_text_array(s text) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::TEXT[];
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_text_array(s text) IS 'Checks, whether the given parameter is a TEXT array';
