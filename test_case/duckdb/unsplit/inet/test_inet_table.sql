PRAGMA enable_verification;
CREATE TABLE tbl(id INTEGER, i INET);
INSERT INTO tbl VALUES (1, '127.0.0.1'), (2, NULL), (3, '255.255.255.255/31'), (4, '0.0.0.0/0'), (5, '::1'), (6, NULL), (7, '2266:25::12:0:ad12/96'), (8, '::/0');
SELECT i FROM tbl ORDER BY id;
SELECT i FROM tbl WHERE id%2=1 ORDER BY id;
SELECT host(i) FROM tbl WHERE id%2=1 ORDER BY id;
