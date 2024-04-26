--


--disable_warnings
create table t1 (USR_ID integer not null, MAX_REQ integer not null, constraint PK_SEA_USER primary key (USR_ID)) engine=InnoDB;
insert into t1 values (1, 3);
select count(*) + MAX_REQ - MAX_REQ + MAX_REQ - MAX_REQ + MAX_REQ - MAX_REQ + MAX_REQ - MAX_REQ + MAX_REQ - MAX_REQ from t1 group by MAX_REQ;
select Case When Count(*) < MAX_REQ Then 1 Else 0 End from t1 where t1.USR_ID = 1 group by MAX_REQ;
drop table t1;


--
-- Bug #12882  	min/max inconsistent on empty table
--

--disable_warnings
create table t1m (a int) engine=innodb;
create table t1i (a int) engine=innodb;
create table t2m (a int) engine=innodb;
create table t2i (a int) engine=innodb;
insert into t2m values (5);
insert into t2i values (5);

-- test with MyISAM
select min(a) from t1m;
select min(7) from t1m;
select min(7) from DUAL;
select min(7) from t2m join t1m;

select max(a) from t1m;
select max(7) from t1m;
select max(7) from DUAL;
select max(7) from t2m join t1m;

select 1, min(a) from t1m where a=99;
select 1, min(a) from t1m where 1=99;
select 1, min(1) from t1m where a=99;
select 1, min(1) from t1m where 1=99;

select 1, max(a) from t1m where a=99;
select 1, max(a) from t1m where 1=99;
select 1, max(1) from t1m where a=99;
select 1, max(1) from t1m where 1=99;

-- test with InnoDB
select min(a) from t1i;
select min(7) from t1i;
select min(7) from DUAL;
select min(7) from t2i join t1i;

select max(a) from t1i;
select max(7) from t1i;
select max(7) from DUAL;
select max(7) from t2i join t1i;

select 1, min(a) from t1i where a=99;
select 1, min(a) from t1i where 1=99;
select 1, min(1) from t1i where a=99;
select 1, min(1) from t1i where 1=99;

select 1, max(a) from t1i where a=99;
select 1, max(a) from t1i where 1=99;
select 1, max(1) from t1i where a=99;
select 1, max(1) from t1i where 1=99;

-- mixed MyISAM/InnoDB test
explain select count(*), min(7), max(7) from t1m, t1i;
select count(*), min(7), max(7) from t1m, t1i;
select count(*), min(7), max(7) from t1m, t2i;
select count(*), min(7), max(7) from t2m, t1i;

drop table t1m, t1i, t2m, t2i;

CREATE TABLE c (
  pk INT,
  col_varchar_key VARCHAR(1),
  PRIMARY KEY (pk),
  KEY col_varchar_key (col_varchar_key)
) ENGINE=InnoDB;
INSERT INTO c VALUES (11,NULL);
INSERT INTO c VALUES (16,'c');
CREATE TABLE bb (
  pk INT,
  col_varchar_key VARCHAR(1),
  PRIMARY KEY (pk),
  KEY col_varchar_key (col_varchar_key)
) ENGINE=InnoDB;
INSERT INTO bb VALUES (10,NULL);

SELECT straight_join BIT_AND(c.pk)
FROM
  bb, c
  WHERE c.col_varchar_key='ABC'
ORDER BY c.pk;

DROP TABLE c,bb;

CREATE TABLE t1 (pk INT PRIMARY KEY, b INT, c INT) ENGINE=InnoDB;
INSERT INTO t1 VALUES(1, 1, 1);

CREATE TABLE t2 (pk INT PRIMARY KEY, b INT, c INT) ENGINE=InnoDB;
INSERT INTO t2 VALUES (1, 1, NULL);

SELECT t1.* FROM t1  JOIN t2 ON t1.c=t2.c WHERE t1.pk=1;
SELECT BIT_OR(t1.b)  FROM t1 JOIN t2 ON t1.c=t2.c WHERE t1.pk=1;
SELECT BIT_AND(t1.b) FROM t1 JOIN t2 ON t1.c=t2.c WHERE t1.pk=1;
SELECT BIT_XOR(t1.b) FROM t1 JOIN t2 ON t1.c=t2.c WHERE t1.pk=1;

DROP TABLE t1, t2;
