SET allow_suspicious_low_cardinality_types = 1;
DROP TABLE IF EXISTS constraint_on_nullable_type;
CREATE TABLE constraint_on_nullable_type
(
    `id` Nullable(UInt64),
    CONSTRAINT `c0` CHECK `id` = 1
)
ENGINE = TinyLog();
INSERT INTO constraint_on_nullable_type VALUES (1);
SELECT * FROM constraint_on_nullable_type;
DROP TABLE constraint_on_nullable_type;
DROP TABLE IF EXISTS constraint_on_low_cardinality_type;
DROP TABLE IF EXISTS constraint_on_low_cardinality_nullable_type;
