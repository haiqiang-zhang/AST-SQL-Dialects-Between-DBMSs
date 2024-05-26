PRAGMA enable_verification;
CREATE TABLE tbl(id INTEGER, i INET);
CREATE VIEW iview AS SELECT INET '::1';
INSERT INTO tbl VALUES (1, '::1'), (2, NULL), (3, '2266:25::12:0:ad12/96'), (4, '::/0');
