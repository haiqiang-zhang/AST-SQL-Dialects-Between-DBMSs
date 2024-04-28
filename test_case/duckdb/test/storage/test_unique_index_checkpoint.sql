CREATE TABLE test(i INTEGER, j INTEGER);;
INSERT INTO test VALUES (1,100),(2,200);;
CREATE UNIQUE INDEX idx ON test (i);;
INSERT INTO test VALUES (1,101),(2,201);;
CREATE TABLE IF NOT EXISTS unique_index_test AS
SELECT i AS ordernumber, j AS quantity FROM test;;
CREATE UNIQUE INDEX unique_index_test_ordernumber_idx_unique ON unique_index_test (ordernumber);;
INSERT INTO unique_index_test VALUES (1,101),(2,201);;
