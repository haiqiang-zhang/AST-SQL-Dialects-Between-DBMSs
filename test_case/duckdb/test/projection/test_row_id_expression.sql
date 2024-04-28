PRAGMA enable_verification;
create table a(i integer);;
insert into a values (42);;
INSERT INTO a SELECT rowid FROM a;
UPDATE a SET i=rowid;
SELECT rowid + 1, rowid - 1, rowid + rowid, i + rowid FROM a;
SELECT -rowid, +rowid, abs(rowid) FROM a;
SELECT rowid BETWEEN -1 AND 1, 0 BETWEEN rowid AND 1, 1 BETWEEN -3 AND rowid FROM a;
SELECT rowid < i, rowid = NULL, rowid = i, rowid <> 0 FROM a;
SELECT SUM(rowid), MIN(rowid), MAX(rowid), COUNT(rowid), FIRST(rowid) FROM a;
SELECT SUM(rowid), MIN(rowid), MAX(rowid), COUNT(rowid), LAST(rowid) FROM a;
SELECT COUNT(*) FROM a;
SELECT SUM(rowid), MIN(rowid), MAX(rowid), COUNT(rowid), FIRST(rowid), LAST(rowid) FROM a GROUP BY i;
SELECT SUM(i) FROM a GROUP BY rowid;
SELECT * FROM a, a a2 WHERE a.rowid=a2.rowid;
SELECT * FROM a, a a2 WHERE a.rowid<>a2.rowid;
SELECT * FROM a, a a2 WHERE a.rowid>=a2.rowid;
SELECT * FROM a ORDER BY rowid;
SELECT * FROM a ORDER BY 1;
SELECT * FROM a ORDER BY 1;
SELECT * FROM a WHERE rowid=0;
SELECT * FROM a WHERE rowid BETWEEN -100 AND 100 ORDER BY 1;
SELECT * FROM a WHERE rowid=0 OR rowid=1;
SELECT row_number() OVER (PARTITION BY rowid) FROM a ORDER BY rowid;
SELECT row_number() OVER (ORDER BY rowid) FROM a ORDER BY rowid;
SELECT row_number() OVER (ORDER BY rowid DESC) FROM a ORDER BY rowid;
SELECT (SELECT rowid FROM a LIMIT 1);
SELECT 0 IN (SELECT rowid FROM a);
SELECT EXISTS(SELECT rowid FROM a);
SELECT (SELECT a2.rowid FROM a a2 WHERE a.rowid=a2.rowid) FROM a;
SELECT a.rowid IN (SELECT a2.rowid FROM a a2 WHERE a.rowid>=a2.rowid) FROM a;
SELECT EXISTS(SELECT a2.rowid FROM a a2 WHERE a.rowid>=a2.rowid) FROM a;
