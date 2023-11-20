/**
 * Create a window function to calculate values for gaps.
 */
CREATE OR REPLACE FUNCTION gap_fill_internal(s anyelement, v anyelement)
RETURNS anyelement AS
$$
BEGIN
	RETURN COALESCE(v, s);
END;
$$ LANGUAGE PLPGSQL IMMUTABLE;
COMMENT ON FUNCTION gap_fill_internal(s anyelement, v anyelement) IS 'The function is used to fill gaps in window functions';


-- The Window function needs an aggregate
DROP AGGREGATE IF EXISTS gap_fill(anyelement);
CREATE AGGREGATE gap_fill(anyelement) (
	SFUNC=gap_fill_internal,
	STYPE = anyelement
)
;
COMMENT ON AGGREGATE gap_fill(anyelement) IS 'Implements the aggregate function to fill gaps using the function GapFillInternal';
