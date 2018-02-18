/**
 * Returns the maximum value of an array.
 * Implementation for BIGINT, INTEGER, SMALLINT, TEXT
 */
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
COMMENT ON FUNCTION array_max(a BIGINT[]) IS 'Returns the maximum value of an array';

CREATE OR REPLACE FUNCTION array_max(a INTEGER[]) RETURNS INTEGER AS $$
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
COMMENT ON FUNCTION array_max(a INTEGER[]) IS 'Returns the maximum value of an array';


CREATE OR REPLACE FUNCTION array_max(a SMALLINT[]) RETURNS INTEGER AS $$
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
COMMENT ON FUNCTION array_max(a SMALLINT[]) IS 'Returns the maximum value of an array';
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
COMMENT ON FUNCTION array_max(a TEXT[]) IS 'Returns the maximum value of an array';
