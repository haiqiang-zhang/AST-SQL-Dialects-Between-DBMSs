DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (
  a int(11) NOT NULL auto_increment,
  b text,
  c varchar(254) default NULL,
  PRIMARY KEY (a),
  FULLTEXT KEY bb(b),
  FULLTEXT KEY cc(c),
  FULLTEXT KEY a(b,c)
);
INSERT INTO t1 VALUES (1,'lala lolo lili','oooo aaaa pppp');
INSERT INTO t1 VALUES (2,'asdf fdsa','lkjh fghj');
INSERT INTO t1 VALUES (3,'qpwoei','zmxnvb');
