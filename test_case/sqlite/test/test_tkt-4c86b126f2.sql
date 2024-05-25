SELECT local_relpath, moved_to
   FROM nodes
  WHERE (local_relpath = 'A/B' OR
           ((local_relpath > 'A/B/') AND (local_relpath < 'A/B0')))
    AND moved_to IS NOT NULL;
CREATE TABLE t1(x TEXT UNIQUE, y TEXT UNIQUE, z);
INSERT INTO t1 VALUES('ghi','jkl','y');
SELECT * FROM t1 WHERE (x='ghi' OR y='jkl') AND z IS NOT NULL;
