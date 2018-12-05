/**
 * Creates a function which returns a SHA256 hash for the given string.
 *
 * The function needs the pgcrypto package, this is checked on the installation.
 */
DO $$
DECLARE
	pg_extension_installed BOOLEAN;
	function_source TEXT; 
BEGIN

	SELECT count(*) = 1 AS pgcrypto_installed FROM pg_extension WHERE extname = 'pgcrypto' INTO pg_extension_installed;

	IF pg_extension_installed THEN
		-- The pgcrypto extension is installed, sha256 will be installed
		function_source :=  
$string$
CREATE OR REPLACE FUNCTION sha256(bytea) RETURNS text AS $f1$
	SELECT ENCODE(digest($1, 'sha256'), 'hex')
$f1$ LANGUAGE SQL STRICT IMMUTABLE
;
$string$
;

		EXECUTE function_source;

		COMMENT ON FUNCTION sha256(bytea) IS 'Returns a SHA254 hash for the given string';
	END IF;

END $$;
