DROP TABLE IF EXISTS t;
CREATE TABLE t(`id` String, `dealer_id` String) ENGINE = MergeTree() ORDER BY id SETTINGS index_granularity = 8192;
insert into t(id, dealer_id) values('1','2');
