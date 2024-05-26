PRAGMA enable_verification;
CREATE TABLE t1 (id INTEGER, ch CHAR(1));
INSERT INTO t1 VALUES (1, 'A');
INSERT INTO t1 VALUES (2, 'B');
INSERT INTO t1 VALUES (NULL, 'B');
PRAGMA disable_verification;
