SELECT round(toDecimal32(2, 2) * 1.2, 6);
CREATE TABLE IF NOT EXISTS test01603 (
    f64 Float64,
    d Decimal64(3) DEFAULT toDecimal32(f64, 3),
    f32 Float32 DEFAULT f64
) ENGINE=MergeTree() ORDER BY f32;
INSERT INTO test01603(f64) SELECT 1 / (number + 1) FROM system.numbers LIMIT 1000;
DROP TABLE IF EXISTS test01603;
