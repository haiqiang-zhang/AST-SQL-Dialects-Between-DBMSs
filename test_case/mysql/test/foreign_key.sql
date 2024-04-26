--

--disable_query_log
call mtr.add_suppression(" In RENAME TABLE table `test`.`parent` is referenced in foreign key constraints which are not compatible with the new table definition.");
SET @saved_binlog_format= @@SESSION.binlog_format;

--
-- Bug#34455 (Ambiguous foreign keys syntax is accepted)
--

--disable_warnings
drop table if exists t_34455;

-- 2 match clauses, illegal
--error ER_PARSE_ERROR
create table t_34455 (
  a int not null,
  foreign key (a) references t3 (a) match full match partial);

-- match after on delete, illegal
--error ER_PARSE_ERROR
create table t_34455 (
  a int not null,
  foreign key (a) references t3 (a) on delete set default match full);

-- match after on update, illegal
--error ER_PARSE_ERROR
create table t_34455 (
  a int not null,
  foreign key (a) references t3 (a) on update set default match full);

-- 2 on delete clauses, illegal
--error ER_PARSE_ERROR
create table t_34455 (
  a int not null,
  foreign key (a) references t3 (a)
  on delete set default on delete set default);

-- 2 on update clauses, illegal
--error ER_PARSE_ERROR
create table t_34455 (
  a int not null,
  foreign key (a) references t3 (a)
  on update set default on update set default);

create table t_34455 (a int not null);

-- 2 match clauses, illegal
--error ER_PARSE_ERROR
alter table t_34455
  add foreign key (a) references t3 (a) match full match partial);

-- match after on delete, illegal
--error ER_PARSE_ERROR
alter table t_34455
  add foreign key (a) references t3 (a) on delete set default match full);

-- match after on update, illegal
--error ER_PARSE_ERROR
alter table t_34455
  add foreign key (a) references t3 (a) on update set default match full);

-- 2 on delete clauses, illegal
--error ER_PARSE_ERROR
alter table t_34455
  add foreign key (a) references t3 (a)
  on delete set default on delete set default);

-- 2 on update clauses, illegal
--error ER_PARSE_ERROR
alter table t_34455
  add foreign key (a) references t3 (a)
  on update set default on update set default);

drop table t_34455;

SET @@foreign_key_checks= 0;
CREATE TABLE t1(a INT PRIMARY KEY, b INT, FOREIGN KEY (b) REFERENCES non(a));
ALTER TABLE t1 ADD FOREIGN KEY (b) REFERENCES non(a);
DROP TABLE t1;

CREATE TABLE t1(a INT PRIMARY KEY);
CREATE TABLE t2(a INT PRIMARY KEY, b INT, FOREIGN KEY (b) REFERENCES t1(a));
DROP TABLE t1;
DROP TABLE t2;

SET @@foreign_key_checks= 1;
CREATE TABLE t1(a INT PRIMARY KEY, b INT, FOREIGN KEY (b) REFERENCES non(a));
CREATE TABLE t1(a INT PRIMARY KEY, b INT REFERENCES non(a));
ALTER TABLE t1 ADD FOREIGN KEY (b) REFERENCES non(a);
DROP TABLE t1;

CREATE TABLE t1(a INT PRIMARY KEY);
CREATE TABLE t2(a INT PRIMARY KEY, b INT, FOREIGN KEY (b) REFERENCES t1(a));
DROP TABLE t1;
DROP TABLE t2, t1;

SET @@foreign_key_checks= DEFAULT;

CREATE TABLE t1(a INT PRIMARY KEY);

-- Exactly 64 chars
CREATE TABLE t2(a INT PRIMARY KEY, b INT);
ALTER TABLE t2 ADD CONSTRAINT
name567890123456789012345678901234567890123456789012345678901234
FOREIGN KEY
name567890123456789012345678901234567890123456789012345678901234
(b) REFERENCES t1(a);
SELECT CONSTRAINT_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE REFERENCED_TABLE_NAME = 't1';
DROP TABLE t2;

-- 65 chars - too long
CREATE TABLE t2(a INT PRIMARY KEY, b INT);
ALTER TABLE t2 ADD FOREIGN KEY
name5678901234567890123456789012345678901234567890123456789012345
(b) REFERENCES t1(a);
ALTER TABLE t2 ADD CONSTRAINT
name5678901234567890123456789012345678901234567890123456789012345
FOREIGN KEY (b) REFERENCES t1(a);
DROP TABLE t2;

-- 65 chars - too long, now with pre-existing index on b
CREATE TABLE t2(a INT PRIMARY KEY, b INT UNIQUE);
ALTER TABLE t2 ADD FOREIGN KEY
name5678901234567890123456789012345678901234567890123456789012345
(b) REFERENCES t1(a);
ALTER TABLE t2 ADD CONSTRAINT
name5678901234567890123456789012345678901234567890123456789012345
FOREIGN KEY (b) REFERENCES t1(a);
DROP TABLE t2;

DROP TABLE t1;
CREATE TABLE t1(a INT PRIMARY KEY, b INT,
FOREIGN KEY(b) REFERENCES name5678901234567890123456789012345678901234567890123456789012345.t2(a));
CREATE TABLE t1(a INT PRIMARY KEY, b INT,
FOREIGN KEY(b) REFERENCES name5678901234567890123456789012345678901234567890123456789012345(a));
CREATE TABLE t1(a INT PRIMARY KEY, b INT,
FOREIGN KEY(b) REFERENCES t2(name5678901234567890123456789012345678901234567890123456789012345));

SET @@foreign_key_checks= 0;
CREATE TABLE t1(a INT PRIMARY KEY, b INT,
FOREIGN KEY(b) REFERENCES name5678901234567890123456789012345678901234567890123456789012345.t2(a));
CREATE TABLE t1(a INT PRIMARY KEY, b INT,
FOREIGN KEY(b) REFERENCES name5678901234567890123456789012345678901234567890123456789012345(a));
CREATE TABLE t1(a INT PRIMARY KEY, b INT,
FOREIGN KEY(b) REFERENCES t2(name5678901234567890123456789012345678901234567890123456789012345));

SET @@foreign_key_checks= DEFAULT;

SET @@foreign_key_checks= 1;

CREATE TABLE t1(c1 INT PRIMARY KEY);
CREATE TABLE t2(c1 INT, FOREIGN KEY (c1) REFERENCES t1(c1));

ALTER TABLE t2 RENAME TO t3;
INSERT INTO t3 VALUES(1);

ALTER TABLE t3 RENAME TO t4, ALGORITHM= INPLACE;
INSERT INTO t4 VALUES(1);

-- TODO: COPY does not work properly, see Bug#25467454
ALTER TABLE t4 RENAME TO t5;
INSERT INTO t5 VALUES(1);
INSERT INTO t6 VALUES(1);

DROP TABLE t6, t1;

CREATE TABLE t1(a INT PRIMARY KEY);
CREATE TABLE t2(a INT, b INT, FOREIGN KEY(a) REFERENCES t1(a));
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
ALTER TABLE t2 ADD FOREIGN KEY(b) REFERENCES t1(a);
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
ALTER TABLE t2 DROP FOREIGN KEY t2_ibfk_1;
ALTER TABLE t2 ADD FOREIGN KEY(a) REFERENCES t1(a);
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
ALTER TABLE t2 RENAME TO t3;
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't3' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't3' ORDER BY constraint_name;
ALTER TABLE t3 RENAME TO t4, ALGORITHM= INPLACE;
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't4' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't4' ORDER BY constraint_name;
ALTER TABLE t4 RENAME TO t5;
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't5' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't5' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't6' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't6' ORDER BY constraint_name;
DROP TABLE t6;
CREATE TABLE `t6` (
  `a` int(11) DEFAULT NULL,
  `b` int(11) DEFAULT NULL,
  KEY `b` (`b`),
  KEY `a` (`a`),
  CONSTRAINT `t6_ibfk_2` FOREIGN KEY (`b`) REFERENCES `t1` (`a`),
  CONSTRAINT `t6_ibfk_3` FOREIGN KEY (`a`) REFERENCES `t1` (`a`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't6' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't6' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
ALTER TABLE t2 DROP FOREIGN KEY t2_ibfk_2, DROP FOREIGN KEY t2_ibfk_3;
ALTER TABLE t2 ADD FOREIGN KEY(a) REFERENCES t1(a);
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
ALTER TABLE t2 ADD CONSTRAINT t3_ibfk_2 FOREIGN KEY(b) REFERENCES t1(a);
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't3' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't3' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't4' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't4' ORDER BY constraint_name;
DROP TABLE t4;
CREATE TABLE t2(a INT, b INT);
ALTER TABLE t2 ADD CONSTRAINT t2_ibfk_1 FOREIGN KEY(a) REFERENCES t1(a);
ALTER TABLE t2 ADD FOREIGN KEY(b) REFERENCES t1(a);
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
DROP TABLE t2;
CREATE TABLE t2(a INT, b INT);
ALTER TABLE t2 ADD CONSTRAINT FK FOREIGN KEY(a) REFERENCES t1(a);
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
ALTER TABLE t2 ADD CONSTRAINT fk FOREIGN KEY(b) REFERENCES t1(a);
ALTER TABLE t2 DROP FOREIGN KEY FK;
ALTER TABLE t2 ADD CONSTRAINT T2_IBFK_1 FOREIGN KEY(a) REFERENCES t1(a);
ALTER TABLE t2 ADD FOREIGN KEY(b) REFERENCES t1(a);
ALTER TABLE t2 DROP FOREIGN KEY T2_IBFK_1;
DROP TABLE t2;
CREATE TABLE t2 (a INT, FOREIGN KEY (a) REFERENCES t1(a));
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't12345678901234567890123456789012345678901234567890123456'
  ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't12345678901234567890123456789012345678901234567890123456'
  ORDER BY constraint_name;
DROP TABLE t12345678901234567890123456789012345678901234567890123456;
CREATE TABLE t123456789012345678901234567890123456789012345678901234567(
  a INT, FOREIGN KEY (a) REFERENCES t1(a));
CREATE TABLE t123456789012345678901234567890123456789012345678901234567890123(
  a INT, CONSTRAINT fk FOREIGN KEY (a) REFERENCES t1(a));
DROP TABLE t123456789012345678901234567890123456789012345678901234567890123;

DROP TABLE t1;
CREATE TABLE t1(a INT PRIMARY KEY,
                b INT GENERATED ALWAYS AS (a+1) VIRTUAL UNIQUE);
CREATE TABLE t2(a INT, FOREIGN KEY (a) REFERENCES t1(b));
CREATE TABLE t2(a INT);
ALTER TABLE t2 ADD FOREIGN KEY(a) REFERENCES t1(b);
DROP TABLE t1, t2;
CREATE TABLE t1(a INT PRIMARY KEY);
CREATE TABLE t2(a INT, b INT GENERATED ALWAYS AS (a+1) STORED UNIQUE);

CREATE TABLE t3(a INT, b INT GENERATED ALWAYS AS (a+1) STORED UNIQUE,
                FOREIGN KEY (b) REFERENCES t1(a));
ALTER TABLE t2 ADD FOREIGN KEY(b) REFERENCES t1(a);
ALTER TABLE t2 DROP FOREIGN KEY t2_ibfk_1;
DROP TABLE t3;
CREATE TABLE t3(a INT, b INT GENERATED ALWAYS AS (a+1) STORED UNIQUE,
                FOREIGN KEY (b) REFERENCES t1(a) ON UPDATE CASCADE);
ALTER TABLE t2 ADD FOREIGN KEY(b) REFERENCES t1(a) ON UPDATE CASCADE;
CREATE TABLE t3(a INT, b INT GENERATED ALWAYS AS (a+1) STORED UNIQUE,
                FOREIGN KEY (b) REFERENCES t1(a) ON DELETE SET NULL);
ALTER TABLE t2 ADD FOREIGN KEY(b) REFERENCES t1(a) ON DELETE SET NULL;
CREATE TABLE t3(a INT, b INT GENERATED ALWAYS AS (a+1) STORED UNIQUE,
                FOREIGN KEY (b) REFERENCES t1(a) ON UPDATE SET NULL);
ALTER TABLE t2 ADD FOREIGN KEY(b) REFERENCES t1(a) ON UPDATE SET NULL;
CREATE TABLE t3(a INT, b INT GENERATED ALWAYS AS (a+1) STORED UNIQUE,
                FOREIGN KEY (a) REFERENCES t1(a));
ALTER TABLE t2 ADD FOREIGN KEY(a) REFERENCES t1(a);
ALTER TABLE t2 DROP FOREIGN KEY t2_ibfk_1;
DROP TABLE t3;
CREATE TABLE t3(a INT, b INT GENERATED ALWAYS AS (a+1) STORED UNIQUE,
                FOREIGN KEY (a) REFERENCES t1(a) ON UPDATE CASCADE);
ALTER TABLE t2 ADD FOREIGN KEY(a) REFERENCES t1(a) ON UPDATE CASCADE;
CREATE TABLE t3(a INT, b INT GENERATED ALWAYS AS (a+1) STORED UNIQUE,
                FOREIGN KEY (a) REFERENCES t1(a) ON DELETE SET NULL);
ALTER TABLE t2 ADD FOREIGN KEY(a) REFERENCES t1(a) ON DELETE SET NULL;
CREATE TABLE t3(a INT, b INT GENERATED ALWAYS AS (a+1) STORED UNIQUE,
                FOREIGN KEY (a) REFERENCES t1(a) ON UPDATE SET NULL);
ALTER TABLE t2 ADD FOREIGN KEY(a) REFERENCES t1(a) ON UPDATE SET NULL;

DROP TABLE t2, t1;
CREATE TABLE t1(a INT PRIMARY KEY);
CREATE TABLE t2(a INT, b INT GENERATED ALWAYS AS (a+1) VIRTUAL UNIQUE,
                FOREIGN KEY(b) REFERENCES t1(a));

CREATE TABLE t2(a INT, b INT GENERATED ALWAYS AS (a+1) VIRTUAL UNIQUE);
ALTER TABLE t2 ADD FOREIGN KEY (b) REFERENCES t1(a);
DROP TABLE t2;

CREATE TABLE t2(a INT, b INT, FOREIGN KEY(b) REFERENCES t1(a));
ALTER TABLE t2 MODIFY COLUMN b INT GENERATED ALWAYS AS (a+1) VIRTUAL;

DROP TABLE t2, t1;
CREATE TABLE t1(a INT PRIMARY KEY, b INT, INDEX(a, b));

CREATE TABLE t2(a INT, b INT, FOREIGN KEY(a, b) REFERENCES t1(a, b));
ALTER TABLE t2 DROP COLUMN a;
ALTER TABLE t2 DROP COLUMN b;
DROP TABLE t2;
CREATE TABLE t2(a INT, b INT, INDEX idx(a, b),
                FOREIGN KEY(a, b) REFERENCES t1(a, b));
ALTER TABLE t2 DROP COLUMN a;
ALTER TABLE t2 DROP COLUMN b;
DROP TABLE t2, t1;
CREATE TABLE t1 (PK VARCHAR(100) PRIMARY KEY);
CREATE TABLE t2 (FK VARCHAR(100), FOREIGN KEY(FK) REFERENCES t1 (PK), KEY(FK));
ALTER TABLE t2 DROP INDEX FK, ADD INDEX FK2(FK(10));
DROP TABLE t2, t1;

CREATE TABLE t1(fld1 INT NOT NULL PRIMARY KEY);
CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW SET @a:=0;
CREATE TABLE t2(fld1 INT NOT NULL, fld2 INT AS (fld1) VIRTUAL, KEY(fld2),
		FOREIGN KEY(fld1) REFERENCES t1(fld1) ON UPDATE CASCADE);

INSERT INTO t1 VALUES(1);
INSERT INTO t2 VALUES(1, DEFAULT);

UPDATE t1 SET fld1= 2;

SELECT * FROM t1;
SELECT * FROM t2;
UPDATE t1 SET fld1= 3;

SELECT * FROM t1;
SELECT * FROM t2;

DROP TABLE t2;
DROP TABLE t1;

CREATE TABLE t1 (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100) UNIQUE);

CREATE TABLE t2 (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100), fname VARCHAR(100), FOREIGN KEY (fname) REFERENCES t1 (name) ON UPDATE CASCADE ON DELETE CASCADE);
ALTER TABLE t2 CONVERT TO CHARACTER SET latin1;

SET foreign_key_checks= OFF;

ALTER TABLE t2 CONVERT TO CHARACTER SET latin1;

SET foreign_key_checks= ON;

INSERT INTO t1(name) VALUES ('test1');
INSERT INTO t2(name, fname) VALUES ('test1', 'test1');
UPDATE t1 SET name=CONCAT('St', UNHEX('C3A5') ,'le') WHERE name = 'test1';
SELECT t1.name, t2.fname FROM t1, t2 WHERE t1.name <> t2.fname;

DROP TABLE t2;
DROP TABLE t1;
CREATE TABLE grandparent (gpf1 INT PRIMARY KEY, gpf2 INT);

INSERT INTO grandparent VALUES (1,10), (2,20);
 
CREATE TABLE parent (
  pf1 INT PRIMARY KEY, pf2 INT, sleep_dummy INT,
  CONSTRAINT pc1 FOREIGN KEY (pf2) REFERENCES grandparent (gpf1)
  ON DELETE NO ACTION ON UPDATE NO ACTION);

INSERT INTO parent VALUES (1,1,0), (2,2,0);

CREATE TABLE child (
  cf1 INT PRIMARY KEY, cf2 INT,
  CONSTRAINT cc1 FOREIGN KEY (cf2) REFERENCES parent (pf1)
  ON DELETE NO ACTION ON UPDATE NO ACTION);

INSERT INTO child VALUES (1,1), (2,2);
SET @@session.lock_wait_timeout= 1;
let $wait_condition=
  SELECT COUNT(*) = 1
    FROM information_schema.processlist
    WHERE id = @conA_id AND state LIKE 'user sleep';

SET @@session.lock_wait_timeout= 1;
UPDATE grandparent SET gpf2= 4;
UPDATE grandparent SET gpf2= 100 * gpf1;
ALTER TABLE child ADD COLUMN (i INT);
SET @@session.lock_wait_timeout= DEFAULT;

DROP TABLE child;
DROP TABLE parent;
DROP TABLE grandparent;
SET @old_lock_wait_timeout= @@lock_wait_timeout;
SET @old_lock_wait_timeout= @@lock_wait_timeout;
CREATE TABLE parent (pk INT PRIMARY KEY);
SELECT * FROM parent;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "CREATE TABLE child%";
SELECT * FROM parent;
CREATE TABLE IF NOT EXISTS child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE child;
SELECT * FROM parent;
SET @@lock_wait_timeout= 1;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DROP TABLE parent;

SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
SET FOREIGN_KEY_CHECKS=1;
SELECT * FROM child;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "CREATE TABLE parent%";
SELECT * FROM child;
CREATE TABLE IF NOT EXISTS parent (pk INT PRIMARY KEY);
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE parent;
SET FOREIGN_KEY_CHECKS=1;
SELECT * FROM child;
SET @@lock_wait_timeout= 1;
CREATE TABLE parent (pk INT PRIMARY KEY);
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DROP TABLE child;
CREATE TABLE parent (pk INT PRIMARY KEY);
SELECT * FROM parent;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE CASCADE);
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "SELECT * FROM child";
DROP TABLES child, parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child2 LIKE child;
SET FOREIGN_KEY_CHECKS=0;
DROP TABLES child2, parent;
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE parent_source (pk INT PRIMARY KEY);
SELECT * FROM child;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "CREATE TABLE parent%";
SELECT * FROM child;
CREATE TABLE IF NOT EXISTS parent LIKE parent_source;
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE parent;
SET FOREIGN_KEY_CHECKS=1;
SELECT * FROM child;
SET @@lock_wait_timeout= 1;
CREATE TABLE IF NOT EXISTS parent LIKE parent_source;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DROP TABLE child, parent_source;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE source (fk INT);
INSERT INTO source VALUES (NULL);
SELECT * FROM source FOR UPDATE;
SET @saved_binlog_format= @@SESSION.binlog_format;
SET @@SESSION.binlog_format=STATEMENT;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "System lock" AND
        info LIKE "CREATE TABLE child%";
INSERT INTO parent VALUES (1);
SET @@lock_wait_timeout= 1;
ALTER TABLE parent ADD COLUMN a INT;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SET SESSION binlog_format= @saved_binlog_format;

DROP TABLES child, source;
SELECT * FROM parent;
SET @@SESSION.binlog_format=STATEMENT;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "CREATE TABLE child%";
SET SESSION binlog_format= @saved_binlog_format;
CREATE TABLE parent2 (pk INT PRIMARY KEY);
SET @@SESSION.binlog_format=STATEMENT;
CREATE TABLE IF NOT EXISTS child (fk INT, FOREIGN KEY (fk) REFERENCES parent2(pk)) SELECT NULL AS fk;
SET SESSION binlog_format= @saved_binlog_format;
DROP TABLE child;
DROP TABLE parent2;
SET @@lock_wait_timeout= 1;
SET @@SESSION.binlog_format=STATEMENT;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk)) SELECT NULL AS fk;
SET SESSION binlog_format= @saved_binlog_format;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM parent;
SET @@lock_wait_timeout= 1;
SET @@SESSION.binlog_format=STATEMENT;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk)) SELECT NULL AS fk;
SET SESSION binlog_format= @saved_binlog_format;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DROP TABLE parent;

SET FOREIGN_KEY_CHECKS=0;
SET @@SESSION.binlog_format=STATEMENT;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
SET SESSION binlog_format= @saved_binlog_format;
SET FOREIGN_KEY_CHECKS=1;
SELECT * FROM child;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "CREATE TABLE parent%";
SELECT * FROM child;
CREATE TABLE IF NOT EXISTS parent (pk INT PRIMARY KEY) SELECT 1 AS pk;
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE parent;
SET FOREIGN_KEY_CHECKS=1;
SELECT * FROM child;
SET @@lock_wait_timeout= 1;
CREATE TABLE parent (pk INT PRIMARY KEY) SELECT 1 AS pk;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DROP TABLE child;
CREATE TABLE parent (pk INT PRIMARY KEY);
SELECT * FROM parent;
SET @saved_binlog_format= @@SESSION.binlog_format;
SET @@SESSION.binlog_format=STATEMENT;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE CASCADE) SELECT NULL AS fk;
SET SESSION binlog_format= @saved_binlog_format;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "SELECT * FROM child";
DROP TABLES child, parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
SELECT * FROM parent;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "DROP TABLES child";

CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
SELECT * FROM parent;
SET @@lock_wait_timeout= 1;
DROP TABLES child;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM child;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "DROP TABLES parent";
SELECT * FROM child;
SET @@lock_wait_timeout= 1;
DROP TABLES parent;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DROP TABLES child;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE CASCADE);
SELECT * FROM parent;
DROP TABLES child;
SELECT * FROM child;

DROP TABLES parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
SELECT * FROM parent;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "RENAME TABLES child%";
SELECT * FROM parent;
SET @@lock_wait_timeout= 1;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM child;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "RENAME TABLES parent%";
SELECT * FROM child;
SET @@lock_wait_timeout= 1;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DROP TABLE child;
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent1(pk));
SET FOREIGN_KEY_CHECKS=1;
SELECT * FROM child;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "RENAME TABLES parent%";
DROP TABLE child;
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent1(pk));
SET FOREIGN_KEY_CHECKS=1;
SELECT * FROM child;
SET @@lock_wait_timeout= 1;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DROP TABLE child;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE CASCADE);
SELECT * FROM parent;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "SELECT * FROM child1";
DROP TABLES child1, parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
SELECT * FROM parent;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE child%";
SELECT * FROM parent;
SET @@lock_wait_timeout= 1;
ALTER TABLE child RENAME TO child1;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM child;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE parent%";
SELECT * FROM child;
SET @@lock_wait_timeout= 1;
ALTER TABLE parent RENAME TO parent1;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DROP TABLE child;
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent1(pk));
SET FOREIGN_KEY_CHECKS=1;
SELECT * FROM child;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE parent%";
DROP TABLE child;
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent1(pk));
SET FOREIGN_KEY_CHECKS=1;
SELECT * FROM child;
SET @@lock_wait_timeout= 1;
ALTER TABLE parent RENAME TO parent1;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DROP TABLE child;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE CASCADE);
SELECT * FROM parent;
ALTER TABLE child RENAME TO child1;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "SELECT * FROM child1";
DROP TABLES child1, parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT);
SELECT * FROM parent;
SET FOREIGN_KEY_CHECKS=0;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE child%";
SET FOREIGN_KEY_CHECKS=1;

ALTER TABLE child DROP FOREIGN KEY fk;
SET @@lock_wait_timeout= 1;
ALTER TABLE child ADD CONSTRAINT fk FOREIGN KEY (fk) REFERENCES parent(pk), ALGORITHM=INPLACE;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM parent;
SET @@lock_wait_timeout= 1;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE child ADD CONSTRAINT fk FOREIGN KEY (fk) REFERENCES parent(pk), ALGORITHM=INPLACE;
SET FOREIGN_KEY_CHECKS=1;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM parent;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE child ADD CONSTRAINT fk FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE CASCADE, ALGORITHM=INPLACE;
SET FOREIGN_KEY_CHECKS=1;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "SELECT * FROM child";
SELECT * FROM parent;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE child%";

ALTER TABLE child ADD CONSTRAINT fk FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE CASCADE;
SELECT * FROM parent;
SET @@lock_wait_timeout= 1;
ALTER TABLE child DROP FOREIGN KEY fk, ALGORITHM=INPLACE;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM parent;
ALTER TABLE child DROP FOREIGN KEY fk, ALGORITHM=INPLACE;
SELECT * FROM child;
DROP TABLES child, parent;
CREATE TABLE parent (pk INT NOT NULL, UNIQUE u(pk));
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
SELECT * FROM child;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE parent%";
SELECT * FROM child;
SET @@lock_wait_timeout= 1;
ALTER TABLE parent RENAME KEY u1 TO u, ALGORITHM=INPLACE;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM parent;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE child%";
SELECT * FROM parent;
SET @@lock_wait_timeout= 1;
ALTER TABLE child RENAME TO child1, ADD COLUMN b INT, ALGORITHM=INPLACE;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM child;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE parent%";
SELECT * FROM child;
SET @@lock_wait_timeout= 1;
ALTER TABLE parent RENAME TO parent1, ADD COLUMN b INT, ALGORITHM=INPLACE;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DROP TABLE child;
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent1(pk));
SET FOREIGN_KEY_CHECKS=1;
SELECT * FROM child;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE parent%";
DROP TABLE child;
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent1(pk));
SET FOREIGN_KEY_CHECKS=1;
SELECT * FROM child;
SET @@lock_wait_timeout= 1;
ALTER TABLE parent RENAME TO parent1, ADD COLUMN d INT, ALGORITHM=INPLACE;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DROP TABLE child;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE CASCADE);
SELECT * FROM parent;
ALTER TABLE child RENAME TO child1, ADD COLUMN a INT, ALGORITHM=INPLACE;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "SELECT * FROM child1";
DROP TABLES child1, parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT);
SELECT * FROM parent;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE child%";

ALTER TABLE child DROP FOREIGN KEY fk;
SET @@lock_wait_timeout= 1;
ALTER TABLE child ADD CONSTRAINT fk FOREIGN KEY (fk) REFERENCES parent(pk), ALGORITHM=COPY;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DELETE FROM parent;
SET @@lock_wait_timeout= 1;
ALTER TABLE child ADD CONSTRAINT fk FOREIGN KEY (fk) REFERENCES parent(pk), ALGORITHM=COPY;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM parent;
SET @@lock_wait_timeout= 1;
ALTER TABLE child ADD CONSTRAINT fk FOREIGN KEY (fk) REFERENCES parent(pk), ALGORITHM=COPY;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM parent;
ALTER TABLE child ADD CONSTRAINT fk FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE CASCADE, ALGORITHM=COPY;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "SELECT * FROM child";
SELECT * FROM parent;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE child%";

ALTER TABLE child ADD CONSTRAINT fk FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE CASCADE;
SELECT * FROM parent;
SET @@lock_wait_timeout= 1;
ALTER TABLE child DROP FOREIGN KEY fk, ALGORITHM=COPY;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM parent;
ALTER TABLE child DROP FOREIGN KEY fk, ALGORITHM=COPY;
SELECT * FROM child;
DROP TABLES child, parent;
CREATE TABLE parent (pk INT NOT NULL, UNIQUE u(pk));
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
SELECT * FROM child;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE parent%";
SELECT * FROM child;
SET @@lock_wait_timeout= 1;
ALTER TABLE parent RENAME KEY u1 TO u, ALGORITHM=COPY;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM parent;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE child%";
SELECT * FROM parent;
SET @@lock_wait_timeout= 1;
ALTER TABLE child RENAME TO child1, ADD COLUMN b INT, ALGORITHM=COPY;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM child;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE parent%";
SELECT * FROM child;
SET @@lock_wait_timeout= 1;
ALTER TABLE parent RENAME TO parent1, ADD COLUMN b INT, ALGORITHM=COPY;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DROP TABLE child;
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent1(pk));
SET FOREIGN_KEY_CHECKS=1;
SELECT * FROM child;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE parent%";
DROP TABLE child;
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent1(pk));
SET FOREIGN_KEY_CHECKS=1;
SELECT * FROM child;
SET @@lock_wait_timeout= 1;
ALTER TABLE parent RENAME TO parent1, ADD COLUMN d INT, ALGORITHM=COPY;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DROP TABLE child;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE CASCADE);
SELECT * FROM parent;
ALTER TABLE child RENAME TO child1, ADD COLUMN a INT, ALGORITHM=COPY;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "SELECT * FROM child1";
DROP TABLES child1, parent;
CREATE TABLE t (pk INTEGER PRIMARY KEY, fk_i INTEGER,
  CONSTRAINT xxxxxxxxx1xxxxxxxxx2xxxxxxxxx3xxxxxxxxx4xxxxxxxxx5xxxxxxxxx6xxxxx
  FOREIGN KEY (fk_i) REFERENCES x(x));
CREATE TABLE t (pk INTEGER PRIMARY KEY, fk_i INTEGER,
  FOREIGN KEY (fk_i) REFERENCES x(xxxxxxxxx1xxxxxxxxx2xxxxxxxxx3xxxxxxxxx4xxxxxxxxx5xxxxxxxxx6xxxxx));
CREATE TABLE t (pk INTEGER PRIMARY KEY, fk_i INTEGER,
  FOREIGN KEY (fk_i) REFERENCES x(`x `));

CREATE TABLE parent(pk INTEGER PRIMARY KEY, i INTEGER, fk_i INTEGER,
  UNIQUE KEY parent_i_key(i),
  FOREIGN KEY (fk_i) REFERENCES parent(i));

CREATE TABLE child(pk INTEGER PRIMARY KEY, fk_i INTEGER,
  FOREIGN KEY (fk_i) REFERENCES parent(i));

SET @@session.foreign_key_checks= 1;
DROP TABLES parent;

SET @@session.foreign_key_checks= 0;
DROP TABLES parent;
SET @@session.foreign_key_checks= 1;

CREATE TABLE parent(pk INTEGER PRIMARY KEY, i INTEGER,
  UNIQUE KEY parent_i_key(i));
DROP TABLES child, parent;

SET @@session.foreign_key_checks= DEFAULT;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT);
ALTER TABLE child ADD CONSTRAINT fk FOREIGN KEY (fk) REFERENCES parent(pk);
ALTER TABLE child ADD CONSTRAINT fk FOREIGN KEY (fk) REFERENCES parent(pk);
ALTER TABLE child RENAME TO child1;
ALTER TABLE parent RENAME TO parent1;
ALTER TABLE child1 RENAME TO child;
INSERT INTO child VALUES (NULL);
DELETE FROM parent1;
ALTER TABLE parent1 RENAME TO parent;
INSERT INTO child VALUES (NULL);
ALTER TABLE child DROP FOREIGN KEY fk;
ALTER TABLE child RENAME TO child1, ADD CONSTRAINT fk FOREIGN KEY (fk) REFERENCES parent(pk);
INSERT INTO child1 VALUES (NULL);
DELETE FROM parent;
DROP TABLE child1;
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE child (fk INT, FOREIGN KEY(fk) REFERENCES parent1(pk) ON DELETE CASCADE);
SET FOREIGN_KEY_CHECKS=1;
ALTER TABLE parent RENAME TO parent1;
ALTER TABLE parent RENAME TO parent1;
ALTER TABLE parent RENAME TO parent1;
INSERT INTO child VALUES (NULL);
DELETE FROM parent1;
DROP TABLES child, parent1;

CREATE TABLE t1 (pk INT PRIMARY KEY, fk INT,
                 FOREIGN KEY (fk) REFERENCES t1 (pk));
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t1'
  ORDER BY constraint_name;
ALTER TABLE t1 CHANGE pk id INT;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t1'
  ORDER BY constraint_name;
ALTER TABLE t1 CHANGE id pk INT, ALGORITHM=COPY;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t1'
  ORDER BY constraint_name;
ALTER TABLE t1 CHANGE id pk INT, ALGORITHM=INPLACE;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t1'
  ORDER BY constraint_name;
ALTER TABLE t1 RENAME COLUMN pk TO id;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t1'
  ORDER BY constraint_name;
ALTER TABLE t1 RENAME COLUMN id TO pk, ALGORITHM=COPY;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t1'
  ORDER BY constraint_name;
ALTER TABLE t1 RENAME COLUMN id TO pk, ALGORITHM=INPLACE;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t1'
  ORDER BY constraint_name;
DROP TABLE t1;

CREATE TABLE t1 (pk INT PRIMARY KEY);
CREATE TABLE t2 (fk INT, FOREIGN KEY (fk) REFERENCES t1 (pk));
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t2'
  ORDER BY constraint_name;
ALTER TABLE t1 CHANGE pk id INT;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t2'
  ORDER BY constraint_name;
ALTER TABLE t1 CHANGE id pk INT, ALGORITHM=COPY;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t2'
  ORDER BY constraint_name;
ALTER TABLE t1 CHANGE id pk INT, ALGORITHM=INPLACE;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t2'
  ORDER BY constraint_name;
ALTER TABLE t1 RENAME COLUMN pk TO id;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t2'
  ORDER BY constraint_name;
ALTER TABLE t1 RENAME COLUMN id TO pk, ALGORITHM=COPY;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t2'
  ORDER BY constraint_name;
ALTER TABLE t1 RENAME COLUMN id TO pk, ALGORITHM=INPLACE;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t2'
  ORDER BY constraint_name;
DROP TABLES t2, t1;
CREATE TABLE t1 (pk INT PRIMARY KEY, u1 INT, u2 INT, fk1 INT, fk2 INT,
                 UNIQUE (u1), UNIQUE (u2),
                 FOREIGN KEY (fk1) REFERENCES t1 (u1),
                 FOREIGN KEY (fk2) REFERENCES t1 (u2));
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t1'
  ORDER BY constraint_name;
ALTER TABLE t1 RENAME COLUMN u1 TO u3;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t1'
  ORDER BY constraint_name;
ALTER TABLE t1 RENAME COLUMN u3 TO u4, RENAME COLUMN u2 TO u5;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t1'
  ORDER BY constraint_name;
DROP TABLE t1;
CREATE TABLE t1 (pk INT PRIMARY KEY, u1 INT, u2 INT, UNIQUE (u1), UNIQUE (u2));
CREATE TABLE t2 (fk1 INT, fk2 INT,
                FOREIGN KEY (fk1) REFERENCES t1 (u1),
                FOREIGN KEY (fk2) REFERENCES t1 (u2));
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t2'
  ORDER BY constraint_name;
ALTER TABLE t1 RENAME COLUMN u1 TO u3;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t2'
  ORDER BY constraint_name;
ALTER TABLE t1 RENAME COLUMN u3 TO u4, RENAME COLUMN u2 TO u5;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t2'
  ORDER BY constraint_name;
DROP TABLES t2, t1;
CREATE TABLE t1 (u INT NOT NULL, UNIQUE u(u));
CREATE TABLE t2 (fk INT, FOREIGN KEY (fk) REFERENCES t1 (u));
CREATE TABLE t3 (fk INT, FOREIGN KEY (fk) REFERENCES t1 (u));
ALTER TABLE t1 RENAME KEY u TO u1;
ALTER TABLE t1 RENAME TO t4;
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE t4;
DROP TABLES t2, t3;
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE t1 (i INT PRIMARY KEY);
CREATE TABLE t2 (j INT, FOREIGN KEY (j) REFERENCES t1 (i) ON DELETE CASCADE);
CREATE TABLE t3 (k INT);
CREATE TRIGGER bi_t3 BEFORE INSERT ON t3 FOR EACH ROW
BEGIN
IF @a = 1234567890 THEN
  DELETE FROM t1;
END IF;
DROP TABLES t2, t1;
CREATE TABLE t1 (i INT PRIMARY KEY);
CREATE TABLE t2 (j INT, FOREIGN KEY (j) REFERENCES t1 (i) ON DELETE CASCADE);
DROP TABLES t2, t1;
CREATE VIEW t2 AS SELECT 1 AS j;
DROP TABLE t3;
DROP VIEW t2;
CREATE TABLE t0 (i INT);
CREATE TRIGGER t0_bi BEFORE INSERT ON t0 FOR EACH ROW DELETE FROM t1;
CREATE TABLE t1 (pk INT PRIMARY KEY);
CREATE TABLE t2 (fk INT, FOREIGN KEY (fk) REFERENCES t1 (pk) ON UPDATE SET NULL);
DELETE FROM t1;
UPDATE t1 SET pk = 10;
DROP TABLES t2, t1, t0;
CREATE TABLE t1 (pk INT PRIMARY KEY);
CREATE TABLE t2 (fk1 INT, fk2 INT, fk3 INT,
                 CONSTRAINT a FOREIGN KEY (fk1) REFERENCES t1 (pk),
                 CONSTRAINT t2_ibfk_1 FOREIGN KEY (fk2) REFERENCES t1 (pk));
ALTER TABLE t2 ADD FOREIGN KEY (fk3) REFERENCES t1 (pk);
CREATE SCHEMA mysqltest;
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='mysqltest';
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';
ALTER TABLE t4 RENAME TO t5;
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';

ALTER TABLE t5 RENAME TO mysqltest.t5;
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='mysqltest';

ALTER TABLE mysqltest.t5 RENAME TO t6;
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';
ALTER TABLE t6 ADD COLUMN i INT, RENAME TO t7, ALGORITHM=INPLACE;
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';

ALTER TABLE t7 ADD COLUMN j INT, RENAME TO mysqltest.t7, ALGORITHM=INPLACE;
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='mysqltest';

ALTER TABLE mysqltest.t7 ADD COLUMN k INT, RENAME TO t8, ALGORITHM=INPLACE;
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';
ALTER TABLE t8 ADD COLUMN l INT, RENAME TO t9, ALGORITHM=COPY;
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';

ALTER TABLE t9 ADD COLUMN m INT, RENAME TO mysqltest.t9, ALGORITHM=COPY;
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='mysqltest';

ALTER TABLE mysqltest.t9 ADD COLUMN n INT, RENAME TO t10, ALGORITHM=COPY;
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE t10 ADD FOREIGN KEY (i) REFERENCES t1 (pk),
                ADD CONSTRAINT t10_ibfk_4 FOREIGN KEY (j) REFERENCES t1 (pk),
                RENAME TO t11, ALGORITHM=INPLACE;
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';

ALTER TABLE t11 ADD FOREIGN KEY (k) REFERENCES test.t1 (pk),
                ADD CONSTRAINT t11_ibfk_6 FOREIGN KEY (l) REFERENCES test.t1 (pk),
                RENAME TO mysqltest.t11, ALGORITHM=INPLACE;
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='mysqltest';

ALTER TABLE mysqltest.t11 ADD FOREIGN KEY (m) REFERENCES test.t1 (pk),
                ADD CONSTRAINT t12_ibfk_8 FOREIGN KEY (n) REFERENCES test.t1 (pk),
                RENAME TO t12, ALGORITHM=INPLACE;
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';
SET FOREIGN_KEY_CHECKS=1;
ALTER TABLE t12 ADD COLUMN o INT, ADD COLUMN p INT,
                ADD FOREIGN KEY (o) REFERENCES t1 (pk),
                ADD CONSTRAINT t12_ibfk_10 FOREIGN KEY (p) REFERENCES t1 (pk),
                RENAME TO t13, ALGORITHM=COPY;
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';

ALTER TABLE t13 ADD COLUMN q INT, ADD COLUMN r INT,
                ADD FOREIGN KEY (q) REFERENCES test.t1 (pk),
                ADD CONSTRAINT t13_ibfk_12 FOREIGN KEY (r) REFERENCES test.t1 (pk),
                RENAME TO mysqltest.t13, ALGORITHM=COPY;
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='mysqltest';


ALTER TABLE mysqltest.t13 ADD COLUMN s INT, ADD COLUMN t INT,
                ADD FOREIGN KEY (s) REFERENCES test.t1 (pk),
                ADD CONSTRAINT t13_ibfk_14 FOREIGN KEY (t) REFERENCES test.t1 (pk),
                RENAME TO t14, ALGORITHM=COPY;
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';

DROP TABLE t14;
CREATE TABLE t2 (fk INT, CONSTRAINT c FOREIGN KEY (fk) REFERENCES t1 (pk));
CREATE TABLE t3 (pk INT PRIMARY KEY, fk INT, u INT);
INSERT INTO t3 VALUES (1, 1, 1), (2, 1, 1);
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE t3 ADD CONSTRAINT c FOREIGN KEY (fk) REFERENCES t1 (pk),
               ADD UNIQUE KEY (u), ALGORITHM=INPLACE;
CREATE TABLE t4 (fk INT, CONSTRAINT t3_ibfk_1 FOREIGN KEY (fk) REFERENCES t1 (pk));
ALTER TABLE t3 ADD FOREIGN KEY (fk) REFERENCES t1 (pk),
               ADD UNIQUE KEY (u), ALGORITHM=INPLACE;
ALTER TABLE t3 ADD CONSTRAINT c FOREIGN KEY (fk) REFERENCES t1 (pk),
               ADD UNIQUE KEY (u), RENAME TO mysqltest.t3,
               ALGORITHM=INPLACE;
ALTER TABLE t3 ADD FOREIGN KEY (fk) REFERENCES t1 (pk),
               ADD UNIQUE KEY (u), RENAME TO t5,
               ALGORITHM=INPLACE;
CREATE TABLE mysqltest.t5 (fk INT,
                           CONSTRAINT d FOREIGN KEY (fk) REFERENCES test.t1 (pk));
CREATE TABLE t6 (fk INT, CONSTRAINT t8_ibfk_1 FOREIGN KEY (fk) REFERENCES test.t1 (pk));
CREATE TABLE mysqltest.t6 (fk INT,
                           CONSTRAINT t8_ibfk_1 FOREIGN KEY (fk) REFERENCES test.t1 (pk));
DROP TABLE t4;
ALTER TABLE t3 ADD CONSTRAINT d FOREIGN KEY (fk) REFERENCES t1 (pk),
               ADD UNIQUE KEY (u), RENAME TO mysqltest.t3,
               ALGORITHM=INPLACE;
ALTER TABLE t3 ADD FOREIGN KEY (fk) REFERENCES t1 (pk),
               ADD UNIQUE KEY (u), RENAME TO t8,
               ALGORITHM=INPLACE;
ALTER TABLE t3 ADD FOREIGN KEY (fk) REFERENCES t1 (pk),
               ADD UNIQUE KEY (u), RENAME TO mysqltest.t8,
               ALGORITHM=INPLACE;
SET FOREIGN_KEY_CHECKS=1;
ALTER TABLE t3 ADD CONSTRAINT c FOREIGN KEY (fk) REFERENCES t1 (pk),
               ADD UNIQUE KEY (u), ALGORITHM=COPY;
CREATE TABLE t4 (fk INT, CONSTRAINT t3_ibfk_1 FOREIGN KEY (fk) REFERENCES t1 (pk));
ALTER TABLE t3 ADD FOREIGN KEY (fk) REFERENCES t1 (pk),
               ADD UNIQUE KEY (u), ALGORITHM=COPY;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE t3 ADD CONSTRAINT c FOREIGN KEY (fk) REFERENCES t1 (pk),
               ADD UNIQUE KEY (u), RENAME TO mysqltest.t3,
               ALGORITHM=COPY;
SET FOREIGN_KEY_CHECKS=1;
ALTER TABLE t3 ADD FOREIGN KEY (fk) REFERENCES t1 (pk),
               ADD UNIQUE KEY (u), RENAME TO t5,
               ALGORITHM=COPY;
DROP TABLE t4;
ALTER TABLE t3 ADD CONSTRAINT d FOREIGN KEY (fk) REFERENCES test.t1 (pk),
               ADD UNIQUE KEY (u), RENAME TO mysqltest.t3,
               ALGORITHM=COPY;
ALTER TABLE t3 ADD FOREIGN KEY (fk) REFERENCES test.t1 (pk),
               ADD UNIQUE KEY (u), RENAME TO t8,
               ALGORITHM=COPY;
ALTER TABLE t3 ADD FOREIGN KEY (fk) REFERENCES test.t1 (pk),
               ADD UNIQUE KEY (u), RENAME TO mysqltest.t8,
               ALGORITHM=COPY;

DROP SCHEMA mysqltest;
DROP TABLES t6, t3, t2, t1;
CREATE TABLE t1 (pk INT PRIMARY KEY);
CREATE TABLE T2 (fk INT);
ALTER TABLE T2 ADD FOREIGN KEY (fk) REFERENCES t1 (pk);
DROP TABLES T3, t1;
CREATE TABLE t1 (pk INT PRIMARY KEY);
CREATE TABLE t2 (fk INT, FOREIGN KEY (fk) REFERENCES t1 (pk));
DROP TABLE t1;
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE t1;
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE t1 (pk INT PRIMARY KEY);
DROP TABLES t1, t2;
CREATE TABLE t1 (pk INT PRIMARY KEY, fk INT);
CREATE TABLE t2 (pk INT PRIMARY KEY, fk INT,
                 FOREIGN KEY(fk) REFERENCES t1 (pk));
ALTER TABLE t1 ADD FOREIGN KEY (fk) REFERENCES t2 (pk);
DROP TABLES t1, t2;
CREATE SCHEMA mysqltest;
CREATE TABLE mysqltest.t1 (pk INT PRIMARY KEY);
CREATE TABLE t2 (fk INT, FOREIGN KEY(fk) REFERENCES mysqltest.t1 (pk));
DROP SCHEMA mysqltest;
SET FOREIGN_KEY_CHECKS=0;
DROP SCHEMA mysqltest;
SET FOREIGN_KEY_CHECKS=1;
DROP TABLE t2;
CREATE SCHEMA mysqltest;
USE mysqltest;
CREATE TABLE t1 (pk INT PRIMARY KEY, fk INT);
CREATE TABLE t2 (pk INT PRIMARY KEY, fk INT,
                 FOREIGN KEY(fk) REFERENCES t1 (pk));
ALTER TABLE t1 ADD FOREIGN KEY (fk) REFERENCES t2 (pk);
USE test;
DROP SCHEMA mysqltest;
CREATE TABLE parent(pk INT PRIMARY KEY, a INT);
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(a));
SET FOREIGN_KEY_CHECKS = 0;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(a));
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE self (pk INT PRIMARY KEY, a INT, fk INT,
                   FOREIGN KEY (fk) REFERENCES self(a));
SET FOREIGN_KEY_CHECKS = 0;
CREATE TABLE self (pk INT PRIMARY KEY, a INT, fk INT,
                   FOREIGN KEY (fk) REFERENCES self(a));
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES no_such_parent(pk));
SET FOREIGN_KEY_CHECKS = 0;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES no_such_parent(pk));
SET FOREIGN_KEY_CHECKS = 1;
DROP TABLE child;
CREATE TABLE child (fk INT, fk2 INT);
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES parent(a), ALGORITHM=COPY;
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES parent(a), ALGORITHM=INPLACE;
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES parent(a), ALGORITHM=COPY;
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES parent(a), ALGORITHM=INPLACE;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE self (pk INT PRIMARY KEY, a INT, fk INT);
ALTER TABLE self ADD FOREIGN KEY (fk) REFERENCES self(a), ALGORITHM=COPY;
ALTER TABLE self ADD FOREIGN KEY (fk) REFERENCES self(a), ALGORITHM=INPLACE;
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE self ADD FOREIGN KEY (fk) REFERENCES self(a), ALGORITHM=COPY;
ALTER TABLE self ADD FOREIGN KEY (fk) REFERENCES self(a), ALGORITHM=INPLACE;
SET FOREIGN_KEY_CHECKS = 1;
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES no_such_parent(pk), ALGORITHM=COPY;
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES no_such_parent(pk), ALGORITHM=INPLACE;
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES no_such_parent(pk), ALGORITHM=COPY;
ALTER TABLE child ADD FOREIGN KEY (fk2) REFERENCES no_such_parent(pk), ALGORITHM=INPLACE;
SET FOREIGN_KEY_CHECKS = 1;
DROP TABLE child, self, parent;
CREATE TABLE parent (pk INT PRIMARY KEY, u INT NOT NULL, UNIQUE(u));
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(u));
ALTER TABLE parent DROP KEY u, ALGORITHM=COPY;
ALTER TABLE parent DROP KEY u, ALGORITHM=INPLACE;
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE parent DROP KEY u, ALGORITHM=COPY;
ALTER TABLE parent DROP KEY u, ALGORITHM=INPLACE;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE self (pk INT PRIMARY KEY, u INT NOT NULL, fk INT, UNIQUE(u),
                   FOREIGN KEY (fk) REFERENCES self(u));
ALTER TABLE self DROP KEY u, ALGORITHM=COPY;
ALTER TABLE self DROP KEY u, ALGORITHM=INPLACE;
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE self DROP KEY u, ALGORITHM=COPY;
ALTER TABLE self DROP KEY u, ALGORITHM=INPLACE;
SET FOREIGN_KEY_CHECKS = 1;
ALTER TABLE parent DROP KEY u, ADD KEY nu(u);
ALTER TABLE parent DROP KEY nu, ALGORITHM=COPY;
ALTER TABLE parent DROP KEY nu, ALGORITHM=INPLACE;
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE parent DROP KEY nu, ALGORITHM=COPY;
ALTER TABLE parent DROP KEY nu, ALGORITHM=INPLACE;
SET FOREIGN_KEY_CHECKS = 1;
ALTER TABLE self DROP KEY u, ADD KEY nu(u);
ALTER TABLE self DROP KEY nu, ALGORITHM=COPY;
ALTER TABLE self DROP KEY nu, ALGORITHM=INPLACE;
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE self DROP KEY nu, ALGORITHM=COPY;
ALTER TABLE self DROP KEY nu, ALGORITHM=INPLACE;
SET FOREIGN_KEY_CHECKS = 1;
DROP TABLES self, child, parent;
SET FOREIGN_KEY_CHECKS = 0;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(a));
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE parent (pk INT PRIMARY KEY, a INT);
SET FOREIGN_KEY_CHECKS = 0;
CREATE TABLE parent (pk INT PRIMARY KEY, a INT);
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE parent1 (pk INT PRIMARY KEY, a INT);
SET FOREIGN_KEY_CHECKS = 0;
SET FOREIGN_KEY_CHECKS = 1;
ALTER TABLE parent1 RENAME TO parent;
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE parent1 RENAME TO parent;
SET FOREIGN_KEY_CHECKS = 1;
ALTER TABLE parent1 ADD COLUMN b INT, RENAME TO parent, ALGORITHM=INPLACE;
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE parent1 RENAME TO parent;
SET FOREIGN_KEY_CHECKS = 1;
ALTER TABLE parent1 ADD COLUMN b INT, RENAME TO parent, ALGORITHM=COPY;
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE parent1 RENAME TO parent;
SET FOREIGN_KEY_CHECKS = 1;
DROP TABLE parent1, child;
CREATE TABLE grandparent (pk INT PRIMARY KEY);
CREATE TABLE parent (pkfk INT, FOREIGN KEY (pkfk) REFERENCES grandparent(pk));
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pkfk));
SELECT referenced_table_name, unique_constraint_name FROM
  information_schema.referential_constraints WHERE table_name = 'child';
ALTER TABLE parent ADD UNIQUE KEY u (pkfk);
SELECT referenced_table_name, unique_constraint_name FROM
  information_schema.referential_constraints WHERE table_name = 'child';
DROP TABLE child, parent;

CREATE TABLE self (fk INT, pkfk INT,
                   FOREIGN KEY (fk) REFERENCES self (pkfk),
                   FOREIGN KEY (pkfk) REFERENCES grandparent(pk));
SELECT referenced_table_name, unique_constraint_name FROM
  information_schema.referential_constraints WHERE table_name = 'self'
  ORDER BY referenced_table_name;
ALTER TABLE self ADD UNIQUE KEY u (pkfk);
SELECT referenced_table_name, unique_constraint_name FROM
  information_schema.referential_constraints WHERE table_name = 'self'
  ORDER BY referenced_table_name;
DROP TABLE self, grandparent;

CREATE TABLE grandparent1 (pk INT PRIMARY KEY);
CREATE TABLE grandparent2 (pk1 INT , pk2 INT, PRIMARY KEY(pk1, pk2));
CREATE TABLE parent (pkfk1 INT, pkfk2 INT, FOREIGN KEY (pkfk1) REFERENCES grandparent1(pk));
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pkfk1));
SELECT referenced_table_name, unique_constraint_name FROM
  information_schema.referential_constraints WHERE table_name = 'child';
ALTER TABLE parent ADD FOREIGN KEY (pkfk1, pkfk2) REFERENCES grandparent2(pk1, pk2);
SELECT referenced_table_name, unique_constraint_name FROM
  information_schema.referential_constraints WHERE table_name = 'child';
DROP TABLE child, parent;

CREATE TABLE self (fk INT, pkfk1 INT, pkfk2 INT,
                   FOREIGN KEY (fk) REFERENCES self (pkfk1),
                   FOREIGN KEY (pkfk1) REFERENCES grandparent1(pk));
SELECT referenced_table_name, unique_constraint_name FROM
  information_schema.referential_constraints WHERE table_name = 'self'
  ORDER BY referenced_table_name;
ALTER TABLE self ADD FOREIGN KEY (pkfk1, pkfk2) REFERENCES grandparent2(pk1, pk2);
SELECT referenced_table_name, unique_constraint_name FROM
  information_schema.referential_constraints WHERE table_name = 'self'
  ORDER BY referenced_table_name;
DROP TABLE self, grandparent1, grandparent2;
CREATE TABLE parent (pk INT PRIMARY KEY, j INT);
CREATE TABLE child (fk INT, FOREIGN KEY (nocol) REFERENCES parent(pk));
CREATE TABLE self (pk INT PRIMARY KEY, FOREIGN KEY (nocol) REFERENCES self(pk));
CREATE TABLE child (fk INT, j INT);
CREATE TABLE self (pk INT PRIMARY KEY, fk INT);
ALTER TABLE child ADD FOREIGN KEY (nocol) REFERENCES parent(pk);
ALTER TABLE self ADD FOREIGN KEY (nocol) REFERENCES self(pk);
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES parent(pk);
ALTER TABLE child DROP COLUMN fk;
ALTER TABLE child DROP COLUMN fk, ADD COLUMN fk INT;
ALTER TABLE self ADD FOREIGN KEY (fk) REFERENCES self(pk);
ALTER TABLE self DROP COLUMN fk;
ALTER TABLE self DROP COLUMN fk, ADD COLUMN fk INT;
DROP TABLE child;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(nocol));
DROP TABLE self;
CREATE TABLE self (pk INT PRIMARY KEY, fk INT, FOREIGN KEY (fk) REFERENCES self(nocol));
CREATE TABLE child (fk INT);
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES parent(nocol);
CREATE TABLE self (pk INT PRIMARY KEY, fk INT);
ALTER TABLE self ADD FOREIGN KEY (fk) REFERENCES self(nocol);
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES parent(pk);
ALTER TABLE parent DROP COLUMN pk;
ALTER TABLE parent DROP COLUMN pk, ADD COLUMN pk INT;
ALTER TABLE self ADD FOREIGN KEY (fk) REFERENCES self(pk);
ALTER TABLE self DROP COLUMN pk;
ALTER TABLE self DROP COLUMN pk, ADD COLUMN pk INT;
DROP TABLES child, parent;
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(nocol));
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE parent0 (pk INT PRIMARY KEY);
ALTER TABLE parent0 RENAME TO parent;
SET FOREIGN_KEY_CHECKS=1;
DROP TABLES child, parent0, self;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (base INT, fk INT GENERATED ALWAYS AS (base+1) VIRTUAL,
                    FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE self (pk INT PRIMARY KEY, base INT,
                   fk INT GENERATED ALWAYS AS (base+1) VIRTUAL,
                   FOREIGN KEY (fk) REFERENCES self(pk));
CREATE TABLE child (base INT, fk INT GENERATED ALWAYS AS (base+1) VIRTUAL);
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES parent(pk);
CREATE TABLE self (pk INT PRIMARY KEY, base INT,
                   fk INT GENERATED ALWAYS AS (base+1) VIRTUAL);
ALTER TABLE self ADD FOREIGN KEY (fk) REFERENCES self(pk);
DROP TABLE child, self;
CREATE TABLE child (base INT, fk INT GENERATED ALWAYS AS (base+1) STORED,
                    FOREIGN KEY (fk) REFERENCES parent(pk));
ALTER TABLE child MODIFY fk INT GENERATED ALWAYS AS (base+1) VIRTUAL;
CREATE TABLE self (pk INT PRIMARY KEY, base INT,
                   fk INT GENERATED ALWAYS AS (base+1) STORED,
                   FOREIGN KEY (fk) REFERENCES self(pk));
ALTER TABLE self MODIFY fk INT GENERATED ALWAYS AS (base+1) VIRTUAL;
DROP TABLE child, parent, self;
CREATE TABLE parent (base INT, pk INT GENERATED ALWAYS AS (base+1) VIRTUAL, UNIQUE KEY(pk));
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk INT);
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES parent(pk);
CREATE TABLE self (base INT, pk INT GENERATED ALWAYS AS (base+1) VIRTUAL, fk INT,
                   UNIQUE KEY(pk), FOREIGN KEY (fk) REFERENCES self(pk));
CREATE TABLE self (base INT, pk INT GENERATED ALWAYS AS (base+1) VIRTUAL, fk INT,
                   UNIQUE KEY(pk));
ALTER TABLE self ADD FOREIGN KEY (fk) REFERENCES self(pk);
DROP TABLE child, parent, self;
CREATE TABLE parent (base INT, pk INT GENERATED ALWAYS AS (base+1) STORED, UNIQUE KEY(pk));
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
ALTER TABLE parent MODIFY pk INT GENERATED ALWAYS AS (base+1) VIRTUAL;
CREATE TABLE self (base INT, pk INT GENERATED ALWAYS AS (base+1) STORED, fk INT,
                   UNIQUE KEY(pk), FOREIGN KEY (fk) REFERENCES self(pk));
ALTER TABLE self MODIFY pk INT GENERATED ALWAYS AS (base+1) VIRTUAL;
DROP TABLES child, parent, self;
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE parent (base INT, pk INT GENERATED ALWAYS AS (base+1) VIRTUAL, UNIQUE KEY(pk));
CREATE TABLE parent0 (base INT, pk INT GENERATED ALWAYS AS (base+1) VIRTUAL, UNIQUE KEY(pk));
ALTER TABLE parent0 RENAME TO parent;
SET FOREIGN_KEY_CHECKS=1;
DROP TABLES child, parent0;
CREATE TABLE parent (pk POINT SRID 0 NOT NULL, KEY(pk));
CREATE TABLE child (fk POINT SRID 0 NOT NULL, FOREIGN KEY(fk) REFERENCES parent(pk));
CREATE TABLE child (fk POINT SRID 0 NOT NULL);
ALTER TABLE child ADD FOREIGN KEY(fk) REFERENCES parent(pk);
CREATE TABLE self (pk POINT SRID 0 NOT NULL, fk POINT SRID 0 NOT NULL,
                   KEY(pk), FOREIGN KEY(fk) REFERENCES self(pk));
CREATE TABLE self (pk POINT SRID 0 NOT NULL, fk POINT SRID 0 NOT NULL, KEY(pk));
ALTER TABLE self ADD FOREIGN KEY(fk) REFERENCES self(pk);
DROP TABLES self, child, parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT, FOREIGN KEY(fk) REFERENCES parent(pk));
ALTER TABLE child DROP KEY fk;
CREATE TABLE self (pk INT PRIMARY KEY, fk INT, FOREIGN KEY(fk) REFERENCES self(pk));
ALTER TABLE self DROP KEY fk;
ALTER TABLE child ADD KEY fk_s(fk);
ALTER TABLE self ADD KEY fk_s(fk);
ALTER TABLE child DROP KEY fk_s, ADD COLUMN j INT, ADD KEY (fk, j);
ALTER TABLE self DROP KEY fk_s, ADD COLUMN j INT, ADD KEY(fk, j);
DROP TABLES self, child, parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (pk INT PRIMARY KEY, fk INT, FOREIGN KEY (fk) REFERENCES parent(pk))
  PARTITION BY KEY (pk) PARTITIONS 20;

CREATE TABLE child (pk INT PRIMARY KEY, fk INT) PARTITION BY KEY (pk) PARTITIONS 20;
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES parent(pk);
DROP TABLE child;

CREATE TABLE child (pk INT PRIMARY KEY, fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
ALTER TABLE child PARTITION BY KEY (pk) PARTITIONS 20;
ALTER TABLE parent PARTITION BY KEY (pk) PARTITIONS 20;
DROP TABLES child, parent;

CREATE TABLE parent (pk INT PRIMARY KEY) PARTITION BY KEY (pk) PARTITIONS 20;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));

CREATE TABLE child (fk INT);
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES parent(pk);
DROP TABLES child, parent;
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE orphan (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE parent (pk INT PRIMARY KEY) PARTITION BY KEY (pk) PARTITIONS 20;

CREATE TABLE parent0 (pk INT PRIMARY KEY) PARTITION BY KEY (pk) PARTITIONS 20;
ALTER TABLE parent0 RENAME TO parent;
ALTER TABLE parent0 RENAME TO parent, ADD COLUMN j INT, ALGORITHM=COPY;
ALTER TABLE parent0 RENAME TO parent, ADD COLUMN j INT, ALGORITHM=INPLACE;
DROP TABLES orphan, parent0;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (pk INT PRIMARY KEY, fk INT,
                    CONSTRAINT c FOREIGN KEY (fk) REFERENCES parent(pk));
ALTER TABLE child DROP FOREIGN KEY c PARTITION BY KEY (pk) PARTITIONS 20;
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES parent(pk) REMOVE PARTITIONING;
DROP TABLES child, parent;
CREATE TABLE self (pk INT PRIMARY KEY, fk INT,
                   CONSTRAINT c FOREIGN KEY (fk) REFERENCES self(pk));
ALTER TABLE self DROP FOREIGN KEY c PARTITION BY KEY (pk) PARTITIONS 20;
ALTER TABLE self ADD FOREIGN KEY (fk) REFERENCES self(pk) REMOVE PARTITIONING;
DROP TABLES self;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT NOT NULL, CONSTRAINT c FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE SET NULL);
CREATE TABLE child (fk INT NOT NULL, CONSTRAINT c FOREIGN KEY (fk) REFERENCES parent(pk) ON UPDATE SET NULL);
CREATE TABLE child (fk INT NOT NULL);
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE SET NULL;
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES parent(pk) ON UPDATE SET NULL;
DROP TABLE child;
CREATE TABLE child (fk INT, PRIMARY KEY(fk), CONSTRAINT c FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE SET NULL);
CREATE TABLE child (fk INT, PRIMARY KEY(fk), CONSTRAINT c FOREIGN KEY (fk) REFERENCES parent(pk) ON UPDATE SET NULL);
CREATE TABLE child (fk INT);
ALTER TABLE child ADD PRIMARY KEY (fk), ADD FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE SET NULL;
ALTER TABLE child ADD PRIMARY KEY (fk), ADD FOREIGN KEY (fk) REFERENCES parent(pk) ON UPDATE SET NULL;
DROP TABLE child;
CREATE TABLE child_one (fk INT, CONSTRAINT c FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE SET NULL);
CREATE TABLE child_two (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE SET NULL);
ALTER TABLE child_one MODIFY COLUMN fk INT NOT NULL;
ALTER TABLE child_two CHANGE COLUMN fk fk1 INT NOT NULL;
ALTER TABLE child_one ADD PRIMARY KEY(fk);
ALTER TABLE child_two ADD PRIMARY KEY(fk);
DROP TABLES child_one, child_two, parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk CHAR(10), FOREIGN KEY (fk) REFERENCES parent(pk));
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE child (fk CHAR(10), FOREIGN KEY (fk) REFERENCES parent(pk));
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE child (fk CHAR(10));
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES parent(pk);
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES parent(pk);

SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE self (pk INT PRIMARY KEY, fk CHAR(10), FOREIGN KEY (fk) REFERENCES self(pk));
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE self (pk INT PRIMARY KEY, fk CHAR(10), FOREIGN KEY (fk) REFERENCES self(pk));
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE self (pk INT PRIMARY KEY, fk CHAR(10));
ALTER TABLE self ADD FOREIGN KEY (fk) REFERENCES self(pk);
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE self ADD FOREIGN KEY (fk) REFERENCES self(pk);
SET FOREIGN_KEY_CHECKS=1;
DROP TABLES self, child;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
ALTER TABLE child MODIFY fk CHAR(10);
ALTER TABLE parent MODIFY pk CHAR(10);
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE child MODIFY fk CHAR(10);
ALTER TABLE parent MODIFY pk CHAR(10);
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE self (pk INT PRIMARY KEY, fk INT, FOREIGN KEY (fk) REFERENCES self(pk));
ALTER TABLE self MODIFY fk CHAR(10);
ALTER TABLE self MODIFY pk CHAR(10);
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE self MODIFY fk CHAR(10);
ALTER TABLE self MODIFY pk CHAR(10);
SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE self MODIFY pk CHAR(10), MODIFY fk CHAR(10);
SET FOREIGN_KEY_CHECKS=1;
DROP TABLES child, parent, self;
CREATE TABLE parent (pk1 INT, pk2 INT, PRIMARY KEY (pk1, pk2));
CREATE TABLE child (fk1 INT, fk2 CHAR(10), FOREIGN KEY (fk1, fk2) REFERENCES parent(pk1, pk2));
CREATE TABLE child (fk1 INT, fk2 CHAR(10));
ALTER TABLE child ADD FOREIGN KEY (fk1, fk2) REFERENCES parent(pk1, pk2);
DROP TABLE child;

CREATE TABLE child (fk1 INT, fk2 INT, FOREIGN KEY (fk1, fk2) REFERENCES parent(pk1, pk2));
ALTER TABLE child MODIFY fk2 CHAR(10);
ALTER TABLE parent MODIFY pk2 CHAR(10);
DROP TABLE child, parent;
CREATE TABLE self (pk1 INT, pk2 INT, fk1 INT, fk2 CHAR(10), PRIMARY KEY (pk1, pk2),
                   FOREIGN KEY (fk1, fk2) REFERENCES self(pk1, pk2));
CREATE TABLE self (pk1 INT, pk2 INT, fk1 INT, fk2 CHAR(10), PRIMARY KEY (pk1, pk2));
ALTER TABLE self ADD FOREIGN KEY (fk1, fk2) REFERENCES self(pk1, pk2);
DROP TABLE self;

CREATE TABLE self (pk1 INT, pk2 INT, fk1 INT, fk2 INT, PRIMARY KEY (pk1, pk2),
                   FOREIGN KEY (fk1, fk2) REFERENCES self(pk1, pk2));
ALTER TABLE self MODIFY fk2 CHAR(10);
ALTER TABLE self MODIFY pk2 CHAR(10);
DROP TABLE self;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE child;
CREATE TABLE child (fk TINYINT, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk BIGINT, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk INT UNSIGNED, FOREIGN KEY (fk) REFERENCES parent(pk));
ALTER TABLE parent MODIFY pk INT UNSIGNED;
CREATE TABLE child (fk INT UNSIGNED, FOREIGN KEY (fk) REFERENCES parent(pk));
ALTER TABLE child MODIFY fk INT;
DROP TABLE child, parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk BINARY(4), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk VARBINARY(3), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk FLOAT, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk DECIMAL(8,0), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk TIMESTAMP, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk BIT(32), FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE parent;
CREATE TABLE parent (pk DOUBLE PRIMARY KEY);
CREATE TABLE child (fk DOUBLE, FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE child;
CREATE TABLE child (fk FLOAT, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk DOUBLE UNSIGNED, FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLES child, parent;
CREATE TABLE parent (pk FLOAT PRIMARY KEY);
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk BINARY(4), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk VARBINARY(3), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk DECIMAL(8,0), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk TIMESTAMP, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk TIME(2), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk BIT(32), FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE parent;
CREATE TABLE parent (pk DECIMAL(6,2) PRIMARY KEY);
CREATE TABLE child (fk DECIMAL(6,2), FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE child;
CREATE TABLE child (fk DECIMAL(6,2) UNSIGNED, FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE child;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk CHAR(4) CHARACTER SET latin1, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk VARCHAR(3) CHARACTER SET latin1, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk FLOAT, FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE parent;
CREATE TABLE parent (pk CHAR(10) PRIMARY KEY);
CREATE TABLE child (fk CHAR(100), FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE child;
CREATE TABLE child (fk VARCHAR(100), FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLES child, parent;
CREATE TABLE parent (pk VARCHAR(10) PRIMARY KEY);
CREATE TABLE child (fk VARCHAR(100), FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE child, parent;
CREATE TABLE parent (pk VARCHAR(10) CHARACTER SET utf8mb4 PRIMARY KEY);
CREATE TABLE child (fk VARCHAR(100) CHARACTER SET latin1, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk VARCHAR(100) COLLATE utf8mb4_bin, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk VARBINARY(40), FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE parent;
CREATE TABLE parent (pk VARBINARY(10) PRIMARY KEY);
CREATE TABLE child (fk BINARY(100), FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLES child, parent;
CREATE TABLE parent (pk CHAR(4) CHARACTER SET latin1 PRIMARY KEY);
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk FLOAT, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk DECIMAL(8,0), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk TIMESTAMP, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk TIME(2), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk BIT(32), FOREIGN KEY (fk) REFERENCES parent(pk));
ALTER TABLE parent MODIFY pk CHAR(1) CHARACTER SET latin1;
CREATE TABLE child (fk YEAR, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk ENUM('a') CHARACTER SET latin1, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk SET('a') CHARACTER SET latin1, FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE parent;
CREATE TABLE parent (pk BINARY(4) PRIMARY KEY);
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk FLOAT, FOREIGN KEY (fk) REFERENCES parent(pk));
ALTER TABLE parent MODIFY pk BINARY(1);
CREATE TABLE child (fk YEAR, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk ENUM('a') CHARACTER SET binary, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk SET('a') CHARACTER SET binary, FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE parent;
CREATE TABLE parent(pk DATE PRIMARY KEY);
CREATE TABLE child (fk DATE, FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE child;
CREATE TABLE child (fk YEAR, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk BINARY(3), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk VARBINARY(2), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk FLOAT, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk DECIMAL(6,0), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk TIME(0), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk TIMESTAMP, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk BIT(24), FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE parent;
CREATE TABLE parent (pk TIMESTAMP PRIMARY KEY);
CREATE TABLE child (fk TIMESTAMP, FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE child;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk CHAR(4) CHARACTER SET latin1, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk VARCHAR(3) CHARACTER SET latin1, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk FLOAT, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk DATE, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk ENUM('a'), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk SET('a'), FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE parent;
CREATE TABLE parent(pk ENUM('a') PRIMARY KEY);
CREATE TABLE child (fk ENUM('b','c'), FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE child;
CREATE TABLE child (fk DATE, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk BINARY(1), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk VARBINARY(1), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk FLOAT, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk DECIMAL(2,0), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk TIME, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk TIMESTAMP, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk BIT(8), FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE parent;
CREATE TABLE parent(pk SET('a') PRIMARY KEY);
CREATE TABLE child (fk SET('b','c'), FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE child;
CREATE TABLE child (fk SET('a1','a2','a3','a4','a5','a6','a7','a8','a9'), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk DATE, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk BINARY(1), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk VARBINARY(1), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk FLOAT, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk DECIMAL(2,0), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk TIME, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk TIMESTAMP, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk BIT(8), FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE parent;
CREATE TABLE parent(pk BIT(32) PRIMARY KEY);
CREATE TABLE child (fk BIT(10), FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE child;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk DATE, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk CHAR(4) CHARACTER SET latin1, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk VARCHAR(3) CHARACTER SET latin1, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk FLOAT, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk ENUM('a'), FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk SET('a'), FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE parent;
CREATE TABLE parent (pk VARCHAR(10) CHARACTER SET latin1 PRIMARY KEY);
CREATE TABLE child (fk VARCHAR(20) CHARACTER SET latin1,
                    FOREIGN KEY (fk) REFERENCES parent(pk));
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE parent MODIFY pk VARCHAR(10) CHARACTER SET utf8mb4;
ALTER TABLE child MODIFY fk VARCHAR(20) CHARACTER SET utf8mb4;
ALTER TABLE child MODIFY fk VARCHAR(20) CHARACTER SET latin1;
ALTER TABLE parent MODIFY pk VARCHAR(10) CHARACTER SET latin1;
DROP TABLE child;
CREATE TABLE child (fk VARCHAR(20) CHARACTER SET utf8mb4,
                    FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE child (fk VARCHAR(20) CHARACTER SET utf8mb4);
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES parent(pk);
DROP TABLE child, parent;
CREATE TABLE child (fk VARCHAR(20) CHARACTER SET latin1,
                    FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE parent (pk VARCHAR(10) CHARACTER SET utf8mb4 PRIMARY KEY);
CREATE TABLE parent0 (pk VARCHAR(10) CHARACTER SET utf8mb4 PRIMARY KEY);
DROP TABLES child, parent0;
CREATE TABLE parent (pk VARCHAR(10) CHARACTER SET binary PRIMARY KEY);
CREATE TABLE child (fk VARCHAR(20) CHARACTER SET binary,
                    FOREIGN KEY (fk) REFERENCES parent(pk));
ALTER TABLE parent MODIFY pk VARCHAR(10) CHARACTER SET utf8mb4;
ALTER TABLE child MODIFY fk VARCHAR(20) CHARACTER SET utf8mb4;
SET FOREIGN_KEY_CHECKS=1;
DROP TABLES child, parent;
CREATE DATABASE wl8910db;
USE wl8910db;
CREATE TABLE t1(fld1 INT PRIMARY KEY, fld2 INT) ENGINE=INNODB;
CREATE TABLE t2(fld1 INT PRIMARY KEY, fld2 INT, CONSTRAINT fk2
FOREIGN KEY (fld1) REFERENCES t1 (fld1)) ENGINE=InnoDB;
CREATE TABLE t3(fld1 INT PRIMARY KEY, fld2 INT) ENGINE=InnoDB;
CREATE PROCEDURE p1() SQL SECURITY INVOKER INSERT INTO t2 (fld1, fld2) VALUES (1, 2);
CREATE PROCEDURE p2() SQL SECURITY DEFINER INSERT INTO t2 (fld1, fld2) VALUES (1, 2);
CREATE FUNCTION f1() RETURNS INT SQL SECURITY INVOKER
BEGIN
  INSERT INTO t2 (fld1, fld2) VALUES (1, 2);

CREATE FUNCTION f2() RETURNS INT SQL SECURITY DEFINER
BEGIN
  INSERT INTO t2 (fld1, fld2) VALUES (1, 2);
CREATE SQL SECURITY INVOKER VIEW v1 AS SELECT * FROM t2;
CREATE SQL SECURITY DEFINER VIEW v2 AS SELECT * FROM t2;
CREATE USER user1@localhost;
CREATE USER user2@localhost;
CREATE USER user3@localhost;
INSERT INTO t2 (fld1, fld2) VALUES (1, 2);
INSERT IGNORE INTO t2 (fld1, fld2) VALUES (1, 2);
INSERT INTO t2 (fld1, fld2) VALUES (1, 2);
ALTER TABLE t2 ADD CONSTRAINT fk3 FOREIGN KEY (fld2) REFERENCES t3(fld1);
INSERT INTO t2 (fld1, fld2) VALUES (1, 2);
INSERT IGNORE INTO t2 (fld1, fld2) VALUES (1, 2);
INSERT INTO t2 (fld1, fld2) VALUES (1, 2);
SELECT f1();
SELECT f2();
INSERT INTO v1 VALUES (1, 2);
INSERT INTO v2 VALUES (1, 2);
INSERT INTO v2 VALUES (1, 2);

CREATE DEFINER=root@localhost PROCEDURE p3() SQL SECURITY DEFINER
INSERT INTO t2 (fld1, fld2) VALUES (1, 2);
CREATE DEFINER=root@localhost FUNCTION f3() RETURNS
INT SQL SECURITY DEFINER
BEGIN
  INSERT INTO t2 (fld1, fld2) VALUES (1, 2);

CREATE DEFINER=root@localhost SQL SECURITY DEFINER VIEW v3 AS
SELECT * FROM t2;
SELECT f3();
INSERT INTO v3 VALUES(4, 5);
DROP VIEW v1, v2, v3;
DROP TABLE t2, t3, t1;
DROP USER user1@localhost;
DROP USER user2@localhost;
DROP USER user3@localhost;
DROP PROCEDURE p1;
DROP PROCEDURE p2;
DROP PROCEDURE p3;
DROP FUNCTION f1;
DROP FUNCTION f2;
DROP FUNCTION f3;
DROP DATABASE wl8910db;

CREATE TABLE t1 (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE t2 (
  t1_id INT NOT NULL,
  CONSTRAINT t2_fk FOREIGN KEY (t1_id)
  REFERENCES t1(id) ON UPDATE RESTRICT
);

CREATE TABLE t3 (
  t1_id INT NOT NULL,
  CONSTRAINT t3_fk FOREIGN KEY (t1_id)
  REFERENCES t1(id) ON DELETE RESTRICT
);

CREATE TABLE t4 (
  t1_id INT NOT NULL,
  CONSTRAINT t4_fk FOREIGN KEY (t1_id)
  REFERENCES t1(id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

SELECT *  FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE
TABLE_NAME IN ('t1', 't2', 't3', 't4');

DROP TABLE t1, t2, t3, t4;

SELECT *  FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE
TABLE_NAME IN ('t1', 't2', 't3', 't4');

DROP TABLE t1, t2, t3, t4;
CREATE TABLE parent (Pk VARCHAR(10) PRIMARY KEY);
CREATE TABLE child (Fk VARCHAR(10), FOREIGN KEY (fK) REFERENCES parent(pK));
SELECT column_name, referenced_column_name FROM information_schema.key_column_usage
  WHERE referenced_table_schema='test' AND referenced_table_name='parent';
DROP TABLE child;
CREATE TABLE child (Fk VARCHAR(10));
ALTER TABLE child ADD FOREIGN KEY (fK) REFERENCES parent(pK);
SELECT column_name, referenced_column_name FROM information_schema.key_column_usage
  WHERE referenced_table_schema='test' AND referenced_table_name='parent';
CREATE TABLE self (Pk VARCHAR(10) PRIMARY KEY, Fk VARCHAR(10),
                   FOREIGN KEY (fK) REFERENCES self(pK));
SELECT column_name, referenced_column_name FROM information_schema.key_column_usage
  WHERE referenced_table_schema='test' AND referenced_table_name='self';
DROP TABLE self;
CREATE TABLE self (Pk VARCHAR(10) PRIMARY KEY, Fk VARCHAR(10));
ALTER TABLE self ADD FOREIGN KEY (fK) REFERENCES self(pK);
SELECT column_name, referenced_column_name FROM information_schema.key_column_usage
  WHERE referenced_table_schema='test' AND referenced_table_name='self';
ALTER TABLE parent CHANGE COLUMN Pk PK VARCHAR(20);
SELECT column_name, referenced_column_name FROM information_schema.key_column_usage
  WHERE referenced_table_schema='test' AND referenced_table_name='parent';
ALTER TABLE child CHANGE COLUMN Fk FK VARCHAR(20);
SELECT column_name, referenced_column_name FROM information_schema.key_column_usage
  WHERE referenced_table_schema='test' AND referenced_table_name='parent';
ALTER TABLE self CHANGE COLUMN Pk PK VARCHAR(20);
SELECT column_name, referenced_column_name FROM information_schema.key_column_usage
  WHERE referenced_table_schema='test' AND referenced_table_name='self';
ALTER TABLE self CHANGE COLUMN Fk FK VARCHAR(20);
SELECT column_name, referenced_column_name FROM information_schema.key_column_usage
  WHERE referenced_table_schema='test' AND referenced_table_name='self';
DROP TABLE self;
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE parent;
SELECT column_name, referenced_column_name FROM information_schema.key_column_usage
  WHERE referenced_table_schema='test' AND referenced_table_name='parent';
CREATE TABLE parent (pk VARCHAR(10) PRIMARY KEY);
SELECT column_name, referenced_column_name FROM information_schema.key_column_usage
  WHERE referenced_table_schema='test' AND referenced_table_name='parent';
DROP TABLES child, parent;
CREATE TABLE child (Fk VARCHAR(10), FOREIGN KEY (fK) REFERENCES parent(pK));
SELECT column_name, referenced_column_name FROM information_schema.key_column_usage
  WHERE referenced_table_schema='test' AND referenced_table_name='parent';
DROP TABLE child;
CREATE TABLE child (Fk VARCHAR(10));
ALTER TABLE child ADD FOREIGN KEY (fK) REFERENCES parent(pK);
SELECT column_name, referenced_column_name FROM information_schema.key_column_usage
  WHERE referenced_table_schema='test' AND referenced_table_name='parent';
CREATE TABLE parent (pk VARCHAR(10) PRIMARY KEY);
SELECT column_name, referenced_column_name FROM information_schema.key_column_usage
  WHERE referenced_table_schema='test' AND referenced_table_name='parent';
SET FOREIGN_KEY_CHECKS=1;
DROP TABLES child, parent;
CREATE TABLE t1 (id INT PRIMARY KEY);
CREATE TABLE t2 (t1id INT, FOREIGN KEY fk_index (t1id) REFERENCES t1 (id));
CREATE TABLE t3 (t1id INT, FOREIGN KEY fk_index (t1id) REFERENCES t1 (id));
SELECT CONSTRAINT_NAME, TABLE_NAME
  FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
  WHERE TABLE_NAME IN ('t2', 't3') ORDER BY CONSTRAINT_NAME;
CREATE TABLE t4 (fk1 INT, fk2 INT, fk3 INT, fk4 INT,
                 FOREIGN KEY (fk1) REFERENCES t1 (id),
                 CONSTRAINT c FOREIGN KEY (fk2) REFERENCES t1 (id),
                 FOREIGN KEY d (fk3) REFERENCES t1 (id),
                 CONSTRAINT e FOREIGN KEY f (fk4) REFERENCES t1 (id));
SELECT CONSTRAINT_NAME FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
  WHERE TABLE_NAME = 't4' ORDER BY CONSTRAINT_NAME;
DROP TABLES t1, t2, t3, t4;
CREATE TABLE parent (pk INT PRIMARY KEY);
INSERT INTO parent VALUES (1);
CREATE TABLE child (fk INT, b INT, FOREIGN KEY (fk) REFERENCES parent (pk));
INSERT INTO child VALUES (1, 1);
ALTER TABLE child MODIFY COLUMN b BIGINT, RENAME TO child_renamed, ALGORITHM=COPY;
DELETE FROM parent WHERE pk = 1;
DROP TABLE child_renamed;
CREATE TABLE child (fk INT, b INT, FOREIGN KEY (fk) REFERENCES parent (pk));
DROP TABLES child, parent;
CREATE TABLE parent (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, c CHAR(32));
CREATE TABLE uncle (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, c CHAR(32));
CREATE TABLE child (parent_id INT, c CHAR(32), FOREIGN KEY (parent_id) REFERENCES parent (id));
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE child ADD COLUMN uncle_id INT, DROP COLUMN c, ADD CONSTRAINT FOREIGN KEY (uncle_id) REFERENCES uncle (id), ALGORITHM=INPLACE;
SET FOREIGN_KEY_CHECKS=1;
DROP TABLES child, parent, uncle;
CREATE TABLE parent (pk INT PRIMARY KEY, a INT, b INT, KEY(a), UNIQUE(b));
CREATE TABLE child1 (fk1 INT, fk2 INT, FOREIGN KEY (fk1, fk2) REFERENCES parent (a, pk));
CREATE TABLE child2 (fk1 INT, fk2 INT, FOREIGN KEY (fk1, fk2) REFERENCES parent (b, pk));
DROP TABLES child1, child2;
CREATE TABLE child1 (fk1 INT, fk2 INT);
ALTER TABLE child1 ADD FOREIGN KEY (fk1, fk2) REFERENCES parent (a, pk);
CREATE TABLE child2 (fk1 INT, fk2 INT);
ALTER TABLE child2 ADD FOREIGN KEY (fk1, fk2) REFERENCES parent (b, pk);
DROP TABLES child1, child2, parent;
CREATE TABLE parent (a INT, b INT, c INT, PRIMARY KEY (a,b), KEY(c, a));
CREATE TABLE child (fk1 INT, fk2 INT, fk3 INT, FOREIGN KEY (fk1, fk2, fk3) REFERENCES parent (c, a, b));
DROP TABLES child, parent;
CREATE TABLE parent (u INT NOT NULL, a INT, b INT, UNIQUE(u), KEY(a), UNIQUE(b));
CREATE TABLE child1 (fk1 INT, fk2 INT, FOREIGN KEY (fk1, fk2) REFERENCES parent (a, u));
CREATE TABLE child2 (fk1 INT, fk2 INT, FOREIGN KEY (fk1, fk2) REFERENCES parent (b, u));
DROP TABLES child1, child2, parent;
CREATE TABLE parent (pk INT PRIMARY KEY, a INT, KEY k1(a, pk), UNIQUE k2(a));
CREATE TABLE child (fk1 INT, fk2 INT, FOREIGN KEY (fk1, fk2) REFERENCES parent (a, pk));
ALTER TABLE parent DROP KEY k1;
DROP TABLES child, parent;
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE child (fk1 INT, fk2 INT, CONSTRAINT c FOREIGN KEY (fk1, fk2) REFERENCES parent (a, pk));
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE parent (pk INT PRIMARY KEY, a INT, UNIQUE ua(a));
SELECT constraint_name, unique_constraint_name FROM information_schema.referential_constraints
  WHERE constraint_schema='test' AND constraint_name='c';
DROP TABLES child, parent;
CREATE TABLE parent (pk INT PRIMARY KEY, a INT);
CREATE TABLE child (fk1 INT, fk2 INT, FOREIGN KEY (fk1, fk2) REFERENCES parent (pk, a));
DROP TABLE parent;
CREATE TABLE parent (a CHAR(10), b int, KEY(b), PRIMARY KEY (a(5)));
CREATE TABLE child (fk1 int, fk2 CHAR(10), FOREIGN KEY (fk1, fk2) REFERENCES parent (b, a));
DROP TABLE parent;
CREATE TABLE parent (a INT, b CHAR(10), c int, KEY(c), PRIMARY KEY (a, b(5)));
CREATE TABLE child (fk1 int, fk2 int, FOREIGN KEY (fk1, fk2) REFERENCES parent (c, a));
DROP TABLE parent;
CREATE TABLE self1 (pk INT PRIMARY KEY, a INT, fk1 INT, fk2 INT,
                    KEY(a), FOREIGN KEY (fk1, fk2) REFERENCES self1 (a, pk));
CREATE TABLE self2 (pk INT PRIMARY KEY, b INT, fk1 INT, fk2 INT,
                    UNIQUE(b), FOREIGN KEY (fk1, fk2) REFERENCES self2 (b, pk));
DROP TABLES self1, self2;
CREATE TABLE self1 (pk INT PRIMARY KEY, a INT, fk1 INT, fk2 INT, KEY(a));
ALTER TABLE self1 ADD FOREIGN KEY (fk1, fk2) REFERENCES self1 (a, pk);
CREATE TABLE self2 (pk INT PRIMARY KEY, b INT, fk1 INT, fk2 INT, UNIQUE(b));
ALTER TABLE self2 ADD FOREIGN KEY (fk1, fk2) REFERENCES self2 (b, pk);
DROP TABLES self1, self2;
CREATE TABLE self (a INT, b INT, c INT, fk1 INT, fk2 INT, fk3 INT,
                  PRIMARY KEY (a,b), KEY(c, a),
                  FOREIGN KEY (fk1, fk2, fk3) REFERENCES self (c, a, b));
DROP TABLE self;
CREATE TABLE self (pk INT PRIMARY KEY, a INT, fk1 INT, fk2 INT,
                   KEY k1(a, pk), UNIQUE k2(a),
                   FOREIGN KEY (fk1, fk2) REFERENCES self (a, pk));
ALTER TABLE self DROP KEY k1;
DROP TABLE self;
CREATE TABLE self (pk INT PRIMARY KEY, a INT, fk1 INT, fk2 INT,
                   FOREIGN KEY (fk1, fk2) REFERENCES self (pk, a));
CREATE TABLE self (a CHAR(10), b int, fk1 int, fk2 CHAR(10), KEY(b),
                   PRIMARY KEY (a(5)), FOREIGN KEY (fk1, fk2) REFERENCES self (b, a));
CREATE TABLE self (a INT, b CHAR(10), c int, fk1 int, fk2 int, KEY(c),
                   PRIMARY KEY (a, b(5)), FOREIGN KEY (fk1, fk2) REFERENCES self (c, a));
CREATE TABLE t1(pk INT PRIMARY KEY);
CREATE TABLE t2(pk INT PRIMARY KEY);
CREATE TABLE t3(fk1 INT, fk2 INT, KEY k1(fk1),
                CONSTRAINT a FOREIGN KEY (fk1) REFERENCES t1(pk),
                CONSTRAINT b FOREIGN KEY (fk2) REFERENCES t2(pk));
ALTER TABLE t3 DROP KEY k1, DROP FOREIGN KEY b, ALGORITHM=COPY;
DROP TABLES t3, t2, t1;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT, a INT);
ALTER TABLE child RENAME COLUMN fk TO fkold, RENAME COLUMN a TO fk;
DROP TABLES child, parent;

CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk1 INT, b INT, CONSTRAINT c FOREIGN KEY (fk1) REFERENCES parent (pk));
CREATE TABLE unrelated (a INT);
ALTER TABLE child DROP FOREIGN KEY no_such_fk;
ALTER TABLE child DROP FOREIGN KEY no_such_fk, ALGORITHM=INPLACE;
ALTER TABLE child DROP FOREIGN KEY no_such_fk, ALGORITHM=COPY;
ALTER TABLE unrelated DROP FOREIGN KEY c;
ALTER TABLE unrelated DROP FOREIGN KEY c, ALGORITHM=INPLACE;
ALTER TABLE unrelated DROP FOREIGN KEY c, ALGORITHM=COPY;
ALTER TABLE parent DROP FOREIGN KEY c;
ALTER TABLE parent DROP FOREIGN KEY c, ALGORITHM=INPLACE;
ALTER TABLE parent DROP FOREIGN KEY c, ALGORITHM=COPY;
DROP TABLES unrelated, child, parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk1 INT, fk2 INT, a INT, KEY(fk1), KEY(fk2));
INSERT INTO child VALUES (NULL, NULL, 1), (NULL, NULL, 1);
ALTER TABLE child ADD CONSTRAINT f FOREIGN KEY (fk1) REFERENCES parent (pk),
                  ADD CONSTRAINT f FOREIGN KEY (fk2) REFERENCES parent (pk),
                  ADD UNIQUE (a);
ALTER TABLE child ADD CONSTRAINT f FOREIGN KEY (fk1) REFERENCES parent (pk),
                  ADD CONSTRAINT f FOREIGN KEY (fk2) REFERENCES parent (pk),
                  ADD UNIQUE (a), ALGORITHM=COPY;
ALTER TABLE child ADD CONSTRAINT f FOREIGN KEY (fk1) REFERENCES parent (pk),
                  ADD CONSTRAINT f FOREIGN KEY (fk2) REFERENCES parent (pk),
                  ADD UNIQUE (a), ALGORITHM=INPLACE;
ALTER TABLE child ADD CONSTRAINT f FOREIGN KEY (fk1) REFERENCES parent (pk);
ALTER TABLE child ADD CONSTRAINT F FOREIGN KEY (fk2) REFERENCES parent (pk),
                  ADD UNIQUE (a);
ALTER TABLE child ADD CONSTRAINT F FOREIGN KEY (fk2) REFERENCES parent (pk),
                  ADD UNIQUE (a), ALGORITHM=COPY;
ALTER TABLE child ADD CONSTRAINT F FOREIGN KEY (fk2) REFERENCES parent (pk),
                  ADD UNIQUE (a), ALGORITHM=INPLACE;
DROP TABLES child, parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES test . parent (pk));
DROP TABLE child;
CREATE TABLE child (fk INT);
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES test . parent (pk);
DROP TABLES child, parent;
CREATE DATABASE aux;
CREATE TABLE aux.parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES aux.parent (pk));
DROP TABLE child;
DROP DATABASE aux;
CREATE TABLE parent (id INT PRIMARY KEY);
CREATE TABLE child (fk INT, CONSTRAINT c1 FOREIGN KEY (fk) REFERENCES parent (id) /*!40008 ON DELETE CASCADE ON UPDATE CASCADE */);
ALTER TABLE child DROP FOREIGN KEY c1;
ALTER TABLE child ADD CONSTRAINT c2 FOREIGN KEY (fk) REFERENCES parent /*! (id) */ /*!40008 ON DELETE SET NULL */;
DROP TABLES child, parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
DROP TABLE child;
CREATE TABLE child (fk INT);
/*! ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES parent(pk) */;
DROP TABLES child, parent;
CREATE TABLE t (a INT KEY, b INT NOT NULL UNIQUE KEY,
                CONSTRAINT FOREIGN KEY (a) REFERENCES t(b));
ALTER TABLE t ADD COLUMN a INT GENERATED ALWAYS AS (1) FIRST;
ALTER TABLE t ADD COLUMN b INT GENERATED ALWAYS AS (1) FIRST;
DROP TABLE t;

SET SESSION FOREIGN_KEY_CHECKS=0;
CREATE TABLE t1 (f1 INT PRIMARY KEY, f2 INT, FOREIGN KEY(f2) REFERENCES t2(f1));
ALTER TABLE t1 RENAME TO t2, ALGORITHM=INPLACE;
SELECT constraint_name, unique_constraint_name FROM
       INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE table_name='t2';
DROP TABLE t2;
CREATE TABLE t1 (f1 INT PRIMARY KEY, f2 INT, FOREIGN KEY(f2) REFERENCES t2(f1));
ALTER TABLE t1 RENAME TO t2, ALGORITHM=INSTANT;
SELECT constraint_name, unique_constraint_name FROM
       INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE table_name='t2';
DROP TABLE t2;
CREATE TABLE t1 (f1 INT PRIMARY KEY, f2 INT, FOREIGN KEY(f2) REFERENCES t2(f1));
ALTER TABLE t1 RENAME TO t2, ALGORITHM=COPY;
SELECT constraint_name, unique_constraint_name FROM
       INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE table_name='t2';
DROP TABLE t2;
CREATE TABLE t1 (f1 INT PRIMARY KEY, f2 INT, FOREIGN KEY(f2) REFERENCES t2(f1));
SELECT constraint_name, unique_constraint_name FROM
       INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE table_name='t2';
DROP TABLE t2;
CREATE DATABASE db1;
CREATE TABLE db1.t1 (f1 INT PRIMARY KEY, f2 INT, FOREIGN KEY(f2) REFERENCES t2(f3));
CREATE DATABASE db2;
ALTER TABLE db1.t1 RENAME TO db2.t2, ALGORITHM=COPY;

ALTER TABLE db1.t1 RENAME TO db2.t2, ALGORITHM=INPLACE;

ALTER TABLE db1.t1 RENAME TO db2.t2, ALGORITHM=INSTANT;
DROP DATABASE db1;
DROP DATABASE db2;
CREATE TABLE t1 (f1 INT PRIMARY KEY, f2 INT, FOREIGN KEY(f2) REFERENCES t2(f3));
ALTER TABLE t1 RENAME TO t2, ALGORITHM=COPY;
ALTER TABLE t1 RENAME TO t2, ALGORITHM=INPLACE;
ALTER TABLE t1 RENAME TO t2, ALGORITHM=INSTANT;
ALTER TABLE t1 ADD f3 INT UNIQUE;
ALTER TABLE t1 RENAME TO t2, DROP COLUMN f3, ALGORITHM=COPY;
ALTER TABLE t1 RENAME TO t2, DROP COLUMN f3, ALGORITHM=INPLACE;
ALTER TABLE t1 RENAME TO t2, DROP COLUMN f3, ALGORITHM=INSTANT;
DROP TABLE t1;
CREATE TABLE t1 (f1 INT PRIMARY KEY, f2 INT, f3 INT, KEY (f3),
                 FOREIGN KEY(f2) REFERENCES t2(f3));
ALTER TABLE t1 RENAME TO t2, CHANGE f3 f4 INT, ALGORITHM=COPY;
ALTER TABLE t1 RENAME TO t2, CHANGE f3 f4 INT, ALGORITHM=INSTANT;
ALTER TABLE t1 RENAME TO t2, CHANGE f3 f4 INT, ALGORITHM=INPLACE;
DROP TABLE t1;
CREATE TABLE t1 (f1 INT PRIMARY KEY, f2 INT, F3 INT AS (f1+1) VIRTUAL,
                 FOREIGN KEY(f2) REFERENCES t2(f3));
ALTER TABLE t1 RENAME TO t2, ALGORITHM=COPY;
ALTER TABLE t1 RENAME TO t2, ALGORITHM=INSTANT;
ALTER TABLE t1 RENAME TO t2, ALGORITHM=INPLACE;
DROP TABLE t1;
CREATE TABLE t1 (f1 INT PRIMARY KEY, f2 INT, f3 INT,
                 FOREIGN KEY(f2) REFERENCES t2(f3));
ALTER TABLE t1 RENAME TO t2, ALGORITHM=COPY;
ALTER TABLE t1 RENAME TO t2, ALGORITHM=INSTANT;
ALTER TABLE t1 RENAME TO t2, ALGORITHM=INPLACE;
DROP TABLE t1;
CREATE TABLE t1 (f1 INT PRIMARY KEY, f2 INT, f3 CHAR(10), KEY(f3),
                 FOREIGN KEY(f2) REFERENCES t2(f3));
ALTER TABLE t1 RENAME TO t2, ALGORITHM=COPY;
ALTER TABLE t1 RENAME TO t2, ALGORITHM=INSTANT;
ALTER TABLE t1 RENAME TO t2, ALGORITHM=INPLACE;
DROP TABLE t1;
SET FOREIGN_KEY_CHECKS = DEFAULT;
