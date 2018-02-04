/**
 * Creates two functions to check strings about encodings.
 * The first function checks if an UTF-8 string does only contain characters
 * in the given second parameter.
 * The second parameter takes as third parameter the encoding in which the
 * string is and checks if the string does only contain characters as given in
 * the second parameter.
 */
CREATE OR REPLACE FUNCTION is_encoding(s VARCHAR, enc VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
    PERFORM convert(s::bytea, 'UTF8', enc);
    RETURN TRUE;
EXCEPTION WHEN others THEN
    RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_encoding(s VARCHAR, enc VARCHAR) IS 'Checks, whether the given UTF8 sting contains only encodings in the given encoding characters';


CREATE OR REPLACE FUNCTION is_encoding(s VARCHAR, enc VARCHAR, enc_from VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
    PERFORM convert(s::bytea, enc_from, enc);
    RETURN TRUE;
EXCEPTION WHEN others THEN
    RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_encoding(s VARCHAR, enc VARCHAR, enc_from VARCHAR) IS 'Checks, whether the given encoding sting contains only encodings in the given encoding characters';
