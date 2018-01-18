/**
 * Creates a function which returns a distinct array with all non latin1
 * characters . Depends on function is_latin1 which is part of this repository.
 */
CREATE OR REPLACE FUNCTION return_not_part_of_latin1(s VARCHAR) RETURNS VARCHAR[] AS $$
DECLARE
	i INTEGER := 0;
	res VARCHAR[];
	current_s VARCHAR := NULL::VARCHAR[];
BEGIN

	LOOP
		EXIT WHEN i > length(s);
		i := i + 1;
		current_s := substring(s FROM i FOR 1);
		IF (NOT is_latin1(current_s)) THEN
			SELECT array_append(res, current_s) INTO res;
		END IF;
	END LOOP;

	WITH t1 AS
		(
			SELECT unnest(res) AS c1
		)
	, t2 AS
		(
		    SELECT DISTINCT c1
		    FROM t1
		)
	, t3 AS
		(
			SELECT array_agg(c1) AS res_array
			FROM t2
		)
	SELECT res_array
	FROM t3
	INTO res;

    RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION return_not_part_of_latin1(s VARCHAR) IS 'Creates a function which returns a distinct array with all non latin1 characters';
