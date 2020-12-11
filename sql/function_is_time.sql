/**
 * Creates two functions to check strings for being a time.
 * The first function checks it with the default format, the second with the
 * format given as parameter.
 */
CREATE OR REPLACE FUNCTION is_time(s text) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::TIME;
	RETURN TRUE;
EXCEPTION WHEN OTHERS THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_time(s text) IS 'Takes a text and checks if it is a time, uses standard date format HH24:MI:SS.US';


CREATE OR REPLACE FUNCTION is_time(s text, f text) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM to_timestamp(s, f)::TIME;
	RETURN TRUE;
EXCEPTION WHEN OTHERS THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_time(s text, f text) IS 'Takes a text and checks if it is a time by taking the second text as time format';
