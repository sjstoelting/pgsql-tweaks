/**
 * Creates a function to checks a string variable for being either, NULL or ''.
 * The function is installed with a different name, is_empty_b when the
 * extension pgtap is installed as it also has an is_empty function, but with
 * a different implementation.
 * The b in is_empty_b stands for the boolean result, that the function is
 * returning.
 */
DO $$
DECLARE
	pg_extension_installed BOOLEAN;
	function_source TEXT;
BEGIN

	SELECT count(*) pgtap_exists FROM pg_extension WHERE extname = 'pgtap' INTO pg_extension_installed;

	IF NOT pg_extension_installed THEN
		-- pgtap is not installed, is_empty will be installed
		function_source :=
$string$
CREATE OR REPLACE FUNCTION is_empty(s text) RETURNS BOOLEAN AS $f1$
BEGIN
        RETURN COALESCE(s, '') = '';
END;
$f1$
LANGUAGE plpgsql IMMUTABLE
;
$string$
;
		EXECUTE function_source;

		COMMENT ON FUNCTION is_empty(s text) IS 'Checks, whether the given parameter is NULL or ''''';
	ELSE
		-- pgtap is installed, is_empty will be installed as is_empty_b
		function_source :=
$string$
CREATE OR REPLACE FUNCTION is_empty_b(s text) RETURNS BOOLEAN AS $f1$
BEGIN
        RETURN COALESCE(s, '') = '';
END;
$f1$
LANGUAGE plpgsql IMMUTABLE
;
$string$
;
		EXECUTE function_source;

		COMMENT ON FUNCTION is_empty_b(s text) IS 'Checks, whether the given parameter is NULL or ''''';
	END IF;

END $$;
