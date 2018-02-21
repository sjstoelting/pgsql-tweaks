/**
 * Returns the average value of an array.
 * Implementation for BIGINT, INTEGER, SMALLINT
 */
-- The result type has been changed, therefore existing functins have to be dropped
DROP FUNCTION IF EXISTS array_avg(a BIGINT[]);
DROP FUNCTION IF EXISTS array_avg(a INTEGER[]);
DROP FUNCTION IF EXISTS array_avg(a SMALLINT[]);

CREATE OR REPLACE FUNCTION array_avg(a BIGINT[]) RETURNS DOUBLE PRECISION AS $$
DECLARE
	res DOUBLE PRECISION;
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
COMMENT ON FUNCTION array_avg(a BIGINT[]) IS 'Returns the average value of an array';

CREATE OR REPLACE FUNCTION array_avg(a INTEGER[]) RETURNS DOUBLE PRECISION AS $$
DECLARE
	res DOUBLE PRECISION;
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
COMMENT ON FUNCTION array_avg(a INTEGER[]) IS 'Returns the average value of an array';

CREATE OR REPLACE FUNCTION array_avg(a SMALLINT[]) RETURNS DOUBLE PRECISION AS $$
DECLARE
	res DOUBLE PRECISION;
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
COMMENT ON FUNCTION array_avg(a SMALLINT[]) IS 'Returns the average value of an array';
