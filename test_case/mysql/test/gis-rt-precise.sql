DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (
  fid INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  g GEOMETRY NOT NULL SRID 0,
  SPATIAL KEY(g)
) ENGINE=MyISAM;
let $1=150;
let $2=150;
{
  eval INSERT INTO t1 (g) VALUES (ST_GeomFromText('LineString($1 $1, $2 $2)'));
  dec $1;
  inc $2;

SELECT count(*) FROM t1;
SELECT fid, ST_AsText(g) FROM t1 WHERE ST_Within(g, ST_GeomFromText('Polygon((140 140,160 140,160 160,140 160,140 140))'));

DROP TABLE t1;

CREATE TABLE t1 (
  fid INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  g GEOMETRY NOT NULL SRID 0
) ENGINE=MyISAM;
let $1=10;
{
  let $2=10;
  {
    eval INSERT INTO t1 (g) VALUES (LineString(Point($1 * 10 - 9, $2 * 10 - 9), Point($1 * 10, $2 * 10)));
    dec $2;
  }
  dec $1;

ALTER TABLE t1 ADD SPATIAL KEY(g);
SELECT count(*) FROM t1;
SELECT fid, ST_AsText(g) FROM t1 WHERE ST_Within(g, 
  ST_GeomFromText('Polygon((40 40,60 40,60 60,40 40))'));

DROP TABLE t1;
