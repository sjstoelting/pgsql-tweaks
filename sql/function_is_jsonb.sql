/**
 * Creates a function to check strings for being JSONB.
 */
CREATE OR REPLACE FUNCTION is_jsonb(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::JSONB;
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_jsonb(s VARCHAR) IS 'Checks, whether the given text is a JSONB';
