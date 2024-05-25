SELECT DISTINCT * FROM
    t_int AS t1,
    t_int AS t2;
SELECT DISTINCT * FROM
    t_char AS t1,
    t_char AS t2;
SELECT DISTINCT * FROM
    t_varchar AS t1,
    t_varchar AS t2;
SELECT DISTINCT * FROM
    t_text AS t1,
    t_text AS t2;
SELECT DISTINCT * FROM
    t_blob AS t1,
    t_blob AS t2;
SELECT DISTINCT * FROM
    t_json AS t1,
    t_json AS t2;
SELECT DISTINCT ST_AsText(t1.c),ST_AsText(t2.c) FROM
    t_point AS t1,
    t_point AS t2;
SELECT DISTINCT ST_AsText(t1.c),ST_AsText(t2.c) FROM
    t_geom AS t1,
    t_geom AS t2;
SELECT c,COUNT(*) FROM t_int GROUP BY c;
SELECT c,COUNT(*) FROM t_char GROUP BY c;
SELECT c,COUNT(*) FROM t_varchar GROUP BY c;
SELECT c,COUNT(*) FROM t_text GROUP BY c;
SELECT c,COUNT(*) FROM t_blob GROUP BY c;
SELECT c,COUNT(*) FROM t_json GROUP BY c;
SELECT ST_AsText(c),COUNT(*) FROM t_point GROUP BY c;
SELECT ST_AsText(c),COUNT(*) FROM t_geom GROUP BY c;
DROP TABLE t_int;
DROP TABLE t_char;
DROP TABLE t_varchar;
DROP TABLE t_text;
DROP TABLE t_blob;
DROP TABLE t_json;
DROP TABLE t_point;
DROP TABLE t_geom;
CREATE TABLE t_pk (
  pk INT NOT NULL,
  PRIMARY KEY (pk)
);
INSERT INTO t_pk VALUES
        (1),
	(2),
	(3);
SELECT COUNT(t_pk.pk) FROM t_pk
    WHERE 1 IN (SELECT 1 FROM t_pk AS SQ2_alias1
        WHERE 1 IN (SELECT 1 FROM t_pk AS C_SQ1_alias1)
    );
DROP TABLE t_pk;
CREATE TABLE t_json(json_col JSON);
INSERT INTO t_json VALUES (
    '[
        { "name":"John Johnson", "nickname": {"stringValue": "Johnny"}},
        { "name":"John Smith"}
     ]'),
     ('[
        { "name":"John Smith"},
        { "name":"John Johnson", "nickname": {"stringValue": "Johnny"}}
     ]');
SELECT attrs.* FROM t_json, JSON_TABLE(json_col, '$[*]' COLUMNS (nickname JSON PATH '$.nickname')) as attrs;
DROP TABLE t_json;
CREATE TABLE t1 (
  pk INTEGER NOT NULL,
  f1 varchar(255)
);
INSERT INTO t1 VALUES (5,'N');
CREATE TABLE t2 (
  pk int,
  f2 varchar(10)
);
INSERT INTO t2 VALUES (5,'he');
INSERT INTO t2 VALUES (5,'l');
CREATE TABLE t3 (
  f2 varchar(10),
  f3 varchar(255)
);
INSERT INTO t3 VALUES ('L','2.0');
SELECT SUM(t3.f3)
FROM t1
  LEFT JOIN t2 ON t1.pk = t2.pk
  LEFT JOIN t3 ON t2.f2 = t3.f2
GROUP BY t1.f1;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (
  f1 CHAR(0) NOT NULL,
  f2 INT NOT NULL
);
INSERT INTO t1(f1, f2) VALUES('', 1);
SELECT AVG(f1) from t1 GROUP BY f2, f1;
DROP TABLE t1;
