SET prefer_localhost_replica = 1;
DROP TABLE IF EXISTS tmp;
CREATE TABLE tmp ENGINE = TinyLog AS SELECT queryID();
