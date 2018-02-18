/**
 * Returns the minumum value of an array.
 * Implementation for BIGINT, INTEGER, SMALLINT, TEXT
 */
CREATE OR REPLACE FUNCTION array_min(a BIGINT[]) RETURNS BIGINT AS $$
DECLARE
	res BIGINT;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
	SELECT min(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_min(a BIGINT[]) IS 'Returns the minumum value of an array';

CREATE OR REPLACE FUNCTION array_min(a INTEGER[]) RETURNS INTEGER AS $$
DECLARE
	res INTEGER;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT min(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_min(a INTEGER[]) IS 'Returns the minumum value of an array';


CREATE OR REPLACE FUNCTION array_min(a SMALLINT[]) RETURNS INTEGER AS $$
DECLARE
	res SMALLINT;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT min(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_min(a SMALLINT[]) IS 'Returns the minumum value of an array';
CREATE OR REPLACE FUNCTION array_min(a TEXT[]) RETURNS TEXT AS $$
DECLARE
	res TEXT;
BEGIN

	WITH unnested AS
 		(
			SELECT UNNEST(a) AS vals
		)
		SELECT min(vals) FROM unnested AS x INTO res;

	RETURN res;

END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION array_min(a TEXT[]) IS 'Returns the minumum value of an array';
