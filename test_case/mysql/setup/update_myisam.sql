CREATE TABLE t1 (
  lfdnr int(10) unsigned NOT NULL default '0',
  ticket int(10) unsigned NOT NULL default '0',
  client varchar(255) NOT NULL default '',
  replyto varchar(255) NOT NULL default '',
  subject varchar(100) NOT NULL default '',
  timestamp int(10) unsigned NOT NULL default '0',
  tstamp timestamp NOT NULL,
  status int(3) NOT NULL default '0',
  type varchar(15) NOT NULL default '',
  assignment int(10) unsigned NOT NULL default '0',
  fupcount int(4) unsigned NOT NULL default '0',
  parent int(10) unsigned NOT NULL default '0',
  activity int(10) unsigned NOT NULL default '0',
  priority tinyint(1) unsigned NOT NULL default '1',
  cc varchar(255) NOT NULL default '',
  bcc varchar(255) NOT NULL default '',
  body text NOT NULL,
  comment text,
  header text,
  PRIMARY KEY  (lfdnr),
  KEY k1 (timestamp),
  KEY k2 (type),
  KEY k3 (parent),
  KEY k4 (assignment),
  KEY ticket (ticket)
) ENGINE=MyISAM;
INSERT INTO t1 VALUES (773,773,'','','',980257344,20010318180652,0,'Open',10,0,0,0,1,'','','','','');
alter table t1 change lfdnr lfdnr int(10) unsigned not null auto_increment;
update t1 set status=1 where type='Open';
