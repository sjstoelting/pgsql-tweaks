CREATE OR REPLACE FUNCTION replace_latin1(s VARCHAR) RETURNS VARCHAR AS $$
DECLARE
	i INTEGER := 0;
	res VARCHAR;
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
COMMENT ON FUNCTION replace_latin1(s VARCHAR) IS 'Replaces all non latin2 characters with spaces and returns the result with only containing latin1 characters';


CREATE OR REPLACE FUNCTION replace_latin1(s VARCHAR, replacement VARCHAR) RETURNS VARCHAR AS $$
DECLARE
	i INTEGER := 0;
	res VARCHAR;
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
COMMENT ON FUNCTION replace_latin1(s VARCHAR, replacement VARCHAR) IS 'Replaces all non latin2 characters with the given replacement in the second parameter and returns the result with only containing latin1 characters';
