CREATE OR REPLACE FUNCTION array_trim(a text[], rd BOOLEAN DEFAULT FALSE) RETURNS text[] AS $$
DECLARE
	res text[];
BEGIN
	
	IF rd THEN
		WITH t1 AS
			(
				SELECT DISTINCT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE vals != ''
		INTO res;
	ELSE
		WITH t1 AS
			(
				SELECT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE vals != ''
		INTO res;
	END IF;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_trim(a text[], rd BOOLEAN) IS 'Removes empty entries from a text array, can remove duplicates, too';

CREATE OR REPLACE FUNCTION array_trim(a SMALLINT[], rd BOOLEAN DEFAULT FALSE) RETURNS SMALLINT[] AS $$
DECLARE
	res SMALLINT[];
BEGIN
	
	IF rd THEN
		WITH t1 AS
			(
				SELECT DISTINCT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	ELSE
		WITH t1 AS
			(
				SELECT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	END IF;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_trim(a SMALLINT[], rd BOOLEAN) IS 'Removes empty entries from a SMALLINT array, can remove duplicates, too';

CREATE OR REPLACE FUNCTION array_trim(a INTEGER[], rd BOOLEAN DEFAULT FALSE) RETURNS INTEGER[] AS $$
DECLARE
	res INTEGER[];
BEGIN
	
	IF rd THEN
		WITH t1 AS
			(
				SELECT DISTINCT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	ELSE
		WITH t1 AS
			(
				SELECT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	END IF;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_trim(a INTEGER[], rd BOOLEAN) IS 'Removes empty entries from a INTEGER array, can remove duplicates, too';

CREATE OR REPLACE FUNCTION array_trim(a BIGINT[], rd BOOLEAN DEFAULT FALSE) RETURNS BIGINT[] AS $$
DECLARE
	res BIGINT[];
BEGIN
	
	IF rd THEN
		WITH t1 AS
			(
				SELECT DISTINCT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	ELSE
		WITH t1 AS
			(
				SELECT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	END IF;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_trim(a BIGINT[], rd BOOLEAN) IS 'Removes empty entries from a BIGINT array, can remove duplicates, too';

CREATE OR REPLACE FUNCTION array_trim(a NUMERIC[], rd BOOLEAN DEFAULT FALSE) RETURNS NUMERIC[] AS $$
DECLARE
	res NUMERIC[];
BEGIN
	
	IF rd THEN
		WITH t1 AS
			(
				SELECT DISTINCT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	ELSE
		WITH t1 AS
			(
				SELECT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	END IF;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_trim(a NUMERIC[], rd BOOLEAN) IS 'Removes empty entries from a NUMERIC array, can remove duplicates, too';

CREATE OR REPLACE FUNCTION array_trim(a REAL[], rd BOOLEAN DEFAULT FALSE) RETURNS REAL[] AS $$
DECLARE
	res REAL[];
BEGIN
	
	IF rd THEN
		WITH t1 AS
			(
				SELECT DISTINCT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	ELSE
		WITH t1 AS
			(
				SELECT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	END IF;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_trim(a REAL[], rd BOOLEAN) IS 'Removes empty entries from a REAL array, can remove duplicates, too';

CREATE OR REPLACE FUNCTION array_trim(a DOUBLE PRECISION[], rd BOOLEAN DEFAULT FALSE) RETURNS DOUBLE PRECISION[] AS $$
DECLARE
	res DOUBLE PRECISION[];
BEGIN
	
	IF rd THEN
		WITH t1 AS
			(
				SELECT DISTINCT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	ELSE
		WITH t1 AS
			(
				SELECT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	END IF;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_trim(a DOUBLE PRECISION[], rd BOOLEAN) IS 'Removes empty entries from a DOUBLE PRECISION array, can remove duplicates, too';

CREATE OR REPLACE FUNCTION array_trim(a DATE[], rd BOOLEAN DEFAULT FALSE) RETURNS DATE[] AS $$
DECLARE
	res DATE[];
BEGIN
	
	IF rd THEN
		WITH t1 AS
			(
				SELECT DISTINCT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	ELSE
		WITH t1 AS
			(
				SELECT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	END IF;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_trim(a DATE[], rd BOOLEAN) IS 'Removes empty entries from a DATE array, can remove duplicates, too';

CREATE OR REPLACE FUNCTION array_trim(a TIMESTAMP[], rd BOOLEAN DEFAULT FALSE) RETURNS TIMESTAMP[] AS $$
DECLARE
	res TIMESTAMP[];
BEGIN
	
	IF rd THEN
		WITH t1 AS
			(
				SELECT DISTINCT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	ELSE
		WITH t1 AS
			(
				SELECT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	END IF;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_trim(a TIMESTAMP[], rd BOOLEAN) IS 'Removes empty entries from a TIMESTAMP array, can remove duplicates, too';

CREATE OR REPLACE FUNCTION array_trim(a TIMESTAMP WITH TIME ZONE[], rd BOOLEAN DEFAULT FALSE) RETURNS TIMESTAMP WITH TIME ZONE[] AS $$
DECLARE
	res TIMESTAMP WITH TIME ZONE[];
BEGIN
	
	IF rd THEN
		WITH t1 AS
			(
				SELECT DISTINCT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	ELSE
		WITH t1 AS
			(
				SELECT unnest(a) AS vals
			)
		SELECT array_agg(vals)
		FROM t1
		WHERE NOT vals IS NULL
		INTO res;
	END IF;

	RETURN res;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_trim(a TIMESTAMP WITH TIME ZONE[], rd BOOLEAN) IS 'Removes empty entries from a TIMESTAMP WITH TIME ZONE array, can remove duplicates, too';
