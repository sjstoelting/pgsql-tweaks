CREATE OR REPLACE FUNCTION is_date(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
  PERFORM s::date;
  RETURN TRUE;
EXCEPTION WHEN OTHERS THEN
  RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_date(s VARCHAR) IS 'Takes a varchar and checks if it is a date, uses standard date format YYYY-MM-DD';


CREATE OR REPLACE FUNCTION is_date(s VARCHAR, f VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
  PERFORM to_date(s, f);
  RETURN TRUE;
EXCEPTION WHEN OTHERS THEN
  RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE
;
COMMENT ON FUNCTION is_date(s VARCHAR, f VARCHAR) IS 'Takes a varchar and checks if it is a date by taking the second varchar as date format';
