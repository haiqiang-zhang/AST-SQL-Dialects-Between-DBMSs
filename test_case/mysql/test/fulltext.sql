
--
-- Test of fulltext index
--

--disable_warnings
drop table if exists t1,t2,t3;

CREATE TABLE t1 (a VARCHAR(200), b TEXT, FULLTEXT (a,b)) charset utf8mb4;
INSERT INTO t1 VALUES('MySQL has now support', 'for full-text search'),
                       ('Full-text indexes', 'are called collections'),
                          ('Only MyISAM tables','support collections'),
             ('Function MATCH ... AGAINST()','is used to do a search'),
        ('Full-text search in MySQL', 'implements vector space model');

-- nl search
-- Also tests FORMAT=tree printing of full-text search iterators.

--skip_if_hypergraph  -- Does not add a redundant filter on top.
EXPLAIN FORMAT=tree select * from t1 where MATCH(a,b) AGAINST ("collections");
select * from t1 where MATCH(a,b) AGAINST ("collections");
select * from t1 where MATCH(a,b) AGAINST ("indexes");
select * from t1 where MATCH(a,b) AGAINST ("indexes collections");
select * from t1 where MATCH(a,b) AGAINST ("only");

-- query expansion

--sorted_result
select * from t1 where MATCH(a,b) AGAINST ("collections" WITH QUERY EXPANSION);
select * from t1 where MATCH(a,b) AGAINST ("indexes" WITH QUERY EXPANSION);
select * from t1 where MATCH(a,b) AGAINST ("indexes collections" WITH QUERY EXPANSION);

-- IN NATURAL LANGUAGE MODE
select * from t1 where MATCH(a,b) AGAINST ("indexes" IN NATURAL LANGUAGE MODE);
select * from t1 where MATCH(a,b) AGAINST ("indexes" IN NATURAL LANGUAGE MODE WITH QUERY EXPANSION);
select * from t1 where MATCH(a,b) AGAINST ("indexes" IN BOOLEAN MODE WITH QUERY EXPANSION);

-- add_ft_keys() tests

explain select * from t1 where MATCH(a,b) AGAINST ("collections");

-- boolean search

select * from t1 where MATCH(a,b) AGAINST("support -collections" IN BOOLEAN MODE);
select * from t1 where MATCH(a,b) AGAINST("support  collections" IN BOOLEAN MODE);
select * from t1 where MATCH(a,b) AGAINST("support +collections" IN BOOLEAN MODE);
select * from t1 where MATCH(a,b) AGAINST("sear*" IN BOOLEAN MODE);
select * from t1 where MATCH(a,b) AGAINST("+support +collections" IN BOOLEAN MODE);
select * from t1 where MATCH(a,b) AGAINST("+search" IN BOOLEAN MODE);
select * from t1 where MATCH(a,b) AGAINST("+search +(support vector)" IN BOOLEAN MODE);
select * from t1 where MATCH(a,b) AGAINST("+search -(support vector)" IN BOOLEAN MODE);
select *, MATCH(a,b) AGAINST("support collections" IN BOOLEAN MODE) as x from t1;
select *, MATCH(a,b) AGAINST("collections support" IN BOOLEAN MODE) as x from t1;

select * from t1 where MATCH a,b AGAINST ("+call* +coll*" IN BOOLEAN MODE);

select * from t1 where MATCH a,b AGAINST ('"support now"' IN BOOLEAN MODE);
select * from t1 where MATCH a,b AGAINST ('"Now sUPPort"' IN BOOLEAN MODE);
select * from t1 where MATCH a,b AGAINST ('"now   support"' IN BOOLEAN MODE);
select * from t1 where MATCH a,b AGAINST ('"text search"  "now support"' IN BOOLEAN MODE);
select * from t1 where MATCH a,b AGAINST ('"text search" -"now support"' IN BOOLEAN MODE);
select * from t1 where MATCH a,b AGAINST ('"text search" +"now support"' IN BOOLEAN MODE);
select * from t1 where MATCH a,b AGAINST ('"text i"' IN BOOLEAN MODE);
select * from t1 where MATCH a,b AGAINST ('"xt indexes"' IN BOOLEAN MODE);

select * from t1 where MATCH a,b AGAINST ('+(support collections) +foobar*' IN BOOLEAN MODE);
select * from t1 where MATCH a,b AGAINST ('+(+(support collections)) +foobar*' IN BOOLEAN MODE);
select * from t1 where MATCH a,b AGAINST ('+collections -supp* -foobar*' IN BOOLEAN MODE);

-- bug#2708, bug#3870 crash

select * from t1 where MATCH a,b AGAINST('"space model' IN BOOLEAN MODE);
 
-- boolean w/o index:

select * from t1 where MATCH a AGAINST ("search" IN BOOLEAN MODE);
select * from t1 where MATCH b AGAINST ("sear*" IN BOOLEAN MODE);

-- UNION of fulltext's
--sorted_result
select * from t1 where MATCH(a,b) AGAINST ("collections") UNION ALL select * from t1 where MATCH(a,b) AGAINST ("indexes");

delete from t1 where a like "MySQL%";
update t1 set a='some test foobar' where MATCH a,b AGAINST ('model');
delete from t1 where MATCH(a,b) AGAINST ("indexes");
select * from t1;
drop table t1;

--
-- why to scan strings for trunc*
--
create table t1 (a varchar(200) not null, fulltext (a));
insert t1 values ("aaa10 bbb20"), ("aaa20 bbb15"), ("aaa30 bbb10");
select * from t1 where match a against ("+aaa* +bbb*" in boolean mode);
select * from t1 where match a against ("+aaa* +bbb1*" in boolean mode);
select * from t1 where match a against ("+aaa* +ccc*" in boolean mode);
select * from t1 where match a against ("+aaa10 +(bbb*)" in boolean mode);
select * from t1 where match a against ("+(+aaa* +bbb1*)" in boolean mode);
select * from t1 where match a against ("(+aaa* +bbb1*)" in boolean mode);
drop table t1;

--
-- Check bug reported by Matthias Urlichs
--

CREATE TABLE t1 (
  id int(11),
  ticket int(11),
  KEY ti (id),
  KEY tit (ticket)
) charset utf8mb4;
INSERT INTO t1 VALUES (2,3),(1,2);

CREATE TABLE t2 (
  ticket int(11),
  inhalt text,
  KEY tig (ticket),
  fulltext index tix (inhalt)
) charset utf8mb4;
INSERT INTO t2 VALUES (1,'foo'),(2,'bar'),(3,'foobar');

select t1.id FROM t2 as ttxt,t1,t1 as ticket2
WHERE ticket2.id = ttxt.ticket AND t1.id = ticket2.ticket and
match(ttxt.inhalt) against ('foobar');

-- In the following query MySQL didn't use the fulltext index
select ticket2.id FROM t2 as ttxt,t2 INNER JOIN t1 as ticket2 ON
ticket2.id = t2.ticket
WHERE ticket2.id = ticket2.ticket and match(ttxt.inhalt) against ('foobar');

INSERT INTO t1 VALUES (3,3);
select ticket2.id FROM t2 as ttxt,t2
INNER JOIN t1 as ticket2 ON ticket2.id = t2.ticket
WHERE ticket2.id = ticket2.ticket and
      match(ttxt.inhalt) against ('foobar');

-- Check that we get 'fulltext' index in SHOW CREATE

show keys from t2;

-- check for bug reported by Stephan Skusa

select * from t2 where MATCH inhalt AGAINST (NULL);

-- MATCH in HAVING (pretty useless, but still it should work)

select * from t2 where  MATCH inhalt AGAINST ('foobar');
select * from t2 having MATCH inhalt AGAINST ('foobar');

--
-- check of fulltext errors
--

--error 1283
CREATE TABLE t3 (t int(11),i text,fulltext tix (t,i));
CREATE TABLE t3 (t int(11),i text,
                 j varchar(200) CHARACTER SET latin2,
                 fulltext tix (i,j));

CREATE TABLE t3 (
  ticket int(11),
  inhalt text,
  KEY tig (ticket),
  fulltext index tix (inhalt)
);
select * from t2 where MATCH inhalt AGAINST (t2.inhalt);
select * from t2 where MATCH ticket AGAINST ('foobar');
select * from t2,t3 where MATCH (t2.inhalt,t3.inhalt) AGAINST ('foobar');

drop table t1,t2,t3;

--
-- three more bugtests
--

CREATE TABLE t1 (
  id int(11)  auto_increment,
  title varchar(100)  default '',
  PRIMARY KEY  (id),
  KEY ind5 (title)
) ENGINE=MyISAM;

CREATE FULLTEXT INDEX ft1 ON t1(title);
insert into t1 (title) values ('this is a test');
select * from t1 where match title against ('test' in boolean mode);
update t1 set title='this is A test' where id=1;
update t1 set title='this test once revealed a bug' where id=1;
select * from t1;
update t1 set title=NULL where id=1;

drop table t1;

-- one more bug - const_table related

CREATE TABLE t1 (a int(11), b text, FULLTEXT KEY (b)) ENGINE=MyISAM;
insert into t1 values (1,"I wonder why the fulltext index doesnt work?");
SELECT * from t1 where MATCH (b) AGAINST ('apples');

insert into t1 values (2,"fullaaa fullzzz");
select * from t1 where match b against ('full*' in boolean mode);

drop table t1;
CREATE TABLE t1 ( id int(11) NOT NULL auto_increment primary key, mytext text NOT NULL, FULLTEXT KEY mytext (mytext)) ENGINE=MyISAM;
INSERT INTO t1 VALUES (1,'my small mouse'),(2,'la-la-la'),(3,'It is so funny'),(4,'MySQL Tutorial');
select 8 from t1;
drop table t1;

--
-- Check bug reported by Julian Ladisch
-- ERROR 1030: Got error 127 from table handler
--

create table t1 (a text, fulltext key (a));
insert into t1 values ('aaaa');
select * from t1 where match (a) against ('aaaa');
drop table t1;

--
-- bug #283 by jocelyn fournier <joc@presence-pc.com>
-- FULLTEXT index on a TEXT filed converted to a CHAR field doesn't work anymore
-- 

create table t1 ( ref_mag text not null, fulltext (ref_mag));
insert into t1 values ('test');
select ref_mag from t1 where match ref_mag against ('+test' in boolean mode);
alter table t1 change ref_mag ref_mag char (255) not null;
select ref_mag from t1 where match ref_mag against ('+test' in boolean mode);
drop table t1;

--
-- bug #942: JOIN
--

create table t1 (t1_id int(11) primary key, name varchar(32));
insert into t1 values (1, 'data1');
insert into t1 values (2, 'data2');
create table t2 (t2_id int(11) primary key, t1_id int(11), name varchar(32));
insert into t2 values (1, 1, 'xxfoo');
insert into t2 values (2, 1, 'xxbar');
insert into t2 values (3, 1, 'xxbuz');
select * from t1 join t2 using(`t1_id`) where match (t1.name, t2.name) against('xxfoo' in boolean mode);

--
-- Bug #7858: bug with many short (< ft_min_word_len) words in boolean search
--
select * from t2 where match name against ('*a*b*c*d*e*f*' in boolean mode);
drop table t1,t2;

--
-- bug with repair-by-sort and incorrect records estimation
--

create table t1 (a text, fulltext key (a));
insert into t1 select "xxxx yyyy zzzz";
drop table t1;

--
-- utf8mb3
--
SET NAMES latin1;
CREATE TABLE t1 (t text character set utf8mb3 not null, fulltext(t));
INSERT t1 VALUES ('Mit freundlichem Gr��'), ('aus Osnabr�ck');
SET NAMES koi8r;
INSERT t1 VALUES ("��� �� - ������"),("������, �����!"),
                ("�� ������, �����!"),("� ����� ����!");
SELECT t, collation(t) FROM t1 WHERE MATCH t AGAINST ('������');
SELECT t, collation(t) FROM t1 WHERE MATCH t AGAINST ('���*' IN BOOLEAN MODE);
SELECT * FROM t1 WHERE MATCH t AGAINST ('���' IN BOOLEAN MODE);
SELECT t, collation(t) FROM t1 WHERE MATCH t AGAINST ('Osnabr�ck');
SET NAMES latin1;
SELECT t, collation(t) FROM t1 WHERE MATCH t AGAINST ('Osnabr�ck');
SELECT t, collation(t) FROM t1 WHERE MATCH t AGAINST ('Osnabrueck');
SELECT t, collation(t),FORMAT(MATCH t AGAINST ('Osnabruck'),6) FROM t1 WHERE MATCH t AGAINST ('Osnabruck');
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
alter table t1 modify t varchar(200) collate latin1_german2_ci not null;
SET sql_mode = default;
SELECT t, collation(t) FROM t1 WHERE MATCH t AGAINST ('Osnabr�ck');
SELECT t, collation(t) FROM t1 WHERE MATCH t AGAINST ('Osnabrueck');
DROP TABLE t1;

--
-- bug#3964
--

CREATE TABLE t1 (s varchar(255), FULLTEXT (s)) DEFAULT CHARSET=utf8mb3;
insert into t1 (s) values ('p�ra para para'),('para para para');
select * from t1 where match(s) against('para' in boolean mode);
select * from t1 where match(s) against('par*' in boolean mode);
DROP TABLE t1;

--
-- icc -ip bug (ip = interprocedural optimization)
-- bug#5528
--
CREATE TABLE t1 (h text, FULLTEXT (h));
INSERT INTO t1 VALUES ('Jesses Hasse Ling and his syncopators of Swing');
select count(*) from t1;
drop table t1;

--
-- testing out of bounds memory access in ft_nlq_find_relevance()
-- (bug#8522);
CREATE TABLE t1 ( a TEXT, FULLTEXT (a) );
INSERT INTO t1 VALUES ('testing ft_nlq_find_relevance');
SELECT MATCH(a) AGAINST ('nosuchword') FROM t1;
DROP TABLE t1;
--

create table t1 (a int primary key, b text, fulltext(b));
create table t2 (a int, b text);
insert t1 values (1, "aaaa"), (2, "bbbb");
insert t2 values (10, "aaaa"), (2, "cccc");
drop table t1, t2;

--
-- bug#8351
--
CREATE TABLE t1 (t VARCHAR(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci, FULLTEXT (t));
SET NAMES latin1;
INSERT INTO t1 VALUES('Mit freundlichem Gr�� aus Osnabr�ck');
SELECT COUNT(*) FROM t1 WHERE MATCH(t) AGAINST ('"osnabr�ck"' IN BOOLEAN MODE);
DROP TABLE t1;

--
-- BUG#11684 - repair crashes mysql when table has fulltext index
--

CREATE TABLE t1 (a VARCHAR(30), FULLTEXT(a));
INSERT INTO t1 VALUES('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb');

--
-- BUG#5686 - #1034 - Incorrect key file for table - only utf8mb3
--
INSERT INTO t1 VALUES('testword\'\'');
SELECT a FROM t1 WHERE MATCH a AGAINST('testword' IN BOOLEAN MODE);
SELECT a FROM t1 WHERE MATCH a AGAINST('testword\'\'' IN BOOLEAN MODE);

--
-- BUG#14194: Problem with fulltext boolean search and apostrophe
--
INSERT INTO t1 VALUES('test\'s');
SELECT a FROM t1 WHERE MATCH a AGAINST('test' IN BOOLEAN MODE);
DROP TABLE t1;

--
-- BUG#13835: max key length is 1000 bytes when trying to create
--            a fulltext index
--
CREATE TABLE t1 (a VARCHAR(10000), FULLTEXT(a)) charset utf8mb4;
DROP TABLE t1;

--
-- BUG#14496: Crash or strange results with prepared statement,
--            MATCH and FULLTEXT
--
CREATE TABLE t1 (a TEXT, FULLTEXT KEY(a));
INSERT INTO t1 VALUES('test'),('test1'),('test');
DROP TABLE t1;

--
-- BUG#25951 - ignore/use index does not work with fulltext
--
CREATE TABLE t1 (a VARCHAR(255), FULLTEXT(a));
SELECT * FROM t1 IGNORE INDEX(a) WHERE MATCH(a) AGAINST('test');
ALTER TABLE t1 DISABLE KEYS;
SELECT * FROM t1 WHERE MATCH(a) AGAINST('test');
DROP TABLE t1;

--
-- BUG#11392 - fulltext search bug
--
CREATE TABLE t1(a TEXT);
INSERT INTO t1 VALUES(' aaaaa aaaa');
SELECT * FROM t1 WHERE MATCH(a) AGAINST ('"aaaa"' IN BOOLEAN MODE);
DROP TABLE t1;

--
-- BUG#29445 - match ... against () never returns
--
CREATE TABLE t1(a VARCHAR(20), FULLTEXT(a));
INSERT INTO t1 VALUES('Offside'),('City Of God');
SELECT a FROM t1 WHERE MATCH a AGAINST ('+city of*' IN BOOLEAN MODE);
SELECT a FROM t1 WHERE MATCH a AGAINST ('+city (of*)' IN BOOLEAN MODE);
SELECT a FROM t1 WHERE MATCH a AGAINST ('+city* of*' IN BOOLEAN MODE);
DROP TABLE t1;

-- End of 4.1 tests

--
-- bug#34374 - mysql generates incorrect warning
--
create table t1(a text,b date,fulltext index(a))engine=myisam;
insert into t1 set a='water',b='2008-08-04';
select 1 from t1 where match(a) against ('water' in boolean mode) and b>='2008-08-01';
drop table t1;

--
-- BUG#38842 - Fix for 25951 seems incorrect
--
CREATE TABLE t1 (a VARCHAR(255), b INT, FULLTEXT(a), KEY(b));
INSERT INTO t1 VALUES('test', 1),('test', 1),('test', 1),('test', 1),
                     ('test', 1),('test', 2),('test', 3),('test', 4);

DROP TABLE t1;

--
-- BUG#37245 - Full text search problem
--
CREATE TABLE t1(a CHAR(10));
INSERT INTO t1 VALUES('aaa15');
SELECT MATCH(a) AGAINST('aaa1* aaa14 aaa16' IN BOOLEAN MODE) FROM t1;
SELECT MATCH(a) AGAINST('aaa1* aaa14 aaa15 aaa16' IN BOOLEAN MODE) FROM t1;
DROP TABLE t1;

--
-- BUG#36737 - having + full text operator crashes mysql
--
CREATE TABLE t1(a TEXT);
SELECT GROUP_CONCAT(a) AS st FROM t1 HAVING MATCH(st) AGAINST('test' IN BOOLEAN MODE);
DROP TABLE t1;

--
-- BUG#42907 - Multi-term boolean fulltext query containing a single
--             quote fails in 5.1.x
--
CREATE TABLE t1(a VARCHAR(64), FULLTEXT(a));
INSERT INTO t1 VALUES('awrd bwrd cwrd'),('awrd bwrd cwrd'),('awrd bwrd cwrd');
SELECT * FROM t1 WHERE MATCH(a) AGAINST('+awrd bwrd* +cwrd*' IN BOOLEAN MODE);
DROP TABLE t1;

--
-- BUG#37740 Server crashes on execute statement with full text search and match against
--
CREATE TABLE t1 (col text, FULLTEXT KEY full_text (col));
  ;

EXECUTE s;
DROP TABLE t1;
CREATE TABLE t1(col1 TEXT,
  FULLTEXT INDEX USING BTREE (col1));
CREATE TABLE t2(col1 TEXT);
CREATE FULLTEXT INDEX USING BTREE ON t2(col);
ALTER TABLE t2 ADD FULLTEXT INDEX USING BTREE (col1);

DROP TABLE t2;

CREATE TABLE t1 (a int);
INSERT INTO t1 VALUES (1), (2);

CREATE TABLE t2 (a int, b2 char(10), FULLTEXT KEY b2 (b2));
INSERT INTO t2 VALUES (1,'Scargill');

CREATE TABLE t3 (a int, b int);
INSERT INTO t3 VALUES (1,1), (2,1);
SELECT count(*) FROM t1 WHERE 
  not exists(
   SELECT 1 FROM t2, t3
   WHERE t3.a=t1.a AND MATCH(b2) AGAINST('scargill' IN BOOLEAN MODE)
  );
SELECT count(*) FROM t1 WHERE 
  not exists(
   SELECT 1 FROM t2, t3
   WHERE t3.a=t1.a AND MATCH(b2) AGAINST('scargill' IN BOOLEAN MODE)
  );
SELECT count(*) FROM t1 WHERE 
  not exists(
   SELECT 1 FROM t2 IGNORE INDEX (b2), t3
   WHERE t3.a=t1.a AND MATCH(b2) AGAINST('scargill' IN BOOLEAN MODE)
  );

DROP TABLE t1,t2,t3;

--
-- BUG#50351 - ft_min_word_len=2 Causes query to hang
--
CREATE TABLE t1 (a VARCHAR(4), FULLTEXT(a));
INSERT INTO t1 VALUES
('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),
('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),
('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),
('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),
('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),
('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),
('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),
('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),
('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),
('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),
('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),
('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),
('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('cwrd'),('awrd'),('cwrd'),
('awrd');
SELECT COUNT(*) FROM t1 WHERE MATCH(a) AGAINST("+awrd bwrd* +cwrd*" IN BOOLEAN MODE);
DROP TABLE t1;

CREATE TABLE t1(a CHAR(1),FULLTEXT(a));
SELECT 1 FROM t1 WHERE MATCH(a) AGAINST ('') AND ROW(a,a) > ROW(1,1);
DROP TABLE t1;
CREATE TABLE t1(a CHAR(4), FULLTEXT(a));
INSERT INTO t1 VALUES('aaaa');
SET myisam_sort_buffer_size=4;
SET myisam_sort_buffer_size=@@global.myisam_sort_buffer_size;
DROP TABLE t1;

CREATE TABLE t1(f1 VARCHAR(6) NOT NULL, FULLTEXT KEY(f1), UNIQUE(f1));
INSERT INTO t1 VALUES ('test');
SELECT 1 FROM t1 WHERE 1 >
 ALL((SELECT 1 FROM t1 JOIN t1 a
 ON (MATCH(t1.f1) against (""))
 WHERE t1.f1 GROUP BY t1.f1)) xor f1;
 ON (MATCH(t1.f1) against (""))
 WHERE t1.f1 GROUP BY t1.f1)) xor f1';
 ON (MATCH(t1.f1) against (""))
 WHERE t1.f1 GROUP BY t1.f1))';

DROP TABLE t1;

CREATE TABLE z(a INTEGER) engine=innodb;
CREATE TABLE q(b TEXT CHARSET latin1, fulltext(b)) engine=innodb;

let $query=
SELECT 1 FROM q
WHERE (SELECT MATCH(b) AGAINST ('*') FROM z);

DROP TABLE z, q;

let DATADIR= `SELECT @@datadir`;
CREATE TABLE t1(id INT, c CHAR(100) , FULLTEXT KEY `msg_idx` (`c`))
ENGINE INNODB;
CREATE TABLE t2 (a int, b2 char(10), FULLTEXT KEY b2 (b2));
let INCFILE= $MYSQL_TMP_DIR/tmp.inc;
  my $FTS_FILE= "";
    if (/(fts_\S+_index_1)\.ibd/) {
      $FTS_FILE= $1;
      last;
    }
  }
  close(DD);
EOF
--source $INCFILE

--echo -- SHOW CREATE TABLE on an FTS index table should give error
--echo -- (not crash). Query log and error message suppressed as the name of
--echo -- FTS index table is not stable.
--disable_query_log

--error ER_NO_SUCH_TABLE,ER_NO_SUCH_TABLE
--eval SHOW CREATE TABLE $FTS_FILE

--disable_result_log
--echo -- Msg_type Error ER_NO_SUCH_TABLE,ER_NO_SUCH_TABLE
--eval OPTIMIZE TABLE $FTS_FILE

--echo -- Msg_type Error ER_NO_SUCH_TABLE,ER_NO_SUCH_TABLE
--eval REPAIR TABLE $FTS_FILE

--error ER_NO_SUCH_TABLE,ER_NO_SUCH_TABLE
--eval ALTER TABLE $FTS_FILE DROP id

--enable_result_log

--error ER_NO_SUCH_TABLE,ER_NO_SUCH_TABLE
--eval LOCK TABLE $FTS_FILE AS mytable WRITE
--eval UNLOCK TABLES

--error ER_NO_SUCH_TABLE,ER_NO_SUCH_TABLE
--eval RENAME TABLE $FTS_FILE TO SOMETHING_ELSE

--error ER_NO_SUCH_TABLE,ER_NO_SUCH_TABLE
--eval RENAME TABLE t2 TO t3, $FTS_FILE TO SOMETHING_ELSE2

--error ER_NO_SUCH_TABLE,ER_NO_SUCH_TABLE
--eval TRUNCATE TABLE $FTS_FILE

--error ER_NO_SUCH_TABLE,ER_NO_SUCH_TABLE
--eval DROP TABLE $FTS_FILE

--enable_query_log

DROP TABLE t1, t2;

CREATE TABLE t1(fld1 VARCHAR(10) COLLATE 'latin1_bin', FULLTEXT INDEX (fld1))
ENGINE=InnoDB;

INSERT INTO t1 VALUES ('abCD'),('ABCD');
SELECT * FROM t1 WHERE MATCH(fld1) AGAINST ('abCD' IN BOOLEAN MODE);
SELECT * FROM t1 WHERE MATCH(fld1) AGAINST ('ABCD' IN BOOLEAN MODE);
SELECT * FROM t1 WHERE MATCH(fld1) AGAINST ('abCD' IN NATURAL LANGUAGE MODE);
SELECT * FROM t1 WHERE MATCH(fld1) AGAINST ('ABCD' IN NATURAL LANGUAGE MODE);
ALTER TABLE t1 MODIFY fld1 VARCHAR(10) COLLATE 'latin1_general_cs';
SELECT * FROM t1 WHERE MATCH(fld1) AGAINST ('abCD' IN BOOLEAN MODE);
SELECT * FROM t1 WHERE MATCH(fld1) AGAINST ('ABCD' IN BOOLEAN MODE);
SELECT * FROM t1 WHERE MATCH(fld1) AGAINST ('abCD' IN NATURAL LANGUAGE MODE);
SELECT * FROM t1 WHERE MATCH(fld1) AGAINST ('ABCD' IN NATURAL LANGUAGE MODE);
ALTER TABLE t1 MODIFY fld1 VARCHAR(10) COLLATE 'utf8mb4_bin';
SELECT * FROM t1 WHERE MATCH(fld1) AGAINST ('abCD' IN BOOLEAN MODE);
SELECT * FROM t1 WHERE MATCH(fld1) AGAINST ('ABCD' IN BOOLEAN MODE);
SELECT * FROM t1 WHERE MATCH(fld1) AGAINST ('abCD' IN NATURAL LANGUAGE MODE);
SELECT * FROM t1 WHERE MATCH(fld1) AGAINST ('ABCD' IN NATURAL LANGUAGE MODE);
ALTER TABLE t1 MODIFY fld1 VARCHAR(10) COLLATE 'utf8mb4_general_ci';
SELECT * FROM t1 WHERE MATCH(fld1) AGAINST ('abCD' IN BOOLEAN MODE);
SELECT * FROM t1 WHERE MATCH(fld1) AGAINST ('ABCD' IN BOOLEAN MODE);
SELECT * FROM t1 WHERE MATCH(fld1) AGAINST ('abCD' IN NATURAL LANGUAGE MODE);
SELECT * FROM t1 WHERE MATCH(fld1) AGAINST ('ABCD' IN NATURAL LANGUAGE MODE);

DROP TABLE t1;

CREATE TABLE t(x VARCHAR(10), FULLTEXT KEY (x));
SELECT x FROM t GROUP BY x, MATCH(x) AGAINST ('abc')
  HAVING MATCH(x) AGAINST ('abc');
DROP TABLE t;

CREATE TABLE t(x INT);
INSERT INTO t VALUES (1);
SELECT * FROM t WHERE MATCH(x) AGAINST('abc' IN BOOLEAN MODE) AND x = 1;
DROP TABLE t;
