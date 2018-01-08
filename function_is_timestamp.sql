/**
 * Creates two functions to check strings for being timestamps.
 * The first function checks it with the default format, the second with the
 * format given as parameter.
 */
CREATE OR REPLACE FUNCTION is_timestamp(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
    PERFORM s::TIMESTAMP;
    RETURN TRUE;
EXCEPTION WHEN others THEN
    RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE;
COMMENT ON FUNCTION is_timestamp(s VARCHAR) IS 'Takes a varchar and checks if it is a timestamp without time zone, uses standard timestamp format YYYY-MM-DD HH24:MI:SS';


CREATE OR REPLACE FUNCTION is_timestamp(s VARCHAR, f VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
    PERFORM to_timestamp(s, f)::TIMESTAMP;
    RETURN TRUE;
EXCEPTION WHEN others THEN
    RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE;
COMMENT ON FUNCTION is_timestamp(s VARCHAR) IS 'Takes a varchar and checks if it is a timestamp by taking the second varchar as date format';
