SELECT substr(a,',') is true FROM t1 ORDER BY rowid;
CREATE INDEX i1 ON t1(a);
SELECT count(*) FROM t1 WHERE substr(a,',');
