SELECT 'simple partition key:';
DROP TABLE IF EXISTS table1 SYNC;
SELECT toInt64(partition) as p FROM system.parts WHERE table='table1' and database=currentDatabase() ORDER BY p;
select 'where id % 200 = +-2:';
select 'where id % 200 > 0:';
select 'where id % 200 < 0:';
SELECT 'tuple as partition key:';
DROP TABLE IF EXISTS table2 SYNC;
CREATE TABLE table2 (id Int64, v UInt64)
ENGINE = MergeTree()
PARTITION BY (toInt32(id / 2) % 3, id % 200) ORDER BY id;
INSERT INTO table2 SELECT number-205, number FROM numbers(10);
INSERT INTO table2 SELECT number-205, number FROM numbers(400, 10);
SELECT partition as p FROM system.parts WHERE table='table2' and database=currentDatabase() ORDER BY p;
SELECT 'recursive modulo partition key:';
DROP TABLE IF EXISTS table3 SYNC;
CREATE TABLE table3 (id Int64, v UInt64)
ENGINE = MergeTree()
PARTITION BY (id % 200, (id % 200) % 10, toInt32(round((id % 200) / 2, 0))) ORDER BY id;
INSERT INTO table3 SELECT number-205, number FROM numbers(10);
INSERT INTO table3 SELECT number-205, number FROM numbers(400, 10);
SELECT partition as p FROM system.parts WHERE table='table3' and database=currentDatabase() ORDER BY p;
DETACH TABLE table3;
ATTACH TABLE table3;
SELECT 'After detach:';
SELECT partition as p FROM system.parts WHERE table='table3' and database=currentDatabase() ORDER BY p;
SELECT 'Indexes:';
DROP TABLE IF EXISTS table4 SYNC;
CREATE TABLE table4 (id Int64, v UInt64, s String,
INDEX a (id * 2, s) TYPE minmax GRANULARITY 3
) ENGINE = MergeTree() PARTITION BY id % 10 ORDER BY v;
INSERT INTO table4 SELECT number, number, toString(number) FROM numbers(1000);
SELECT count() FROM table4 WHERE id % 10 = 7;
SELECT 'comparison:';
DROP TABLE table2 SYNC;
DROP TABLE table3 SYNC;
DROP TABLE table4 SYNC;
