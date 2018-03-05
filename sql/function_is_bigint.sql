/**
 * Creates a function to check strings for being BIGINT.
 */
CREATE OR REPLACE FUNCTION is_bigint(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::BIGINT;
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_bigint(s VARCHAR) IS 'Checks, whether the given parameter is a BIGINT';
