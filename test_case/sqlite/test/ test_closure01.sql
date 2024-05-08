BEGIN;
CREATE TABLE t1(x INTEGER PRIMARY KEY, y INTEGER);
WITH RECURSIVE
    cnt(i) AS (VALUES(1) UNION ALL SELECT i+1 FROM cnt LIMIT 131072)
  INSERT INTO t1(x, y) SELECT i, nullif(i,1)/2 FROM cnt;
CREATE INDEX t1y ON t1(y);
WITH RECURSIVE
    below(id,depth) AS (
      VALUES(1,0)
       UNION ALL
      SELECT t1.x, below.depth+1
        FROM t1 JOIN below on t1.y=below.id
    )
  SELECT count(*), depth FROM below GROUP BY depth ORDER BY 1;
WITH RECURSIVE
    below(id,depth) AS (
      VALUES(32768,0)
       UNION ALL
      SELECT t1.x, below.depth+1
        FROM t1 JOIN below on t1.y=below.id
       WHERE below.depth<2
    )
  SELECT id, depth FROM below ORDER BY id;
WITH RECURSIVE
    below(id,depth) AS (
      VALUES(16384,0)
       UNION ALL
      SELECT t1.x, below.depth+1
        FROM t1 JOIN below on t1.y=below.id
       WHERE below.depth<2
    )
  SELECT id, depth FROM below ORDER BY id;
WITH RECURSIVE
    above(id,depth) AS (
      VALUES(16384,0)
      UNION ALL
      SELECT t1.y, above.depth+1
        FROM t1 JOIN above ON t1.x=above.id
       WHERE above.depth<3
    )
  SELECT id FROM above WHERE depth=3;
WITH RECURSIVE
    below(id,depth) AS (
      VALUES(1,0)
      UNION ALL
      SELECT t1.x, below.depth+1
        FROM t1 JOIN below ON t1.y=below.id
       WHERE below.depth<4
    )
  SELECT count(*), depth FROM below GROUP BY depth ORDER BY 1;
WITH RECURSIVE
    below(id,depth) AS (
      VALUES(1,0)
      UNION ALL
      SELECT t1.x, below.depth+1
        FROM t1 JOIN below ON t1.y=below.id
       WHERE below.depth<5
    )
  SELECT count(*), min(id), max(id) FROM below WHERE depth=5;
CREATE TABLE t4 (
    id INTEGER PRIMARY KEY, 
    name TEXT NOT NULL,
    parent_id INTEGER
  );
