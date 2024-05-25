DROP TABLE IF EXISTS data;
CREATE TABLE data (a Int64, b Int64) ENGINE = TinyLog();
DROP TABLE IF EXISTS data_distributed;
INSERT INTO data VALUES (0, 0);
SET prefer_localhost_replica = 1;
SET prefer_localhost_replica = 0;
DROP TABLE data;
