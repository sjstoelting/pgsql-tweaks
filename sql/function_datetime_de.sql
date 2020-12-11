/**
 * Creates a function which returns the given timestamp in German format.
 * The second parameter indicates, if the result is with or without time zone,
 * default is with thime zone
 */
 CREATE OR REPLACE FUNCTION datetime_de(t TIMESTAMP WITH TIME ZONE, with_tz BOOLEAN DEFAULT TRUE) RETURNS text AS $$
 BEGIN
 	IF with_tz THEN
 		RETURN to_char(t, 'DD.MM.YYYY HH24:MI:SS TZ');
 	ELSE
 		RETURN to_char(t, 'DD.MM.YYYY HH24:MI:SS');
 	END IF;
 END;
 $$
 STRICT
 LANGUAGE plpgsql IMMUTABLE;
 COMMENT ON FUNCTION datetime_de(t TIMESTAMP WITH TIME ZONE, with_tz BOOLEAN) IS 'Creates a function which returns the given timestamp in German format';
