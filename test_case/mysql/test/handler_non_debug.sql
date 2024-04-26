
-- Contents of this test file may be moved into main handler test file
-- when bug#25987758 has been fixed

CREATE SCHEMA s1;

CREATE TABLE s1.t1(c1 INTEGER, c2 INTEGER, KEY k1(c1), KEY k2(c2));
INSERT INTO s1.t1 VALUES (1,10), (2,20), (3,30);

CREATE USER u1@localhost;

-- Enable the lines below when bug#25987758 has been fixed
--
--REVOKE SELECT(c1) ON s1.t1 FROM u1@localhost;

DROP USER u1@localhost;

DROP TABLE s1.t1;
DROP SCHEMA s1;
