DROP TABLE IF EXISTS t_nested_modify;
CREATE TABLE t_nested_modify (id UInt64, `n.a` Array(UInt32), `n.b` Array(String))
ENGINE = MergeTree ORDER BY id
SETTINGS min_bytes_for_wide_part = 0;
INSERT INTO t_nested_modify VALUES (1, [2], ['aa']);
INSERT INTO t_nested_modify VALUES (2, [44, 55], ['bb', 'cc']);