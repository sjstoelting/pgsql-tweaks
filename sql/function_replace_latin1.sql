/**
 * Creates two function to replace characters, that are not part of latin1.
 * The function does depend on the function is_latin1 which is part of this
 * repository.
 */
CREATE OR REPLACE FUNCTION replace_latin1(s text) RETURNS text AS $$
DECLARE
	i INTEGER := 0;
	res text;
BEGIN
	res := s;

	LOOP
		EXIT WHEN i > length(res);
		i := i + 1;
		IF (NOT is_latin1(substring(res FROM i FOR 1 ))) THEN
			res := OVERLAY(res PLACING '' FROM i FOR 1);
		END IF;
	END LOOP;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION replace_latin1(s text) IS 'Replaces all not latin1 characters with spaces and returns the result with only containing latin1 characters';


CREATE OR REPLACE FUNCTION replace_latin1(s text, replacement text) RETURNS text AS $$
DECLARE
	i INTEGER := 0;
	res text;
BEGIN
	res := s;

	LOOP
		EXIT WHEN i > length(res);
		i := i + 1;
		IF (NOT is_latin1(substring(res FROM i FOR 1 ))) THEN
			res := OVERLAY(res PLACING replacement FROM i FOR 1);
		END IF;
	END LOOP;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION replace_latin1(s text, replacement text) IS 'Replaces all not latin1 characters with the given replacement in the second parameter and returns the result with only containing latin1 characters';


CREATE OR REPLACE FUNCTION replace_latin1(s text, s_search text[], s_replace text[]) RETURNS text AS $$
DECLARE
	res text;
BEGIN

	SELECT replace_encoding(s, s_search, s_replace) INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION replace_latin1(s text, s_search text[], s_replace text[]) IS 'Replaces charactes given in s_search with characters given in s_replace at the same array position. The function is an alias for replace_encoding.';
