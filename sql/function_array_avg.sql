/**
 * Returns the average value of an array.
 * Implementation for BIGINT, INTEGER, SMALLINT
 */

-- BIGINT implementation
CREATE OR REPLACE FUNCTION array_avg(a BIGINT[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
	SELECT avg(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_avg(a BIGINT[]) IS 'Returns the average value of a BIGINT array';

-- INTEGER implementation
CREATE OR REPLACE FUNCTION array_avg(a INTEGER[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT avg(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_avg(a INTEGER[]) IS 'Returns the average value of an INTEGER array';

-- SMALLINT implementation
CREATE OR REPLACE FUNCTION array_avg(a SMALLINT[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT avg(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_avg(a SMALLINT[]) IS 'Returns the average value of a SMALLINT array';

--REAL implementation
CREATE OR REPLACE FUNCTION array_avg(a REAL[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT avg(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_avg(a REAL[]) IS 'Returns the average value of a REAL array';

-- DOUBLE PRECISION implementation
CREATE OR REPLACE FUNCTION array_avg(a DOUBLE PRECISION[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT avg(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_avg(a DOUBLE PRECISION[]) IS 'Returns the average value of a DOUBLE PRECISION array';

-- NUMERIC implementation
CREATE OR REPLACE FUNCTION array_avg(a NUMERIC[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT avg(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_avg(a NUMERIC[]) IS 'Returns the average value of a NUMERIC array';
