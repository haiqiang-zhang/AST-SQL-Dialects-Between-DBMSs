drop table if exists t1,t2,t3;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
CREATE TABLE t1
(
FOLDERID VARCHAR(32)BINARY NOT NULL
, FOLDERNAME VARCHAR(255)BINARY NOT NULL
, CREATOR VARCHAR(255)BINARY
, CREATED TIMESTAMP NOT NULL
, DESCRIPTION VARCHAR(255)BINARY
, FOLDERTYPE INTEGER NOT NULL
, MODIFIED TIMESTAMP
, MODIFIER VARCHAR(255)BINARY
, FOLDERSIZE INTEGER NOT NULL
, PARENTID VARCHAR(32)BINARY
, REPID VARCHAR(32)BINARY
, ORIGINATOR INTEGER

, PRIMARY KEY ( FOLDERID )
) ENGINE=InnoDB;
CREATE INDEX FFOLDERID_IDX ON t1 (FOLDERID);
CREATE INDEX CMFLDRPARNT_IDX ON t1 (PARENTID);
INSERT INTO t1 VALUES("0c9aab05b15048c59bc35c8461507deb", "System", "System", "2003-06-05 16:30:00", "The system content repository folder.", "3", "2003-06-05 16:30:00", "System", "0", NULL, "9c9aab05b15048c59bc35c8461507deb", "1");
INSERT INTO t1 VALUES("2f6161e879db43c1a5b82c21ddc49089", "Default", "System", "2003-06-09 10:52:02", "The default content repository folder.", "3", "2003-06-05 16:30:00", "System", "0", NULL, "03eea05112b845949f3fd03278b5fe43", "1");
INSERT INTO t1 VALUES("c373e9f5ad0791724315444553544200", "AddDocumentTest", "admin", "2003-06-09 10:51:25", "Movie Reviews", "0", "2003-06-09 10:51:25", "admin", "0", "2f6161e879db43c1a5b82c21ddc49089", "03eea05112b845949f3fd03278b5fe43", NULL);
SELECT 'c373e9f5ad0791a0dab5444553544200' IN(SELECT t1.FOLDERID FROM t1 WHERE t1.PARENTID='2f6161e879db43c1a5b82c21ddc49089' AND t1.FOLDERNAME = 'Level1');
drop table t1;

--
-- UNION unlocking test
--
create table t1 (a int) engine=innodb;
create table t2 (a int) engine=innodb;
create table t3 (a int) engine=innodb;
insert into t1 values (1),(2),(3),(4);
insert into t2 values (10),(20),(30),(40);
insert into t3 values (1),(2),(10),(50);
select a from t3 where t3.a in (select a from t1 where a <= 3 union select * from t2 where a <= 30);
drop table t1,t2,t3;


CREATE TABLE t1 (
   processor_id INTEGER NOT NULL,
   PRIMARY KEY (processor_id)
) ENGINE=InnoDB;
CREATE TABLE t3 (
   yod_id BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
   login_processor INTEGER UNSIGNED ,
   PRIMARY KEY (yod_id)
) ENGINE=InnoDB;
CREATE TABLE t2 (
   processor_id INTEGER NOT NULL,
   yod_id BIGINT UNSIGNED NOT NULL,
   PRIMARY KEY (processor_id, yod_id),
   INDEX (processor_id),
   INDEX (yod_id),
   FOREIGN KEY (processor_id) REFERENCES t1(processor_id),
   FOREIGN KEY (yod_id) REFERENCES t3(yod_id) 
) ENGINE=InnoDB;
INSERT INTO t1 VALUES (1),(2),(3);
INSERT INTO t3 VALUES (1,1),(2,2),(3,3);
INSERT INTO t2 VALUES (1,1),(2,2),(3,3);
SELECT distinct p1.processor_id, (SELECT y.yod_id FROM t1 p2, t2 y WHERE p2.processor_id = p1.processor_id and p2.processor_id = y.processor_id) FROM t1 p1;
drop table t2,t1,t3;

--
-- innodb locking
--
CREATE TABLE t1 (
  id int(11) NOT NULL default '0',
  b int(11) default NULL,
  c char(3) default NULL,
  PRIMARY KEY  (id),
  KEY t2i1 (b)
) ENGINE=innodb DEFAULT CHARSET=latin1;
INSERT INTO t1 VALUES (0,0,'GPL'),(1,0,'GPL'),(2,1,'GPL'),(3,2,'GPL');
CREATE TABLE t2 (
  id int(11) NOT NULL default '0',
  b int(11) default NULL,
  c char(3) default NULL,
  PRIMARY KEY  (id),
  KEY t2i (b)
) ENGINE=innodb DEFAULT CHARSET=latin1;
INSERT INTO t2 VALUES (0,0,'GPL'),(1,0,'GPL'),(2,1,'GPL'),(3,2,'GPL');
select (select max(id) from t2 where b=1 group by b) as x,b from t1 where b=1;
drop table t1,t2;

--
-- reiniting innodb tables
--
create table t1 (id int not null, value char(255), primary key(id)) engine=innodb;
create table t2 (id int not null, value char(255)) engine=innodb;
insert into t1 values (1,'a'),(2,'b');
insert into t2 values (1,'z'),(2,'x');
select t2.id,t2.value,(select t1.value from t1 where t1.id=t2.id) from t2;
select t2.id,t2.value,(select t1.value from t1 where t1.id=t2.id) from t2;
drop table t1,t2;

--
-- unlocking tables with subqueries in HAVING
--
create table t1 (a int, b int) engine=innodb;
insert into t1 values (1,2), (1,3), (2,3), (2,4), (2,5), (3,4), (4,5), (4,100);
create table t2 (a int) engine=innodb;
insert into t2 values (1),(2),(3),(4);
select a, sum(b) as b from t1 group by a having b > (select max(a) from t2);
drop table t1, t2;

--
-- bug #5220 test suite
--
CREATE TABLE `t1` ( `unit` varchar(50) NOT NULL default '', `ingredient` varchar(50) NOT NULL default '') ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `t2` ( `ingredient` varchar(50) NOT NULL default '', `unit` varchar(50) NOT NULL default '', PRIMARY KEY (ingredient, unit)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `t1` VALUES ('xx','yy');
INSERT INTO `t2` VALUES ('yy','xx');

SELECT R.unit, R.ingredient FROM t1 R WHERE R.ingredient IN (SELECT N.ingredient FROM t2 N WHERE N.unit = R.unit);

drop table t1, t2;

--
-- possible early unlock
--
CREATE TABLE t1 (
  id INT NOT NULL auto_increment,
  date1 DATE, coworkerid INT,
  description VARCHAR(255),
  sum_used DOUBLE,
  sum_remaining DOUBLE,
  comments VARCHAR(255),
  PRIMARY KEY(id)
) engine=innodb;
insert into t1 values (NULL, '1999-01-01', 1,'test', 22, 33, 'comment'), (NULL, '1999-01-01', 1,'test', 22, 33, 'comment'), (NULL, '1999-01-01', 1,'test', 22, 33, 'comment'), (NULL, '1998-01-01', 1,'test', 22, 33, 'comment'), (NULL, '1998-01-01', 1,'test', 22, 33, 'comment'), (NULL, '2004-01-01', 1,'test', 22, 33, 'comment'), (NULL, '2004-01-01', 1,'test', 22, 33, 'comment');
SELECT DISTINCT
 (SELECT sum(sum_used) FROM t1 WHERE sum_used > 0 AND year(date1) <= '2004') as somallontvangsten,
 (SELECT sum(sum_used) FROM t1 WHERE sum_used < 0 AND year(date1) <= '2004') as somalluitgaven
 FROM t1;
select * from t1;
drop table t1;

--
-- cleaning up of results of subselects (BUG#8125)
--
CREATE TABLE `t1` ( `a` char(3) NOT NULL default '', `b` char(3) NOT NULL default '', `c` char(3) NOT NULL default '', PRIMARY KEY  (`a`,`b`,`c`)) ENGINE=InnoDB;
CREATE TABLE t2 LIKE t1;
INSERT INTO t1 VALUES (1,1,1);
INSERT INTO t2 VALUES (1,1,1);
drop table t1,t2;

--
-- test of big query with a lot of IN subqueries.
--
CREATE TABLE t1
(
DOCID VARCHAR(32)BINARY NOT NULL
, UUID VARCHAR(32)BINARY NOT NULL
, MIMETYPE VARCHAR(80)BINARY
, CONTENTDATA LONGBLOB
, CONTENTSIZE INTEGER
, VERSIONID INTEGER
, REPID VARCHAR(32)BINARY
, MODIFIED TIMESTAMP
, MODIFIER VARCHAR(255)BINARY
, ORIGINATOR INTEGER

, PRIMARY KEY ( DOCID )
) charset utf8mb4 ENGINE=InnoDB
;

INSERT INTO t1 (DOCID) VALUES ("1"), ("2");

CREATE TABLE t2
(
DOCID VARCHAR(32)BINARY NOT NULL
, DOCNAME VARCHAR(255)BINARY NOT NULL
, DOCTYPEID VARCHAR(32)BINARY NOT NULL
, FOLDERID VARCHAR(32)BINARY NOT NULL
, AUTHOR VARCHAR(255)BINARY
, CREATED TIMESTAMP NOT NULL
, TITLE VARCHAR(255)BINARY
, SUBTITLE VARCHAR(255)BINARY
, DOCABSTRACT LONGBLOB
, PUBLISHDATE TIMESTAMP
, EXPIRATIONDATE TIMESTAMP
, LOCKEDBY VARCHAR(80)BINARY
, STATUS VARCHAR(80)BINARY
, PARENTDOCID VARCHAR(32)BINARY
, REPID VARCHAR(32)BINARY
, MODIFIED TIMESTAMP NOT NULL
, MODIFIER VARCHAR(255)BINARY NOT NULL
, PUBLISHSTATUS INTEGER
, ORIGINATOR INTEGER

, PRIMARY KEY ( DOCID )
) charset utf8mb4 ENGINE=InnoDB
;
CREATE INDEX DDOCTYPEID_IDX ON t2 (DOCTYPEID);
CREATE INDEX DFOLDERID_IDX ON t2 (FOLDERID);
CREATE TABLE t3
(
FOLDERID VARCHAR(32)BINARY NOT NULL
, FOLDERNAME VARCHAR(255)BINARY NOT NULL
, CREATOR VARCHAR(255)BINARY
, CREATED TIMESTAMP NOT NULL
, DESCRIPTION VARCHAR(255)BINARY
, FOLDERTYPE INTEGER NOT NULL
, MODIFIED TIMESTAMP
, MODIFIER VARCHAR(255)BINARY
, FOLDERSIZE INTEGER NOT NULL
, PARENTID VARCHAR(32)BINARY
, REPID VARCHAR(32)BINARY
, ORIGINATOR INTEGER

, PRIMARY KEY ( FOLDERID )
) charset utf8mb4 ENGINE=InnoDB;

CREATE INDEX FFOLDERID_IDX ON t3 (FOLDERID);
CREATE INDEX CMFLDRPARNT_IDX ON t3 (PARENTID);

CREATE TABLE t4
(
DOCTYPEID VARCHAR(32)BINARY NOT NULL
, DOCTYPENAME VARCHAR(80)BINARY NOT NULL
, DESCRIPTION VARCHAR(255)BINARY
, EXTNDATA LONGBLOB
, MODIFIED TIMESTAMP
, MODIFIER VARCHAR(255)BINARY
, ORIGINATOR INTEGER

, PRIMARY KEY ( DOCTYPEID )
) charset utf8mb4 ENGINE=InnoDB;

INSERT INTO t2 VALUES("c373e9f59cf15a6c3e57444553544200", "c373e9f59cf15a6c3e57444553544200", "340d243d45f111d497b00010a4ef934d", "2f6161e879db43c1a5b82c21ddc49089", NULL, "2003-06-06 07:48:42", NULL, NULL, NULL, "2003-06-06 07:48:42", "2003-06-06 07:48:42", NULL, NULL, NULL, "03eea05112b845949f3fd03278b5fe43", "2003-06-06 07:48:42", "admin", "0", NULL);

INSERT INTO t2 VALUES("c373e9f5a472f43ba45e444553544200", "c373e9f5a472f43ba45e444553544200", "340d243d45f111d497b00010a4ef934d", "2f6161e879db43c1a5b82c21ddc49089", NULL, "2003-06-07 18:50:12", NULL, NULL, NULL, "2003-06-07 18:50:12", "2003-06-07 18:50:12", NULL, NULL, NULL, "03eea05112b845949f3fd03278b5fe43", "2003-06-07 18:50:12", "admin", "0", NULL);


INSERT INTO t2 VALUES("c373e9f5a4a0f56014eb444553544200", "c373e9f5a4a0f56014eb444553544200", "340d243d45f111d497b00010a4ef934d", "2f6161e879db43c1a5b82c21ddc49089", NULL, "2003-06-07 19:39:26", NULL, NULL, NULL, "2003-06-07 19:39:26", "2003-06-07 19:39:26", NULL, NULL, NULL, "03eea05112b845949f3fd03278b5fe43", "2003-06-07 19:39:26", "admin", "0", NULL);
INSERT INTO t2 VALUES("c373e9f5a4a0f8fa4a86444553544200", "c373e9f5a4a0f8fa4a86444553544200", "340d243d45f111d497b00010a4ef934d", "2f6161e879db43c1a5b82c21ddc49089", NULL, "2003-06-07 19:43:05", NULL, NULL, NULL, "2003-06-07 19:43:05", "2003-06-07 19:43:05", NULL, NULL, NULL, "03eea05112b845949f3fd03278b5fe43", "2003-06-07 19:43:05", "admin", "0", NULL);
INSERT INTO t2 VALUES("c373e9f5ac7b537205ce444553544200", "c373e9f5ac7b537205ce444553544200", "340d243d45f111d497b00010a4ef934d", "2f6161e879db43c1a5b82c21ddc49089", NULL, "2003-06-09 08:15:24", NULL, NULL, NULL, "2003-06-09 08:15:24", "2003-06-09 08:15:24", NULL, NULL, NULL, "03eea05112b845949f3fd03278b5fe43", "2003-06-09 08:15:24", "admin", "0", NULL);
INSERT INTO t2 VALUES("c373e9f5ad0792012454444553544200", "c373e9f5ad0792012454444553544200", "340d243d45f111d497b00010a4ef934d", "2f6161e879db43c1a5b82c21ddc49089", NULL, "2003-06-09 10:51:44", NULL, NULL, NULL, "2003-06-09 10:51:44", "2003-06-09 10:51:44", NULL, NULL, NULL, "03eea05112b845949f3fd03278b5fe43", "2003-06-09 10:51:44", "admin", "0", NULL);
INSERT INTO t2 VALUES("c373e9f5ad079821ef34444553544200", "First Discussion", "c373e9f5ad079174ff17444553544200", "c373e9f5ad0796c0eca4444553544200", "Goldilocks", "2003-06-09 11:16:50", "Title: First Discussion", NULL, NULL, "2003-06-09 10:51:26", "2003-06-09 10:51:26", NULL, NULL, NULL, "03eea05112b845949f3fd03278b5fe43", "2003-06-09 11:16:50", "admin", "0", NULL);
INSERT INTO t2 VALUES("c373e9f5ad07993f3859444553544200", "Last Discussion", "c373e9f5ad079174ff17444553544200", "c373e9f5ad0796c0eca4444553544200", "Goldilocks", "2003-06-09 11:21:06", "Title: Last Discussion", NULL, "Setting new abstract and keeping doc checked out", "2003-06-09 10:51:26", "2003-06-09 10:51:26", NULL, NULL, NULL, "03eea05112b845949f3fd03278b5fe43", "2003-06-09 11:21:06", "admin", "0", NULL);
INSERT INTO t2 VALUES("c373e9f5ad079a3219c4444553544200", "testdoclayout", "340d243c45f111d497b00010a4ef934d", "c373e9f5ad0796c0eca4444553544200", "Goldilocks", "2003-06-09 11:25:31", "Title: Test doc layout", "Subtitle: test doc layout", NULL, "2003-06-09 10:51:27", "2003-06-09 10:51:27", NULL, NULL, NULL, "03eea05112b845949f3fd03278b5fe43", "2003-06-09 11:25:31", "admin", "0", NULL);



INSERT INTO t3 VALUES("0c9aab05b15048c59bc35c8461507deb", "System", "System", "2003-06-05 16:30:00", "The system content repository folder.", "3", "2003-06-05 16:30:00", "System", "0", NULL, "9c9aab05b15048c59bc35c8461507deb", "1");
INSERT INTO t3 VALUES("2f6161e879db43c1a5b82c21ddc49089", "Default", "System", "2003-06-09 10:52:02", "The default content repository folder.", "3", "2003-06-05 16:30:00", "System", "0", NULL, "03eea05112b845949f3fd03278b5fe43", "1");
INSERT INTO t3 VALUES("c373e9f5ad0791724315444553544200", "AddDocumentTest", "admin", "2003-06-09 10:51:25", "Movie Reviews", "0", "2003-06-09 10:51:25", "admin", "0", "2f6161e879db43c1a5b82c21ddc49089", "03eea05112b845949f3fd03278b5fe43", NULL);
INSERT INTO t3 VALUES("c373e9f5ad07919e1963444553544200", "NewDestDirectory", "admin", "2003-06-09 10:51:28", "Adding new directory", "128", "2003-06-09 10:51:28", "admin", "0", "2f6161e879db43c1a5b82c21ddc49089", "03eea05112b845949f3fd03278b5fe43", NULL);
INSERT INTO t3 VALUES("c373e9f5ad07919fe525444553544200", "SubDestDirectory", "admin", "2003-06-09 10:51:28", "Adding new directory", "128", "2003-06-09 10:51:28", "admin", "0", "c373e9f5ad07919e1963444553544200", "03eea05112b845949f3fd03278b5fe43", NULL);
INSERT INTO t3 VALUES("c373e9f5ad0791a0dab5444553544200", "Level1", "admin", "2003-06-09 10:51:29", NULL, "0", "2003-06-09 10:51:29", "admin", "0", "2f6161e879db43c1a5b82c21ddc49089", "03eea05112b845949f3fd03278b5fe43", NULL);
INSERT INTO t3 VALUES("c373e9f5ad0791a14669444553544200", "Level2", "admin", "2003-06-09 10:51:29", NULL, "0", "2003-06-09 10:51:29", "admin", "0", "c373e9f5ad0791a0dab5444553544200", "03eea05112b845949f3fd03278b5fe43", NULL);
INSERT INTO t3 VALUES("c373e9f5ad0791a23c0e444553544200", "Level3", "admin", "2003-06-09 10:51:29", NULL, "0", "2003-06-09 10:51:29", "admin", "0", "c373e9f5ad0791a14669444553544200", "03eea05112b845949f3fd03278b5fe43", NULL);
INSERT INTO t3 VALUES("c373e9f5ad0791a6b11f444553544200", "Dir1", "admin", "2003-06-09 10:51:30", NULL, "0", "2003-06-09 10:51:30", "admin", "0", "2f6161e879db43c1a5b82c21ddc49089", "03eea05112b845949f3fd03278b5fe43", NULL);
INSERT INTO t3 VALUES("c373e9f5ad0791a897d6444553544200", "Dir2", "admin", "2003-06-09 10:51:30", NULL, "0", "2003-06-09 10:51:30", "admin", "0", "c373e9f5ad0791a6b11f444553544200", "03eea05112b845949f3fd03278b5fe43", NULL);
INSERT INTO t3 VALUES("c373e9f5ad0791a9a063444553544200", "NewDestDirectory", "admin", "2003-06-09 10:51:31", NULL, "0", "2003-06-09 10:51:31", "admin", "0", "c373e9f5ad0791a897d6444553544200", "03eea05112b845949f3fd03278b5fe43", NULL);
INSERT INTO t3 VALUES("c373e9f5ad0791aa73e3444553544200", "LevelA", "admin", "2003-06-09 10:51:31", NULL, "0", "2003-06-09 10:51:31", "admin", "0", "c373e9f5ad0791a0dab5444553544200", "03eea05112b845949f3fd03278b5fe43", NULL);
INSERT INTO t3 VALUES("c373e9f5ad0791ab034b444553544200", "LevelB", "admin", "2003-06-09 10:51:31", NULL, "0", "2003-06-09 10:51:31", "admin", "0", "c373e9f5ad0791aa73e3444553544200", "03eea05112b845949f3fd03278b5fe43", NULL);
INSERT INTO t3 VALUES("c373e9f5ad0791ac7311444553544200", "LevelC", "admin", "2003-06-09 10:51:32", NULL, "0", "2003-06-09 10:51:32", "admin", "0", "c373e9f5ad0791ab034b444553544200", "03eea05112b845949f3fd03278b5fe43", NULL);
INSERT INTO t3 VALUES("c373e9f5ad0791ad66cf444553544200", "test2", "admin", "2003-06-09 10:51:32", NULL, "0", "2003-06-09 10:51:32", "admin", "0", "c373e9f5ad0791724315444553544200", "03eea05112b845949f3fd03278b5fe43", NULL);
INSERT INTO t3 VALUES("c373e9f5ad0791aebd87444553544200", "test3", "admin", "2003-06-09 10:51:33", NULL, "0", "2003-06-09 10:51:33", "admin", "0", "c373e9f5ad0791ad66cf444553544200", "03eea05112b845949f3fd03278b5fe43", NULL);
INSERT INTO t3 VALUES("c373e9f5ad0791dbaac4444553544200", "Special Café Folder", "admin", "2003-06-09 10:51:43", "test folder names with special chars", "0", "2003-06-09 10:51:43", "admin", "0", "2f6161e879db43c1a5b82c21ddc49089", "03eea05112b845949f3fd03278b5fe43", NULL);
INSERT INTO t3 VALUES("c373e9f5ad0796bf913f444553544200", "CopiedFolder", "admin", "2003-06-09 11:09:05", "Movie Reviews", "0", "2003-06-09 11:09:05", "admin", "0", "c373e9f5ad0791a23c0e444553544200", "03eea05112b845949f3fd03278b5fe43", NULL);
INSERT INTO t3 VALUES("c373e9f5ad0796c0eca4444553544200", "Movie Reviews", "admin", "2003-06-09 11:09:13", "Movie Reviews", "0", "2003-06-09 11:09:13", "admin", "33", "c373e9f5ad0796bf913f444553544200", "03eea05112b845949f3fd03278b5fe43", NULL);
INSERT INTO t3 VALUES("c373e9f5ad0796d9b895444553544200", "NewBookFolder", "admin", "2003-06-09 11:12:41", "NewBooks - folder", "0", "2003-06-09 11:12:41", "admin", "0", "c373e9f5ad0796c0eca4444553544200", "03eea05112b845949f3fd03278b5fe43", NULL);
INSERT INTO t3 VALUES("c373e9f5ad079b4c9355444553544200", "CopiedFolder", "admin", "2003-06-09 11:26:34", "Movie Reviews", "0", "2003-06-09 11:26:34", "admin", "0", "2f6161e879db43c1a5b82c21ddc49089", "03eea05112b845949f3fd03278b5fe43", NULL);


INSERT INTO t4 VALUES("340d243c45f111d497b00010a4ef934d", "Document Layout", "The system Document Layouts Document Type", NULL, "2003-06-05 16:30:00", "System", "1");
INSERT INTO t4 VALUES("340d243d45f111d497b00010a4ef934d", "Default", "The default system Document Type", NULL, "2003-06-05 16:30:00", "System", "1");
INSERT INTO t4 VALUES("4d09dd60850711d4998a204c4f4f5020", "__SystemResourceType", "The type for all the uploaded resources", NULL, "2003-06-05 16:30:00", "System", "1");
INSERT INTO t4 VALUES("91d4d595478211d497b40010a4ef934d", "__PmcSystemDefaultType", "The type for all the default available fields", NULL, "2003-06-05 16:30:00", "System", "1");
INSERT INTO t4 VALUES("c373e9f59cf15a59b08a444553544200", "NoFieldDocType", "plain doc type", NULL, "2003-06-06 07:48:40", "admin", NULL);
INSERT INTO t4 VALUES("c373e9f59cf15a5c6a99444553544200", "Movie Review", "This doc type is for movie reviews", "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<props autocheckin=\"false\" autopublish=\"false\" binary=\"choice\" categories=\"none\" cleanup=\"false\" folder=\"none\"><![CDATA[Doc type for cm tests]]></props>\r\n", "2003-06-06 07:48:40", "admin", NULL);
INSERT INTO t4 VALUES("c373e9f59cf15a6116a5444553544200", "Special DocÃu20A4u20A4u0113ééøÉu016BType", "test special chars xxxé in doc type", NULL, "2003-06-06 07:48:41", "admin", NULL);
INSERT INTO t4 VALUES("c373e9f59cf15a695d47444553544200", "Movie", NULL, NULL, "2003-06-06 07:48:41", "admin", NULL);
INSERT INTO t4 VALUES("c373e9f5ad079174ff17444553544200", "Discussion", NULL, NULL, "2003-06-09 10:51:25", "admin", NULL);
INSERT INTO t4 VALUES("c373e9f5ad0791da7e2b444553544200", "Books", "list of recommended books", "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<props autocheckin=\"false\" autopublish=\"false\" binary=\"choice\" categories=\"none\" cleanup=\"false\" folder=\"none\"><![CDATA[Doc type for cm tests]]><![CDATA[Doc type for book tests]]></props>\r\n", "2003-06-09 10:51:40", "admin", NULL);

ALTER TABLE t2 ADD  FOREIGN KEY FK_DCMNTS_DCTYPES ( DOCTYPEID)
    REFERENCES t4 (DOCTYPEID );
ALTER TABLE t2 ADD  FOREIGN KEY FK_DCMNTS_FLDRS ( FOLDERID)
    REFERENCES t3 (FOLDERID );
ALTER TABLE t3 ADD  FOREIGN KEY FK_FLDRS_PRNTID ( PARENTID)
    REFERENCES t3 (FOLDERID );

SELECT t2.*, t4.DOCTYPENAME, t1.CONTENTSIZE,t1.MIMETYPE FROM t2 INNER JOIN t4 ON t2.DOCTYPEID = t4.DOCTYPEID LEFT OUTER JOIN t1 ON t2.DOCID = t1.DOCID WHERE t2.FOLDERID IN(SELECT t3.FOLDERID FROM t3 WHERE t3.PARENTID IN(SELECT t3.FOLDERID FROM t3 WHERE t3.PARENTID IN(SELECT t3.FOLDERID FROM t3 WHERE t3.PARENTID IN(SELECT t3.FOLDERID FROM t3 WHERE t3.PARENTID IN(SELECT t3.FOLDERID FROM t3 WHERE t3.PARENTID='2f6161e879db43c1a5b82c21ddc49089' AND t3.FOLDERNAME = 'Level1') AND t3.FOLDERNAME = 'Level2') AND t3.FOLDERNAME = 'Level3') AND t3.FOLDERNAME = 'CopiedFolder') AND t3.FOLDERNAME = 'Movie Reviews') AND t2.DOCNAME = 'Last Discussion';

drop table t1, t2, t3, t4;

CREATE TABLE t1 (
  school_name varchar(45) NOT NULL,
  country varchar(45) NOT NULL,    
  funds_requested float NOT NULL,
  schooltype varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

insert into t1 values ("the school", "USA", 1200, "Human");

select count(country) as countrycount, sum(funds_requested) as smcnt,
       country, (select sum(funds_requested) from t1) as total_funds
from t1
group by country;

select count(country) as countrycount, sum(funds_requested) as smcnt,
       country, (select sum(funds_requested) from t1) as total_funds
from t1
group by country;

drop table t1;

--
-- BUG#14342: wrong placement of subquery internals in complex queries
--
CREATE TABLE `t1` (
  `t3_id` int NOT NULL,
  `t1_id` int NOT NULL,
  PRIMARY KEY  (`t1_id`)
);
CREATE TABLE `t2` (
  `t2_id` int NOT NULL,
  `t1_id` int NOT NULL,
  `b` int NOT NULL,
  PRIMARY KEY  (`t2_id`),
  UNIQUE KEY `idx_t2_t1_b` (`t1_id`,`b`)
) ENGINE=InnoDB;
CREATE TABLE `t3` (
  `t3_id` int NOT NULL
);
INSERT INTO `t3` VALUES (3);
select
  (SELECT rs.t2_id
   FROM t2 rs
   WHERE rs.t1_id=
     (SELECT lt.t1_id
      FROM t1 lt
      WHERE lt.t3_id=a.t3_id)
   ORDER BY b DESC LIMIT 1)
from t3 AS a;
DROP PROCEDURE IF EXISTS p1;
create procedure p1()
begin
  declare done int default 3;
    select
      (SELECT rs.t2_id
       FROM t2 rs
       WHERE rs.t1_id=
         (SELECT lt.t1_id
          FROM t1 lt
          WHERE lt.t3_id=a.t3_id)
       ORDER BY b DESC LIMIT 1) as x
    from t3 AS a;
    set done= done-1;
drop procedure p1;
drop tables t1,t2,t3;


--
-- Bug #20792: Incorrect results from aggregate subquery
--
CREATE TABLE t1 (a int(10) , PRIMARY KEY (a)) Engine=InnoDB;
INSERT INTO t1 VALUES (1),(2);

CREATE TABLE t2 (a int(10), PRIMARY KEY (a)) Engine=InnoDB;
INSERT INTO t2 VALUES (1);

CREATE TABLE t3 (a int(10), b int(10), c int(10),
                PRIMARY KEY (a)) Engine=InnoDB;
INSERT INTO t3 VALUES (1,2,1);

SELECT t1.* FROM t1 WHERE (SELECT COUNT(*) FROM t3,t2 WHERE t3.c=t2.a 
                           and t2.a='1' AND t1.a=t3.b) > 0;

DROP TABLE t1,t2,t3;

CREATE TABLE t1 (
  col_time_key time DEFAULT NULL,
  col_datetime_key datetime DEFAULT NULL,
  col_varchar_nokey varchar(1) DEFAULT NULL,
  KEY col_time_key (col_time_key),
  KEY col_datetime_key (col_datetime_key)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO t1 VALUES ('17:53:30','2005-11-10 12:40:29','h');
INSERT INTO t1 VALUES ('11:35:49','2009-04-25 00:00:00','b');
INSERT INTO t1 VALUES (NULL,'2002-11-27 00:00:00','s');
INSERT INTO t1 VALUES ('06:01:40','2004-01-26 20:32:32','e');
INSERT INTO t1 VALUES ('05:45:11','2007-10-26 11:41:40','j');
INSERT INTO t1 VALUES ('00:00:00','2005-10-07 00:00:00','e');
INSERT INTO t1 VALUES ('00:00:00','2000-07-15 05:00:34','f');
INSERT INTO t1 VALUES ('06:11:01','2000-04-03 16:33:32','v');
INSERT INTO t1 VALUES ('13:02:46',NULL,'x');
INSERT INTO t1 VALUES ('21:44:25','2001-04-25 01:26:12','m');
INSERT INTO t1 VALUES ('22:43:58','2000-12-27 00:00:00','c');

CREATE TABLE t2 (
  col_time_key time DEFAULT NULL,
  col_datetime_key datetime DEFAULT NULL,
  col_varchar_nokey varchar(1) DEFAULT NULL,
  KEY col_time_key (col_time_key),
  KEY col_datetime_key (col_datetime_key)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO t2 VALUES ('11:28:45','2004-10-11 18:13:16','w');

SELECT col_time_key, col_datetime_key
FROM 
( SELECT * FROM t1 ) AS table1 
HAVING ( 'r' , 'e' ) IN 
  ( SELECT col_varchar_nokey , col_varchar_nokey FROM t2 )
ORDER BY col_datetime_key 
LIMIT 10;

DROP TABLE t1;
DROP TABLE t2;

CREATE TABLE t1(a date, b int, unique(b), unique(a), key(b)) engine=innodb;
INSERT INTO t1 VALUES ('2011-05-13', 0);
SELECT * FROM t1 WHERE b < (SELECT CAST(a as date) FROM t1 GROUP BY a);
DROP TABLE t1;

CREATE TABLE t1 (a INT) ENGINE=INNODB;
INSERT INTO t1 VALUES (0);
CREATE TABLE t2 (d BINARY(2), PRIMARY KEY (d(1)), UNIQUE KEY (d)) ENGINE=INNODB;

SELECT 1 FROM t1 WHERE NOT EXISTS
(SELECT 1 FROM t2 WHERE d = (SELECT d FROM t2 WHERE a >= 1) ORDER BY d);

DROP TABLE t2;

CREATE TABLE t2 (b INT, c INT, UNIQUE KEY (b), UNIQUE KEY (b, c )) ENGINE=INNODB;
INSERT INTO t2 VALUES (1, 1);

SELECT 1 FROM t1
WHERE a != (SELECT 1 FROM t2 WHERE a <=> b OR a > '' AND 6 = 7 ORDER BY b, c);

DROP TABLE t1, t2;
SET sql_mode = default;
