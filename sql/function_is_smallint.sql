/**
 * Creates a function to check strings for being SMALLINT.
 */
CREATE OR REPLACE FUNCTION is_smallint(s text) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::SMALLINT;
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_smallint(s text) IS 'Checks, whether the given parameter is a smallint';
