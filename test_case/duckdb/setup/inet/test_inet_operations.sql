SET default_null_order='nulls_first';
PRAGMA enable_verification;
CREATE TABLE tbl(id INTEGER, i INET);
INSERT INTO tbl VALUES (1, '127.0.0.1'), (2, NULL), (3, '255.255.255.255/31'), (4, '0.0.0.0/0'), (5, '127.0.0.1/32'), (6, '127.0.0.1/31');
CREATE TABLE tbl2(id INTEGER, j INET);
INSERT INTO tbl2 VALUES (3, '127.0.0.1');
