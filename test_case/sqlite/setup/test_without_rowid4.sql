pragma recursive_triggers = off;
CREATE TABLE tbl (a INTEGER PRIMARY KEY, b) WITHOUT rowid;
INSERT INTO tbl VALUES(1, 2);
INSERT INTO tbl VALUES(3, 4);
CREATE TABLE rlog (idx, old_a, old_b, db_sum_a, db_sum_b, new_a, new_b);
CREATE TABLE clog (idx, old_a, old_b, db_sum_a, db_sum_b, new_a, new_b);
UPDATE tbl SET a = a * 10, b = b * 10;
