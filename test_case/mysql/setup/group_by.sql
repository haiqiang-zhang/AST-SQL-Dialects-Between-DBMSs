drop table if exists t1,t2,t3;
CREATE TABLE t1 (
  spID int(10) unsigned,
  userID int(10) unsigned,
  score smallint(5) unsigned,
  lsg char(40),
  date date
);
CREATE TABLE t2 (
  userID int(10) unsigned NOT NULL auto_increment,
  niName char(15),
  passwd char(8),
  mail char(50),
  isAukt enum('N','Y') DEFAULT 'N',
  vName char(30),
  nName char(40),
  adr char(60),
  plz char(5),
  ort char(35),
  land char(20),
  PRIMARY KEY (userID)
);
INSERT INTO t2 VALUES (1,'name','pass','mail','Y','v','n','adr','1','1','1');
INSERT INTO t2 VALUES (2,'name','pass','mail','Y','v','n','adr','1','1','1');
INSERT INTO t2 VALUES (3,'name','pass','mail','Y','v','n','adr','1','1','1');
INSERT INTO t2 VALUES (4,'name','pass','mail','Y','v','n','adr','1','1','1');
INSERT INTO t2 VALUES (5,'name','pass','mail','Y','v','n','adr','1','1','1');
