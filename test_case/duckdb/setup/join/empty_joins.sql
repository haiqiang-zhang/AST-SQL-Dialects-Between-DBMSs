PRAGMA enable_verification;
CREATE TABLE integers AS SELECT i FROM range(10) tbl(i);
CREATE TABLE integers2 AS SELECT i FROM range(10) tbl(i);
CREATE VIEW integers_empty AS SELECT * FROM integers WHERE rowid>100;
CREATE VIEW integers2_empty AS SELECT * FROM integers WHERE rowid>100;
CREATE VIEW empty_join AS SELECT * FROM integers JOIN integers2_empty USING (i);
