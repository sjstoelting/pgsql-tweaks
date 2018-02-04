/**
 * Creates a function which returns the given timestamp in German format.
 */
 CREATE OR REPLACE FUNCTION datetime_de(t TIMESTAMP WITH TIME ZONE, with_tz BOOLEAN DEFAULT FALSE) RETURNS VARCHAR AS $$
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
 COMMENT ON FUNCTION datetime_de(t TIMESTAMP) IS 'Creates a function which returns the given timestamp in German format';
