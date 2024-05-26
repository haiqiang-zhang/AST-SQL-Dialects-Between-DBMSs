CREATE TABLE t1 (
  reckey int unsigned NOT NULL,
  recdesc varchar(50) NOT NULL,
  PRIMARY KEY  (reckey)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
INSERT INTO t1 VALUES (108, 'Has 108 as key');
INSERT INTO t1 VALUES (109, 'Has 109 as key');
