CREATE TABLE t1 (
  a tinytext NOT NULL,
  b tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY (a(32),b)
) ENGINE=MyISAM;
INSERT INTO t1 VALUES ('a',1),('a',2);
