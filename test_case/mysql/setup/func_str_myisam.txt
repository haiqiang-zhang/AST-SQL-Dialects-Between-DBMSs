drop table if exists t1,t2;
CREATE TABLE t1 (
  id int(10) unsigned NOT NULL,
  title varchar(255) default NULL,
  prio int(10) unsigned default NULL,
  category int(10) unsigned default NULL,
  program int(10) unsigned default NULL,
  bugdesc text,
  created datetime default NULL,
  modified timestamp NOT NULL,
  bugstatus int(10) unsigned default NULL,
  submitter int(10) unsigned default NULL
) ENGINE=MyISAM;
INSERT INTO t1 VALUES (1,'Link',1,1,1,'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa','2001-02-28 08:40:16',20010228084016,0,4);
