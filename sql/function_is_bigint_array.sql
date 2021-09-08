/**
 * Creates a function to check strings for being a BIGINT array.
 */
CREATE OR REPLACE FUNCTION is_bigint_array(s text) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::BIGINT[];
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_bigint_array(s text) IS 'Checks, whether the given parameter is a BIGINT array';
