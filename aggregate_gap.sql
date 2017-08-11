-- Create a window function to calculate values for gaps
CREATE OR REPLACE FUNCTION GapFillInternal(
	s anyelement,
	v anyelement
)
RETURNS anyelement AS
$$
BEGIN
	RETURN COALESCE(v, s);
END;
$$ LANGUAGE PLPGSQL IMMUTABLE;

-- The Window function needs an aggregate
CREATE AGGREGATE GapFill(anyelement) (
	SFUNC=GapFillInternal,
	STYPE = anyelement
)
;
