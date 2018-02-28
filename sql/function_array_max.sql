/**
 * Returns the maximum value of an array.
 * Implementation for BIGINT, INTEGER, SMALLINT, TEXT
 */

-- BIGINT implementation
CREATE OR REPLACE FUNCTION array_max(a BIGINT[]) RETURNS BIGINT AS $$
DECLARE
	res BIGINT;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
	SELECT max(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_max(a BIGINT[]) IS 'Returns the maximum value of a BIGINT array';

-- INTEGER implementation
CREATE OR REPLACE FUNCTION array_max(a INTEGER[]) RETURNS BIGINT AS $$
DECLARE
	res INTEGER;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT max(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_max(a INTEGER[]) IS 'Returns the maximum value of an INTEGER array';

-- SMALLINT implementation
CREATE OR REPLACE FUNCTION array_max(a SMALLINT[]) RETURNS BIGINT AS $$
DECLARE
	res SMALLINT;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT max(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_max(a SMALLINT[]) IS 'Returns the maximum value of a SMALLINT array';

-- TEXT implementation
CREATE OR REPLACE FUNCTION array_max(a TEXT[]) RETURNS TEXT AS $$
DECLARE
	res TEXT;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT max(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_max(a TEXT[]) IS 'Returns the maximum value of a TEXT array';

-- REAL implementation
CREATE OR REPLACE FUNCTION array_max(a REAL[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT max(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_max(a REAL[]) IS 'Returns the maximum value of a REAL array';

-- DOUBLE PRECISION implementation
CREATE OR REPLACE FUNCTION array_max(a DOUBLE PRECISION[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT max(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_max(a DOUBLE PRECISION[]) IS 'Returns the maximum value of a DOUBLE PRECISION array';

-- NUMERIC implementation
CREATE OR REPLACE FUNCTION array_max(a NUMERIC[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT max(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_max(a NUMERIC[]) IS 'Returns the maximum value of a NUMERIC array';
