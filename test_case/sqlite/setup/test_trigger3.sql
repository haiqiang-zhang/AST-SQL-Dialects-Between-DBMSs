pragma recursive_triggers = off;
CREATE TABLE tbl(a, b ,c);
BEGIN;
INSERT INTO tbl VALUES (5, 5, 6);
INSERT INTO tbl VALUES (1, 5, 6);
