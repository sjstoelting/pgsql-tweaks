/**
 * Creates a function to convert a hexadicimal number given as string into a BIGINT.
 */
 CREATE OR REPLACE FUNCTION hex2bigint(s TEXT) RETURNS BIGINT AS $$
 	WITH RECURSIVE hex_sep AS
 		(
 			SELECT
 			  	cast (cast (cast ('x0' || substring (s, length (s), 1) AS BIT(8)) AS INT) * POWER(16, 0) AS BIGINT ) int_res
 				, substring (s, 1 , length (s) - 1) AS rest
 				, length (s) - 1 AS len
 				, 1 AS row_num
 			UNION ALL
 			SELECT
 				cast (cast (cast ('x0' || substring (rest, length (rest), 1) AS BIT(8)) AS INT)  * POWER(16, row_num) AS BIGINT) int_res
 				, substring (rest, 1 , length (rest) - 1) AS rest
 				, length (rest) - 1 AS len
 				, row_num + 1 AS row_num
 			FROM hex_sep
 			WHERE len > 0
 		)
 	SELECT cast (sum(int_res)AS BIGINT)
 	FROM hex_sep
 	;
 $$ LANGUAGE sql IMMUTABLE STRICT
 ;
COMMENT ON FUNCTION hex2bigint(s TEXT) IS 'Converts a hexadicimal number given as string into a BIGINT';
