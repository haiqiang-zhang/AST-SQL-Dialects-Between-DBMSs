PRAGMA enable_verification;
SELECT * FROM generate_series(0,10,1) LIMIT 3 OFFSET -1;;
SELECT * FROM generate_series(0,10,1) LIMIT -3;;
SELECT * FROM generate_series(0,10,1) LIMIT -1%;
CREATE TABLE integers AS SELECT -1 k;;
SELECT * FROM generate_series(0,10,1) LIMIT (SELECT k FROM integers);;
SELECT * FROM generate_series(0,10,1) LIMIT 1 OFFSET (SELECT k FROM integers);;