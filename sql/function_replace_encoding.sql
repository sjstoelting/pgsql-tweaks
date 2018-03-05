/**
 * Creates three function to replace characters, that are not part of the given
 * encoding.
 * The function does depend on the function is_encoding which is part of this
 * repository.
 */
CREATE OR REPLACE FUNCTION replace_encoding(s VARCHAR, e VARCHAR) RETURNS VARCHAR AS $$
DECLARE
	i INTEGER := 0;
	res VARCHAR;
BEGIN
	res := s;

	LOOP
		EXIT WHEN i > length(res);
		i := i + 1;
		IF (NOT is_encoding(substring(res FROM i FOR 1 ), e)) THEN
			res := OVERLAY(res PLACING '' FROM i FOR 1);
		END IF;
	END LOOP;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION replace_encoding(s VARCHAR, e VARCHAR) IS 'Replaces all characters, which are not part of the given encoding, with spaces and returns the result only with characters which are part of the given encoding';


CREATE OR REPLACE FUNCTION replace_encoding(s VARCHAR, e VARCHAR, replacement VARCHAR) RETURNS VARCHAR AS $$
DECLARE
	i INTEGER := 0;
	res VARCHAR;
BEGIN
	res := s;

	LOOP
		EXIT WHEN i > length(res);
		i := i + 1;
		IF (NOT is_encoding(substring(res FROM i FOR 1 ), e)) THEN
			res := OVERLAY(res PLACING replacement FROM i FOR 1);
		END IF;
	END LOOP;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION replace_encoding(s VARCHAR, e VARCHAR, replacement VARCHAR) IS 'Replaces all characters, which are not part of the given encoding, with the given replacement in the third parameter and returns the result only with characters which are part of the given encoding';


CREATE OR REPLACE FUNCTION replace_encoding(s VARCHAR, s_search VARCHAR[], s_replace VARCHAR[]) RETURNS VARCHAR AS $$
DECLARE
	i INTEGER := 0;
	res VARCHAR;
	length_equal BOOLEAN;
	a_count INTEGER;
BEGIN

	SELECT array_length(s_search, 1) = array_length(s_replace, 1) INTO length_equal;

	IF NOT length_equal THEN
		RAISE 'Search and replacement arrays do not have the same count of entries' USING ERRCODE = '22000';
	END IF;

	SELECT array_length(s_search, 1) INTO a_count;
	res := s;

	LOOP
		EXIT WHEN i >= a_count;
		i := i + 1;

		res := REPLACE(res, s_search[i], s_replace[i]);

	END LOOP;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION replace_encoding(s VARCHAR, s_search VARCHAR[], s_replace VARCHAR[]) IS 'Replaces charactes given in s_search with characters given in s_replace at the same array position';
