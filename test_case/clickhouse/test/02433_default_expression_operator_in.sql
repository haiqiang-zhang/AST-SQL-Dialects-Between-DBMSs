DROP TABLE IF EXISTS dep;
DROP TABLE IF EXISTS dep2;
DROP TABLE IF EXISTS id_join;
CREATE TABLE id_join (`country` String, `location` Array(Int32)) ENGINE = Join(ANY, LEFT, country);
INSERT INTO id_join values ('CLICK', [1234]);
CREATE TABLE dep
(
    `id` Int32,
    `country` LowCardinality(String),
    `purchase_location` UInt16 MATERIALIZED if(id IN joinGet(concat(currentDatabase(), '.id_join'), 'location', 'CLICK'), 123, 456)
)
ENGINE = ReplicatedMergeTree('/test/02433/{database}/dep', '1') ORDER BY tuple();
SHOW CREATE TABLE dep;
TRUNCATE TABLE id_join;
CREATE TABLE dep2
(
    `id` Int32,
    `country` LowCardinality(String),
    `purchase_location` UInt16 MATERIALIZED if(id IN joinGet(concat(currentDatabase(), '.id_join'), 'location', 'CLICK'), 123, 456)
)
ENGINE = ReplicatedMergeTree('/test/02433/{database}/dep', '2') ORDER BY tuple();
SHOW CREATE TABLE dep2;
create table test (n int, m default n in 'default.table_name') engine=Memory;
create table test (n int, m default in(n, 'default.table_name')) engine=Memory;
DROP TABLE dep;
DROP TABLE dep2;
DROP TABLE id_join;