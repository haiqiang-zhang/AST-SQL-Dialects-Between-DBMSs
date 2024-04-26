SET SESSION information_schema_stats_expiry=0;

-- time_zone table name is used here to set debug point
-- kill_query_on_open_table_from_tz_find from the
-- simulate_kill_query_on_open_table debug point.
CREATE TABLE time_zone(f1 INT PRIMARY KEY) ENGINE=MyISAM;
INSERT INTO time_zone VALUES (10);

SET SESSION DEBUG="+d,simulate_kill_query_on_open_table";
SELECT * FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_SCHEMA='test' AND
                                                  TABLE_NAME = 'time_zone';
SET SESSION DEBUG="-d,simulate_kill_query_on_open_table";

DROP TABLE time_zone;
SET SESSION information_schema_stats_expiry=default;
