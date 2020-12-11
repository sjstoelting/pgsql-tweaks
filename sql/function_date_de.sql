/**
 * Creates a function which returns the given date in German format.
 */
 CREATE OR REPLACE FUNCTION date_de(d DATE) RETURNS text AS $$
 BEGIN
	RETURN to_char(d, 'DD.MM.YYYY');
 END;
 $$
 STRICT
 LANGUAGE plpgsql IMMUTABLE;
 COMMENT ON FUNCTION date_de(d DATE) IS 'Creates a function which returns the given date in German format';
