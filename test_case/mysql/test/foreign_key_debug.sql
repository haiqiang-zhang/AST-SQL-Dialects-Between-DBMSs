--

--source include/have_debug.inc
--source include/have_debug_sync.inc
-- Some parts of the test require enabled binary log.
--source include/have_log_bin.inc

SET @saved_binlog_format= @@SESSION.binlog_format;

SET SESSION debug= '+d,skip_dd_table_access_check';
SET @@foreign_key_checks= DEFAULT;

CREATE TABLE t1(a INT PRIMARY KEY);
CREATE TABLE t2(a INT PRIMARY KEY);
CREATE TABLE t3(a INT PRIMARY KEY, b INT, c INT);

ALTER TABLE t3 ADD FOREIGN KEY (b) REFERENCES t1(a);
SELECT fk.name FROM mysql.foreign_keys AS fk, mysql.tables AS t
WHERE fk.table_id = t.id AND t.name = 't3';

ALTER TABLE t3 ADD FOREIGN KEY (c) REFERENCES t1(a);
SELECT fk.name FROM mysql.foreign_keys AS fk, mysql.tables AS t
WHERE fk.table_id = t.id AND t.name = 't3';

ALTER TABLE t3 ADD FOREIGN KEY (b) REFERENCES t1(a);
SELECT fk.name FROM mysql.foreign_keys AS fk, mysql.tables AS t
WHERE fk.table_id = t.id AND t.name = 't3';

ALTER TABLE t3 DROP FOREIGN KEY t3_ibfk_1;
SELECT fk.name FROM mysql.foreign_keys AS fk, mysql.tables AS t
WHERE fk.table_id = t.id AND t.name = 't3';

ALTER TABLE t3 ADD FOREIGN KEY (b) REFERENCES t1(a);
SELECT fk.name FROM mysql.foreign_keys AS fk, mysql.tables AS t
WHERE fk.table_id = t.id AND t.name = 't3';

DROP TABLE t3, t2, t1;

CREATE TABLE t1(a INT PRIMARY KEY);
CREATE TABLE name567890123456789012345678901234567890123456789012345678901234(a INT PRIMARY KEY, b INT);
ALTER TABLE name567890123456789012345678901234567890123456789012345678901234
ADD FOREIGN KEY(b) REFERENCES t1(a);

DROP TABLE name567890123456789012345678901234567890123456789012345678901234, t1;

CREATE TABLE parent(pk INTEGER PRIMARY KEY, j INTEGER,
  UNIQUE KEY my_key (j));
CREATE TABLE child(pk INTEGER PRIMARY KEY, fk INTEGER,
  FOREIGN KEY (fk) REFERENCES parent(j));
SELECT unique_constraint_name FROM mysql.foreign_keys
  WHERE referenced_table_name LIKE 'parent';

DROP TABLES child, parent;

SET @@foreign_key_checks= 0;
CREATE TABLE child(pk INTEGER PRIMARY KEY, fk INTEGER,
  FOREIGN KEY (fk) REFERENCES parent(j));
SELECT name FROM mysql.indexes
  WHERE table_id = (SELECT id from mysql.tables WHERE name LIKE 'child');
SELECT unique_constraint_name FROM mysql.foreign_keys
  WHERE referenced_table_name LIKE 'parent';

CREATE TABLE parent(pk INTEGER PRIMARY KEY, j INTEGER,
  UNIQUE KEY my_key (j));
SET @@foreign_key_checks= 1;
SELECT unique_constraint_name FROM mysql.foreign_keys
  WHERE referenced_table_name LIKE 'parent';

DROP TABLES child, parent;

CREATE TABLE parent(pk INTEGER PRIMARY KEY, j INTEGER,
  UNIQUE KEY my_key (j));
CREATE TABLE child(pk INTEGER PRIMARY KEY, fk INTEGER,
  FOREIGN KEY (fk) REFERENCES parent(j));
SELECT unique_constraint_name FROM mysql.foreign_keys
  WHERE referenced_table_name LIKE 'parent';

CREATE TABLE child_copy LIKE child;
SELECT name FROM mysql.indexes
  WHERE table_id = (SELECT id from mysql.tables WHERE name LIKE 'child');
SELECT name FROM mysql.indexes
  WHERE table_id = (SELECT id from mysql.tables WHERE name LIKE 'child_copy');
SELECT unique_constraint_name FROM mysql.foreign_keys
  WHERE referenced_table_name LIKE 'parent';

DROP TABLES child, child_copy, parent;

SET @@foreign_key_checks= 0;
CREATE TABLE child(pk INTEGER PRIMARY KEY, fk INTEGER,
  FOREIGN KEY (fk) REFERENCES parent(j));
SELECT name FROM mysql.indexes
  WHERE table_id = (SELECT id from mysql.tables WHERE name LIKE 'parent');
SELECT unique_constraint_name FROM mysql.foreign_keys
  WHERE referenced_table_name LIKE 'parent';

CREATE TABLE parent_base(pk INTEGER PRIMARY KEY, j INTEGER,
  UNIQUE KEY my_key (j));
CREATE TABLE parent LIKE parent_base;
SET @@foreign_key_checks= 1;
SELECT unique_constraint_name FROM mysql.foreign_keys
  WHERE referenced_table_name LIKE 'parent';

DROP TABLE child, parent_base, parent;

CREATE TABLE source(pk INTEGER PRIMARY KEY, j INTEGER);
INSERT INTO source VALUES (1, 1);

CREATE TABLE parent(pk INTEGER PRIMARY KEY, j INTEGER,
  UNIQUE KEY my_key(j));
INSERT INTO parent VALUES (2, 1);

SET @@SESSION.binlog_format=STATEMENT;
CREATE TABLE child(pk INTEGER PRIMARY KEY, fk INTEGER,
  FOREIGN KEY (fk) REFERENCES parent(j)) AS SELECT pk, j AS fk FROM source;
SET SESSION binlog_format= @saved_binlog_format;
SELECT * FROM child;
SELECT name FROM mysql.indexes
  WHERE table_id = (SELECT id from mysql.tables WHERE name LIKE 'child');
SELECT unique_constraint_name FROM mysql.foreign_keys
  WHERE referenced_table_name LIKE 'parent';

DROP TABLES source, child, parent;

SET @@foreign_key_checks= 0;
CREATE TABLE source(pk INTEGER PRIMARY KEY, j INTEGER);
INSERT INTO source VALUES (1, 1);

CREATE TABLE child(pk INTEGER PRIMARY KEY, fk INTEGER,
  FOREIGN KEY (fk) REFERENCES parent(j));
SELECT name FROM mysql.indexes
  WHERE table_id = (SELECT id from mysql.tables WHERE name LIKE 'child');
SELECT unique_constraint_name FROM mysql.foreign_keys
  WHERE referenced_table_name LIKE 'parent';

SET @@SESSION.binlog_format=STATEMENT;
CREATE TABLE parent(pk INTEGER PRIMARY KEY, j INTEGER,
  UNIQUE KEY my_key(j)) AS SELECT * FROM source;
SET SESSION binlog_format= @saved_binlog_format;
SELECT * FROM child;
SET @@foreign_key_checks= 1;
SELECT unique_constraint_name FROM mysql.foreign_keys
  WHERE referenced_table_name LIKE 'parent';

DROP TABLES source, child, parent;

CREATE TABLE parent(pk INTEGER PRIMARY KEY, j INTEGER,
  UNIQUE KEY parent_key(j));

CREATE TABLE child(pk INTEGER PRIMARY KEY, k INTEGER, fk INTEGER,
  FOREIGN KEY (fk) REFERENCES parent(j), UNIQUE KEY child_key(k));
INSERT INTO child VALUES (1, 2, 3);

CREATE TABLE grandchild(pk INTEGER PRIMARY KEY, fk INTEGER,
  FOREIGN KEY (fk) REFERENCES child(k));
INSERT INTO grandchild VALUES (1, 2);

SET @@foreign_key_checks= 0;
CREATE TABLE orphan_grandchild(pk INTEGER PRIMARY KEY, fk INTEGER,
  FOREIGN KEY (fk) REFERENCES siebling(k));
SET @@foreign_key_checks= 1;
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
INSERT INTO siebling VALUES (1, 2, 3);
INSERT INTO grandchild VALUES (1, 2);
INSERT INTO orphan_grandchild VALUES (1, 2);

DROP TABLE grandchild;
DROP TABLE orphan_grandchild;
DROP TABLE siebling;
DROP TABLE parent;

CREATE TABLE parent(pk INTEGER PRIMARY KEY, j INTEGER,
  UNIQUE KEY parent_key(j));

CREATE TABLE child(pk INTEGER PRIMARY KEY, fk INTEGER,
  FOREIGN KEY (fk) REFERENCES parent(j) ON DELETE CASCADE);

SET @@foreign_key_checks= 0;
SELECT OBJECT_TYPE, OBJECT_SCHEMA, OBJECT_NAME, COLUMN_NAME,
  LOCK_TYPE FROM performance_schema.metadata_locks
  WHERE OBJECT_NAME LIKE 'child'
  ORDER BY OBJECT_TYPE, OBJECT_SCHEMA, OBJECT_NAME, COLUMN_NAME, LOCK_TYPE;
SET @@session.lock_wait_timeout= 1;
INSERT INTO child VALUES (1, 1);
SET @@foreign_key_checks= 1;
SELECT LOCK_TYPE FROM performance_schema.metadata_locks
  WHERE OBJECT_NAME LIKE 'child';

DROP TABLE child;
DROP TABLE parent;

CREATE TABLE parent(pk INTEGER PRIMARY KEY, j INTEGER,
  UNIQUE KEY parent_key(j));

CREATE TABLE child(pk INTEGER PRIMARY KEY, fk INTEGER,
  FOREIGN KEY (fk) REFERENCES parent(j) ON DELETE CASCADE);

SELECT COUNT_REPREPARE, COUNT_EXECUTE
  FROM performance_schema.prepared_statements_instances
  WHERE STATEMENT_NAME LIKE 'stmt';

SET @a= 1;
SELECT COUNT_REPREPARE, COUNT_EXECUTE
  FROM performance_schema.prepared_statements_instances
  WHERE STATEMENT_NAME LIKE 'stmt';
ALTER TABLE child ADD COLUMN (j INTEGER);
SELECT COUNT_REPREPARE, COUNT_EXECUTE
  FROM performance_schema.prepared_statements_instances
  WHERE STATEMENT_NAME LIKE 'stmt';
SELECT COUNT_REPREPARE, COUNT_EXECUTE
  FROM performance_schema.prepared_statements_instances
  WHERE STATEMENT_NAME LIKE 'stmt';

DROP TABLE child;
DROP TABLE parent;

CREATE TABLE parent(pk INTEGER PRIMARY KEY, i INTEGER, j INTEGER,
  UNIQUE KEY parent_i_key(i), UNIQUE KEY parent_j_key(j));

CREATE TABLE child(pk INTEGER PRIMARY KEY, fk_i INTEGER, fk_j INTEGER,
  FOREIGN KEY (fk_i) REFERENCES parent(i),
  FOREIGN KEY (fk_j) REFERENCES parent(j));

ALTER TABLE child RENAME TO siebling;

DROP TABLES siebling, parent;

CREATE TABLE parent(pk INTEGER PRIMARY KEY, i INTEGER,
  UNIQUE KEY parent_key(i));

CREATE TABLE child(pk INTEGER PRIMARY KEY, fk_i INTEGER,
  FOREIGN KEY (fk_i) REFERENCES parent(i));
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';

DROP TABLES child, parent;

SET @@foreign_key_checks= 0;
CREATE TABLE child(pk INTEGER PRIMARY KEY, fk_i INTEGER,
  FOREIGN KEY (fk_i) REFERENCES mother(i));
SET @@foreign_key_checks= 1;

CREATE TABLE parent(pk INTEGER PRIMARY KEY, i INTEGER,
  UNIQUE KEY parent_key(i));
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';

DROP TABLES child, father;

CREATE TABLE parent(pk INTEGER PRIMARY KEY, i INTEGER, j INTEGER,
  UNIQUE KEY parent_i_key(i),
  UNIQUE KEY parent_j_key(j));

CREATE TABLE child(pk INTEGER PRIMARY KEY, fk_i INTEGER, fk_j INTEGER,
  FOREIGN KEY (fk_i) REFERENCES parent(i),
  FOREIGN KEY (fk_j) REFERENCES parent(j));
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';

DROP TABLES child, mother;
CREATE TABLE self (pk INT PRIMARY KEY, fk INT, FOREIGN KEY(fk) REFERENCES self(pk));
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
ALTER TABLE self RENAME TO self2;
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
ALTER TABLE self2 RENAME TO self3, ADD COLUMN i INT;
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
DROP TABLE self3;

CREATE TABLE parent(pk INTEGER PRIMARY KEY, i INTEGER,
  UNIQUE KEY parent_i_key(i));

SET @@foreign_key_checks= 0;
CREATE TABLE grandchild(pk INTEGER PRIMARY KEY, fk_i INTEGER,
  FOREIGN KEY (fk_i) REFERENCES s1.child(i));
SET @@foreign_key_checks= 1;
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 's1';

CREATE SCHEMA s1;
CREATE TABLE s1.child(pk INTEGER PRIMARY KEY, i INTEGER, fk_i INTEGER,
  UNIQUE KEY child_i_key(i),
  FOREIGN KEY (fk_i) REFERENCES test.parent(i));
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 's1';
DROP SCHEMA s1;

SET @@foreign_key_checks= 0;
DROP SCHEMA s1;
SET @@foreign_key_checks= 1;
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 's1';
CREATE SCHEMA s1;
CREATE TABLE s1.child(pk INTEGER PRIMARY KEY, i INTEGER,
  UNIQUE KEY child_i_key(i));
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 's1';
DROP SCHEMA s1;

SET @@foreign_key_checks= 0;
DROP SCHEMA s1;
SET @@foreign_key_checks= 1;
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 's1';

DROP TABLE grandchild;
CREATE SCHEMA s1;
CREATE TABLE s1.child(pk INTEGER PRIMARY KEY, fk_i INTEGER);
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
ALTER TABLE s1.child ADD FOREIGN KEY (fk_i) REFERENCES test.parent(i);
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';

DROP SCHEMA s1;

DROP TABLE parent;

CREATE TABLE parent(pk INTEGER PRIMARY KEY, i INTEGER,
  UNIQUE KEY parent_key(i));

CREATE TABLE child(pk INTEGER PRIMARY KEY, fk_i INTEGER,
  FOREIGN KEY (fk_i) REFERENCES parent(i));
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';

SET @@session.debug= '+d,fail_while_invalidating_fk_parents';
ALTER TABLE child RENAME TO siebling;
SET @@session.debug= '-d,fail_while_invalidating_fk_parents';
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';

DROP TABLE siebling, parent;
CREATE TABLE parent (i INT, j INT, PRIMARY KEY (i), UNIQUE u(i,j));
CREATE TABLE child (i INT, j INT, FOREIGN KEY (i, j) REFERENCES parent (i, j));
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
ALTER TABLE parent RENAME KEY u TO u1;
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
DROP TABLE child, parent;

CREATE TABLE parent (i INT, j INT, k INT, PRIMARY KEY (i), UNIQUE u(j), UNIQUE u1(i,j), UNIQUE u2(i,j,k));
CREATE TABLE child (i INT, j INT, k INT, FOREIGN KEY (i, j, k) REFERENCES parent (i, j, k));
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
ALTER TABLE parent RENAME KEY u2 TO u3;
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
DROP TABLE child, parent;

CREATE TABLE parent (i INT, j INT,
                     d INT GENERATED ALWAYS AS (i) VIRTUAL,
                     e INT GENERATED ALWAYS AS (j) VIRTUAL,
                     PRIMARY KEY (i), UNIQUE u(i,d), UNIQUE u1(i,j,e));
CREATE TABLE child (i INT, j INT, FOREIGN KEY (i, j) REFERENCES parent (i, j));
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
ALTER TABLE parent RENAME KEY u1 TO u2;
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
DROP TABLE child, parent;

CREATE TABLE parent (i INT, a VARCHAR(10), b VARCHAR(10),
                     PRIMARY KEY (i), UNIQUE u(i,a(5)), UNIQUE u1(i,a,b(5)));
CREATE TABLE child (i INT, a VARCHAR(10), FOREIGN KEY (i, a) REFERENCES parent (i, a));
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
ALTER TABLE parent RENAME KEY u1 TO u2;
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
DROP TABLE child, parent;

CREATE TABLE self (i INT, j INT, i2 INT, j2 INT, PRIMARY KEY (i), UNIQUE u(i,j),
                   FOREIGN KEY (i2, j2) REFERENCES self (i, j));
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
ALTER TABLE self RENAME KEY u TO u1;
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
DROP TABLE self;

CREATE TABLE self (i INT, j INT, k INT, i2 INT, j2 INT, k2 INT,
                   PRIMARY KEY (i), UNIQUE u(j), UNIQUE u1(i,j), UNIQUE u2(i,j,k),
                   FOREIGN KEY (i2, j2, k2) REFERENCES self (i, j, k));
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
ALTER TABLE self RENAME KEY u2 TO u3;
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
DROP TABLE self;

CREATE TABLE self (i INT, j INT, i2 INT, j2 INT,
                   d INT GENERATED ALWAYS AS (i) VIRTUAL,
                   e INT GENERATED ALWAYS AS (j) VIRTUAL,
                     PRIMARY KEY (i), UNIQUE u(i,d), UNIQUE u1(i,j,e),
                     FOREIGN KEY (i2, j2) REFERENCES self (i, j));
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
ALTER TABLE self RENAME KEY u1 TO u2;
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
DROP TABLE self;

CREATE TABLE self (i INT, a VARCHAR(10), b VARCHAR(10), i2 INT, a2 VARCHAR(10),
                   PRIMARY KEY (i), UNIQUE u(i,a(5)), UNIQUE u1(i,a,b(5)),
                   FOREIGN KEY (i2, a2) REFERENCES self (i, a));
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
ALTER TABLE self RENAME KEY u1 TO u2;
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
DROP TABLE self;


-- Restore defaults.
SET @@foreign_key_checks= DEFAULT;
SET SESSION debug= '-d,skip_dd_table_access_check';
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT);

SET DEBUG_SYNC="alter_table_inplace_after_lock_downgrade SIGNAL reached WAIT_FOR go";
SET FOREIGN_KEY_CHECKS=0;
SET DEBUG_SYNC="now WAIT_FOR reached";
INSERT INTO parent VALUES (1);
SET @old_lock_wait_timeout= @@lock_wait_timeout;
SET @@lock_wait_timeout= 1;
ALTER TABLE parent ADD COLUMN a INT;
SET @@lock_wait_timeout= @old_lock_wait_timeout;

SET DEBUG_SYNC="now SIGNAL go";
SET FOREIGN_KEY_CHECKS=1;
ALTER TABLE child DROP FOREIGN KEY fk;

SET DEBUG_SYNC="alter_table_copy_after_lock_upgrade SIGNAL reached WAIT_FOR go";
SET DEBUG_SYNC="now WAIT_FOR reached";
INSERT INTO parent VALUES (2);
SET @old_lock_wait_timeout= @@lock_wait_timeout;
SET @@lock_wait_timeout= 1;
ALTER TABLE parent ADD COLUMN a INT;
SET @@lock_wait_timeout= @old_lock_wait_timeout;

SET DEBUG_SYNC="now SIGNAL go";

SET DEBUG_SYNC="RESET";

ALTER TABLE child DROP FOREIGN KEY fk;

SET DEBUG_SYNC="alter_after_copy_table SIGNAL reached WAIT_FOR go";
SET DEBUG_SYNC="now WAIT_FOR reached";
SELECT * FROM parent;
SET @old_lock_wait_timeout= @@lock_wait_timeout;
SET @@lock_wait_timeout= 1;
DELETE FROM parent;
SET @@lock_wait_timeout= @old_lock_wait_timeout;

SET DEBUG_SYNC="now SIGNAL go";

SET DEBUG_SYNC="RESET";

DROP TABLES child, parent;
