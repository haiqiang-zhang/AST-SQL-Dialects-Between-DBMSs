DROP TABLE IF EXISTS counter;
CREATE TABLE counter (id UInt64, createdAt DateTime) ENGINE = MergeTree() ORDER BY id;
INSERT INTO counter SELECT number, now() FROM numbers(500);
DROP TABLE IF EXISTS vcounter;
CREATE VIEW vcounter AS SELECT intDiv(id, 10) AS tens, max(createdAt) AS maxid FROM counter GROUP BY tens;
