DROP TABLE IF EXISTS local_table;
DROP TABLE IF EXISTS other_table;
CREATE TABLE local_table
(
    id Int32,
    name String,
    ts DateTime,
    oth_id Int32
) ENGINE = MergeTree() PARTITION BY toMonday(ts) ORDER BY (ts, id);
CREATE TABLE other_table
(
    id Int32,
    name String,
    ts DateTime,
    trd_id Int32
) ENGINE = MergeTree() PARTITION BY toMonday(ts) ORDER BY (ts, id);
INSERT INTO local_table VALUES(1, 'One', now(), 100);
INSERT INTO local_table VALUES(2, 'Two', now(), 200);
INSERT INTO other_table VALUES(100, 'One Hundred', now(), 1000);
INSERT INTO other_table VALUES(200, 'Two Hundred', now(), 2000);
DROP TABLE local_table;
DROP TABLE other_table;
