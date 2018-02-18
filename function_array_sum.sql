/**
 * Returns the sum of values of an array.
 * Implementation for BIGINT, INTEGER, SMALLINT
 */
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
COMMENT ON FUNCTION array_sum(a BIGINT[]) IS 'Returns the sum of values of an array';

CREATE OR REPLACE FUNCTION array_sum(a INTEGER[]) RETURNS INTEGER AS $$
DECLARE
	res INTEGER;
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
COMMENT ON FUNCTION array_sum(a INTEGER[]) IS 'Returns the sum of values of an array';

CREATE OR REPLACE FUNCTION array_sum(a SMALLINT[]) RETURNS INTEGER AS $$
DECLARE
	res SMALLINT;
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
COMMENT ON FUNCTION array_sum(a SMALLINT[]) IS 'Returns the sum of values of an array';
