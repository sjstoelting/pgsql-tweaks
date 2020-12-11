/**
 * Creates a function to check strings for being BIGINT.
 */
CREATE OR REPLACE FUNCTION is_bigint(s text) RETURNS BOOLEAN AS $$
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
COMMENT ON FUNCTION is_bigint(s text) IS 'Checks, whether the given parameter is a BIGINT';
