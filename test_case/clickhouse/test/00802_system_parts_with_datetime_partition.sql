DROP TABLE IF EXISTS datetime_table;
CREATE TABLE datetime_table
  (
    t DateTime('UTC'),
    name String,
    value UInt32
  ) ENGINE = MergeTree()
    ORDER BY (t, name)
	PARTITION BY value;
INSERT INTO datetime_table VALUES ('2016-01-01 00:00:00','name1',2);
INSERT INTO datetime_table VALUES ('2016-01-02 00:00:00','name2',2);
INSERT INTO datetime_table VALUES ('2016-01-03 00:00:00','name1',4);
DROP TABLE IF EXISTS datetime_table;
CREATE TABLE datetime_table
  (
    t DateTime('UTC'),
    name String,
    value UInt32
  ) ENGINE = MergeTree()
    ORDER BY (t, name)
	PARTITION BY toStartOfDay(t);
INSERT INTO datetime_table VALUES ('2016-01-01 00:00:00','name1',2);
INSERT INTO datetime_table VALUES ('2016-01-01 02:00:00','name1',3);
INSERT INTO datetime_table VALUES ('2016-01-02 01:00:00','name2',2);
INSERT INTO datetime_table VALUES ('2016-01-02 23:00:00','name2',5);
INSERT INTO datetime_table VALUES ('2016-01-03 04:00:00','name1',4);
DROP TABLE IF EXISTS datetime_table;
CREATE TABLE datetime_table
  (
    t DateTime('UTC'),
    name String,
    value UInt32
  ) ENGINE = MergeTree()
    ORDER BY (t, name)
        PARTITION BY (name, toUInt32(toUnixTimestamp(t)/(60*60*24)) );
INSERT INTO datetime_table VALUES (1451606400,'name1',2);
INSERT INTO datetime_table VALUES (1451613600,'name1',3);
INSERT INTO datetime_table VALUES (1451696400,'name2',2);
INSERT INTO datetime_table VALUES (1451775600,'name2',5);
INSERT INTO datetime_table VALUES (1451793600,'name1',4);
DROP TABLE IF EXISTS datetime_table;
