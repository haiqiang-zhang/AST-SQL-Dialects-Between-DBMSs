DROP TABLE IF EXISTS codecTest;
SET cross_to_inner_join_rewrite = 1;
CREATE TABLE codecTest (
    key      UInt64,
    name     String,
    ref_valueF64 Float64,
    ref_valueF32 Float32,
    valueF64 Float64  CODEC(FPC),
    valueF32 Float32  CODEC(FPC)
) Engine = MergeTree ORDER BY key;
INSERT INTO codecTest (key, name, ref_valueF64, valueF64, ref_valueF32, valueF32)
	SELECT number AS n, 'e()', e() AS v, v, v, v FROM system.numbers LIMIT 1, 100;
INSERT INTO codecTest (key, name, ref_valueF64, valueF64, ref_valueF32, valueF32)
	SELECT number AS n, 'log2(n)', log2(n) AS v, v, v, v FROM system.numbers LIMIT 101, 100;
INSERT INTO codecTest (key, name, ref_valueF64, valueF64, ref_valueF32, valueF32)
	SELECT number AS n, 'n*sqrt(n)', n*sqrt(n) AS v, v, v, v FROM system.numbers LIMIT 201, 100;
INSERT INTO codecTest (key, name, ref_valueF64, valueF64, ref_valueF32, valueF32)
	SELECT number AS n, 'sin(n*n*n)*n', sin(n * n * n * n* n) AS v, v, v, v FROM system.numbers LIMIT 301, 100;
