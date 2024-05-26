PREPARE v1 AS SELECT * FROM generate_series(0, 10000, 1) tbl(i) ORDER BY i DESC LIMIT ?::VARCHAR;
PREPARE v1 AS SELECT * FROM generate_series(0, 10000, 1) tbl(i) ORDER BY i DESC LIMIT ?::VARCHAR %;
CREATE TABLE doubles AS SELECT 0.05 d;
SELECT * FROM generate_series(0, 10000, 1) tbl(i) ORDER BY i DESC LIMIT 5;
SELECT * FROM generate_series(0, 10000, 1) tbl(i) ORDER BY i DESC LIMIT (SELECT k FROM integers);
SELECT * FROM generate_series(0, 10000, 1) tbl(i) ORDER BY i DESC LIMIT (SELECT k FROM strings);
EXECUTE v1(5);
EXECUTE v1('0.05');
SELECT * FROM generate_series(0, 10000, 1) tbl(i) ORDER BY i DESC LIMIT (SELECT d FROM doubles) %;
