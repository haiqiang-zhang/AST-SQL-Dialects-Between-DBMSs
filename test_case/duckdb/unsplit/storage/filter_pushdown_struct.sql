CREATE TABLE tbl (a STRUCT("id" VARCHAR), b STRUCT("id" VARCHAR));;
INSERT INTO tbl SELECT {'id': LPAD(i::VARCHAR, 4, '0')}, {'id': 'abc'} FROM range(10000) t(i);
INSERT INTO tbl SELECT {'id': LPAD((i + 10000)::VARCHAR, 4, '0')}, {'id': 'bcd'} FROM range(10000) t(i);
SELECT COUNT(*) FROM (SELECT * FROM tbl WHERE b.id='abc') t;
SELECT COUNT(*) FROM (SELECT * FROM tbl WHERE b.id='abc') t;
SELECT COUNT(*) FROM (SELECT * FROM tbl WHERE b.id='bcd') t;
