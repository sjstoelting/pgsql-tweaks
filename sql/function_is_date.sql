/**
 * Creates two functions to check strings for being a date.
 * The first function checks it with the default format, the second with the
 * format given as parameter.
 */
CREATE OR REPLACE FUNCTION is_date(s text) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM s::date;
	RETURN TRUE;
EXCEPTION WHEN OTHERS THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_date(s text) IS 'Takes a text and checks if it is a date, uses standard date format YYYY-MM-DD';


CREATE OR REPLACE FUNCTION is_date(s text, f text) RETURNS BOOLEAN AS $$
BEGIN
	PERFORM to_date(s, f);
	RETURN TRUE;
EXCEPTION WHEN OTHERS THEN
	RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_date(s text, f text) IS 'Takes a text and checks if it is a date by taking the second text as date format';
