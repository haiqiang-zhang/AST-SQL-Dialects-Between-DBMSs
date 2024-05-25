SET wal_autocheckpoint='1GB';
CREATE TABLE tbl (n TEXT[]);;
INSERT INTO tbl (n) SELECT CASE WHEN i<100 THEN ['a', 'b'] ELSE [] END l FROM range(1026) t(i);;
INSERT INTO tbl (n) SELECT CASE WHEN i<100 THEN ['a', 'b'] ELSE [] END l FROM range(1026) t(i);;
INSERT INTO tbl (n) SELECT CASE WHEN i<100 THEN ['a', 'b'] ELSE [] END l FROM range(1026) t(i);;
FROM tbl;
