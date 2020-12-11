/**
 * Creates a function to checks a string variable for being either, NULL or ''.
 */
CREATE OR REPLACE FUNCTION is_empty(s text) RETURNS BOOLEAN AS $$
BEGIN
	RETURN COALESCE(s, '') = '';
END;
$$
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_empty(s text) IS 'Checks, whether the given parameter is NULL or ''''';
