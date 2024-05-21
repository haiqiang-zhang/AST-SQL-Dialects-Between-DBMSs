-- Tag no-replicated-database: Different query_id

SET prefer_localhost_replica = 1;
DROP TABLE IF EXISTS tmp;
CREATE TABLE tmp ENGINE = TinyLog AS SELECT queryID();
SYSTEM FLUSH LOGS;
SELECT query FROM system.query_log WHERE query_id = (SELECT * FROM tmp) AND current_database = currentDatabase() LIMIT 1;
DROP TABLE tmp;
CREATE TABLE tmp ENGINE = TinyLog AS SELECT initialQueryID();
SYSTEM FLUSH LOGS;
SELECT query FROM system.query_log WHERE initial_query_id = (SELECT * FROM tmp) AND current_database = currentDatabase() LIMIT 1;
DROP TABLE tmp;
CREATE TABLE tmp (str String) ENGINE = Log;
DROP TABLE tmp;