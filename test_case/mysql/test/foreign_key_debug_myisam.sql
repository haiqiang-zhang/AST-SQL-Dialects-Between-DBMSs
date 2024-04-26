--

--source include/have_debug.inc
--source include/have_debug_sync.inc

-- Some parts of the test require enabled binary log.
--source include/have_log_bin.inc

--source include/have_myisam.inc

SET SESSION debug= '+d,skip_dd_table_access_check';

CREATE TABLE parent(pk INTEGER PRIMARY KEY, j INTEGER,
  UNIQUE KEY parent_key(j));

CREATE TABLE child(pk INTEGER PRIMARY KEY, k INTEGER, fk INTEGER,
  FOREIGN KEY (fk) REFERENCES parent(j), UNIQUE KEY child_key(k));

CREATE TABLE grandchild(pk INTEGER PRIMARY KEY, fk INTEGER,
  FOREIGN KEY (fk) REFERENCES child(k));

SET @@foreign_key_checks= 0;
CREATE TABLE orphan_grandchild(pk INTEGER PRIMARY KEY, fk INTEGER,
  FOREIGN KEY (fk) REFERENCES siebling(k));
SET @@foreign_key_checks= 1;

CREATE TABLE non_atomic_t1(pk INTEGER) ENGINE= MyISAM;
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';

DROP TABLE grandchild;
DROP TABLE orphan_grandchild;
DROP TABLE siebling;
DROP TABLE parent;
DROP TABLE non_atomic_t2;

CREATE TABLE parent(pk INTEGER PRIMARY KEY, j INTEGER,
  UNIQUE KEY parent_key(j));

CREATE TABLE child(pk INTEGER PRIMARY KEY, k INTEGER, fk INTEGER,
  FOREIGN KEY (fk) REFERENCES parent(j), UNIQUE KEY child_key(k));

CREATE TABLE grandchild(pk INTEGER PRIMARY KEY, fk INTEGER,
  FOREIGN KEY (fk) REFERENCES child(k));

SET @@foreign_key_checks= 0;
CREATE TABLE orphan_grandchild(pk INTEGER PRIMARY KEY, fk INTEGER,
  FOREIGN KEY (fk) REFERENCES siebling(k));
SET @@foreign_key_checks= 1;

CREATE TABLE non_atomic_t1(pk INTEGER) ENGINE= InnoDB;
CREATE TABLE non_atomic_t2(pk INTEGER) ENGINE= InnoDB;
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';
SELECT name, unique_constraint_name, referenced_table_schema, referenced_table_name
  FROM mysql.foreign_keys
  WHERE referenced_table_schema LIKE 'test';

DROP TABLE grandchild;
DROP TABLE orphan_grandchild;
DROP TABLE child;
DROP TABLE parent;
DROP TABLE non_atomic_t1;
DROP TABLE non_atomic_t2;

-- Restore defaults.
SET @@foreign_key_checks= DEFAULT;
SET SESSION debug= '-d,skip_dd_table_access_check';
SET @old_lock_wait_timeout= @@lock_wait_timeout;

CREATE TABLE t1 (pk INT PRIMARY KEY) ENGINE=InnoDB;
CREATE TABLE t2 (fk INT) ENGINE=MyISAM;
SET @@debug='+d,injecting_fault_writing';
ALTER TABLE t2 ADD FOREIGN KEY (fk) REFERENCES t1(pk), ENGINE=InnoDB;
SET @@debug='-d,injecting_fault_writing';
SET @@lock_wait_timeout= 1;
INSERT INTO t1 VALUES (NULL);
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DELETE FROM t1;
DROP TABLES t2, t1;
