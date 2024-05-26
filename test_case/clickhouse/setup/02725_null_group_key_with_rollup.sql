set allow_suspicious_low_cardinality_types=1;
DROP TABLE IF EXISTS group_by_null_key;
CREATE TABLE group_by_null_key (c1 Nullable(Int32), c2 LowCardinality(Nullable(Int32))) ENGINE = Memory();
INSERT INTO group_by_null_key VALUES (null, null), (null, null);
