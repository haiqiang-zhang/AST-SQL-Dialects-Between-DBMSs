DROP TABLE IF EXISTS set_index__fuzz_41;
CREATE TABLE set_index__fuzz_41 (`a` Date, `b` Nullable(DateTime64(3)), INDEX b_set b TYPE set(0) GRANULARITY 1) ENGINE = MergeTree ORDER BY tuple();
INSERT INTO set_index__fuzz_41 (a) VALUES (today());
DROP TABLE set_index__fuzz_41;
