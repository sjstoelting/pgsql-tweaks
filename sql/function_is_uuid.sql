/**
 * Creates a function to check strings for being UUID.
 */
CREATE OR REPLACE FUNCTION is_uuid(s text) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::UUID;
	RETURN TRUE;
EXCEPTION WHEN others THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_uuid(s text) IS 'Checks, whether the given parameter is a uuid';
