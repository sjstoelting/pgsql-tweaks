/**
 * Creates a view to get all connections and their locks.
 */
 CREATE OR REPLACE VIEW pg_active_locks AS
 SELECT DISTINCT pid
 	, state
 	, datname
 	, usename
 	, application_name
 	, client_addr
 	, query_start
 	, wait_event_type
 	, wait_event
 	, locktype
 	, mode
 	, query
 FROM pg_stat_activity AS a
 INNER JOIN pg_locks AS l
 	USING(pid)
 ;
COMMENT ON VIEW pg_active_locks IS 'Creates a view to get all connections and their locks';
