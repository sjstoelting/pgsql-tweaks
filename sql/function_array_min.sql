/**
 * Returns the minumum value of an array.
 * Implementation for BIGINT, INTEGER, SMALLINT, TEXT
 */

-- BIGINT implementation
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
COMMENT ON FUNCTION array_min(a BIGINT[]) IS 'Returns the minumum value of a BIGINT array';

-- INTEGER implementation
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
COMMENT ON FUNCTION array_min(a INTEGER[]) IS 'Returns the minumum value of an INTEGER array';

-- SMALLINT implementation
CREATE OR REPLACE FUNCTION array_min(a SMALLINT[]) RETURNS SMALLINT AS $$
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
COMMENT ON FUNCTION array_min(a SMALLINT[]) IS 'Returns the minumum value of a SMALLINT array';

-- TEXT implementation
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
COMMENT ON FUNCTION array_min(a TEXT[]) IS 'Returns the minumum value of a TEXT array';

-- REAL implementation
CREATE OR REPLACE FUNCTION array_min(a REAL[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
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
COMMENT ON FUNCTION array_min(a REAL[]) IS 'Returns the minumum value of a REAL array';

-- DOUBLE PRECISION implementation
CREATE OR REPLACE FUNCTION array_min(a DOUBLE PRECISION[]) RETURNS NUMERIC AS $$
DECLARE
	res NUMERIC;
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
COMMENT ON FUNCTION array_min(a DOUBLE PRECISION[]) IS 'Returns the minumum value of a DOUBLE PRECISION array';

-- NUMERIC implementation
CREATE OR REPLACE FUNCTION array_min(a NUMERIC[]) RETURNS NUMERIC AS $$
DECLARE
	res REAL;
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
COMMENT ON FUNCTION array_min(a NUMERIC[]) IS 'Returns the minumum value of a NUMERIC array';
