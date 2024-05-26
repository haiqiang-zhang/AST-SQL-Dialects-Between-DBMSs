CREATE TABLE t1 (
  `pseudo` char(35) NOT NULL default '',
  `pseudo1` char(35) NOT NULL default '',
  `same` tinyint(1) unsigned NOT NULL default '1',
  PRIMARY KEY  (`pseudo1`),
  KEY `pseudo` (`pseudo`)
) ENGINE=MyISAM;
INSERT INTO t1 (pseudo,pseudo1,same) VALUES ('joce', 'testtt', 1),('joce', 'tsestset', 1),('dekad', 'joce', 1);
