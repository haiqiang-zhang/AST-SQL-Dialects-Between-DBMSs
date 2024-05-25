PRAGMA enable_verification;
CREATE TABLE tbl(id INTEGER, i INET);;
CREATE VIEW iview AS SELECT INET '::1';
INSERT INTO tbl VALUES (1, '::1'), (2, NULL), (3, '2266:25::12:0:ad12/96'), (4, '::/0');
DESCRIBE tbl;
DESCRIBE tbl;
SELECT i FROM tbl ORDER BY id;
SELECT i FROM tbl WHERE id%2=1 ORDER BY id;
SELECT * FROM iview;
