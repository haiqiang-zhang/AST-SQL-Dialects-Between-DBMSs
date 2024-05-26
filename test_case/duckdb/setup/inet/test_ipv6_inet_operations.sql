SET default_null_order='nulls_first';
PRAGMA enable_verification;
CREATE TABLE tbl(id INTEGER, i INET);
INSERT INTO tbl VALUES (1, '::1'), (2, NULL), (3, 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff/127'), (4, '::/0'), (5, '::1/128'), (6, '::1/127');
CREATE TABLE tbl2(id INTEGER, j INET);
INSERT INTO tbl2 VALUES (3, '::1');
