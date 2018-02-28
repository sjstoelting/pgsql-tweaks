/**
 * Returns the sum of values of an array.
 * Implementation for BIGINT, INTEGER, SMALLINT
 */

-- BIGINT implementation
CREATE OR REPLACE FUNCTION array_sum(a BIGINT[]) RETURNS BIGINT AS $$
DECLARE
	res BIGINT;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
	SELECT sum(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_sum(a BIGINT[]) IS 'Returns the sum of values of a BIGINT array';

-- INTEGER implementation
CREATE OR REPLACE FUNCTION array_sum(a INTEGER[]) RETURNS BIGINT AS $$
DECLARE
	res BIGINT;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT sum(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_sum(a INTEGER[]) IS 'Returns the sum of values of an INTEGER array';

-- SMALLINT implementation
CREATE OR REPLACE FUNCTION array_sum(a SMALLINT[]) RETURNS BIGINT AS $$
DECLARE
	res BIGINT;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT sum(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_sum(a SMALLINT[]) IS 'Returns the sum of values of a SMALLINT array';

-- REAL implementation
CREATE OR REPLACE FUNCTION array_sum(a REAL[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT sum(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_sum(a REAL[]) IS 'Returns the sum of values of a REAL array';

-- DOUBLE PRECISION implementation
CREATE OR REPLACE FUNCTION array_sum(a DOUBLE PRECISION[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT sum(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_sum(a DOUBLE PRECISION[]) IS 'Returns the sum of values of a DOUBLE PRECISION array';

-- NUMERIC implementation
CREATE OR REPLACE FUNCTION array_sum(a NUMERIC[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT sum(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_sum(a NUMERIC[]) IS 'Returns the sum of values of a NUMERIC array';
