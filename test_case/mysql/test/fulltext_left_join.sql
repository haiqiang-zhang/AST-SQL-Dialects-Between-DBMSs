select round(match(t1.texte,t1.sujet,t1.motsclefs) against('droit'),5)
       from t1 left join t2 on t2.id=t1.id;
select match(t1.texte,t1.sujet,t1.motsclefs) against('droit' IN BOOLEAN MODE)
       from t1 left join t2 on t2.id=t1.id;
drop table t1, t2;
create table t1 (venue_id int(11) default null, venue_text varchar(255) default null, dt datetime default null) engine=myisam;
insert into t1 (venue_id, venue_text, dt) values (1, 'a1', '2003-05-23 19:30:00'),(null, 'a2', '2003-05-23 19:30:00');
create table t2 (name varchar(255) not null default '', entity_id int(11) not null auto_increment, primary key  (entity_id), fulltext key name (name)) engine=myisam;
insert into t2 (name, entity_id) values ('aberdeen town hall', 1), ('glasgow royal concert hall', 2), ('queen\'s hall, edinburgh', 3);
select * from t1 left join t2 on venue_id = entity_id where match(name) against('aberdeen' in boolean mode) and dt = '2003-05-23 19:30:00';
select * from t1 left join t2 on venue_id = entity_id where match(name) against('aberdeen') and dt = '2003-05-23 19:30:00';
select * from t1 left join t2 on (venue_id = entity_id and match(name) against('aberdeen' in boolean mode)) where dt = '2003-05-23 19:30:00';
select * from t1 left join t2 on (venue_id = entity_id and match(name) against('aberdeen')) where dt = '2003-05-23 19:30:00';
drop table t1,t2;
create table t1 (id int not null primary key, d char(200) not null, e char(200));
insert into t1 values (1, 'aword', null), (2, 'aword', 'bword'), (3, 'bword', null), (4, 'bword', 'aword'), (5, 'aword and bword', null);
create table t2 (m_id int not null, f char(200), key (m_id));
insert into t2 values (1, 'bword'), (3, 'aword'), (5, '');
drop table t1,t2;
CREATE TABLE t1 (
  id int(10) NOT NULL auto_increment,
  link int(10) default NULL,
  name mediumtext default NULL,
  PRIMARY KEY (id),
  FULLTEXT (name)
);
INSERT INTO t1 VALUES (1, 1, 'string');
INSERT INTO t1 VALUES (2, 0, 'string');
CREATE TABLE t2 (
    id int(10) NOT NULL auto_increment,
    name mediumtext default NULL,
    PRIMARY KEY (id),
    FULLTEXT (name)
);
INSERT INTO t2 VALUES (1, 'string');
DROP TABLE t1,t2;
CREATE TABLE t1 (a INT);
CREATE TABLE t2 (b INT, c TEXT, KEY(b));
INSERT INTO t1 VALUES(1);
INSERT INTO t2(b,c) VALUES(2,'castle'),(3,'castle');
DROP TABLE t1, t2;
