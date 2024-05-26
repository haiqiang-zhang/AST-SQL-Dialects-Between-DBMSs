DROP TABLE IF EXISTS test_table;
DROP TABLE IF EXISTS test_view;
DROP TABLE IF EXISTS test_view_filtered;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE test_table (EventDate Date, CounterID UInt32,  UserID UInt64,  EventTime DateTime('America/Los_Angeles'), UTCEventTime DateTime('UTC')) ENGINE = MergeTree(EventDate, CounterID, 8192);
CREATE MATERIALIZED VIEW test_view (Rows UInt64,  MaxHitTime DateTime('America/Los_Angeles')) ENGINE = Memory AS SELECT count() AS Rows, max(UTCEventTime) AS MaxHitTime FROM test_table;
CREATE MATERIALIZED VIEW test_view_filtered (EventDate Date, CounterID UInt32) ENGINE = Memory POPULATE AS SELECT CounterID, EventDate FROM test_table WHERE EventDate < '2013-01-01';
INSERT INTO test_table (EventDate, UTCEventTime) VALUES ('2014-01-02', '2014-01-02 03:04:06');
