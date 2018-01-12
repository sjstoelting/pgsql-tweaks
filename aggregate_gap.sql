/**
 * Create a window function to calculate values for gaps.
 */
CREATE OR REPLACE FUNCTION GapFillInternal(s anyelement, v anyelement)
RETURNS anyelement AS
$$
BEGIN
	RETURN COALESCE(v, s);
END;
$$ LANGUAGE PLPGSQL IMMUTABLE;
COMMENT ON FUNCTION GapFillInternal(s anyelement, v anyelement) IS 'The function is used to fill gaps in window functions';


-- The Window function needs an aggregate
CREATE AGGREGATE GapFill(anyelement) (
	SFUNC=GapFillInternal,
	STYPE = anyelement
)
;
COMMENT ON AGGREGATE GapFill(anyelement) IS 'Implements the aggregate function to fill gaps using the function GapFillInternal';
