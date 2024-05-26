SELECT CONSTRAINT_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE REFERENCED_TABLE_NAME = 't1';
DROP TABLE t2;
CREATE TABLE t2(a INT PRIMARY KEY, b INT);
DROP TABLE t2;
CREATE TABLE t2(a INT PRIMARY KEY, b INT UNIQUE);
DROP TABLE t2;
DROP TABLE t1;
CREATE TABLE t1(c1 INT PRIMARY KEY);
CREATE TABLE t2(c1 INT, FOREIGN KEY (c1) REFERENCES t1(c1));
ALTER TABLE t2 RENAME TO t3;
ALTER TABLE t3 RENAME TO t4, ALGORITHM= INPLACE;
ALTER TABLE t4 RENAME TO t5;
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
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
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't5' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't5' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't6' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't6' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't6' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't6' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
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
CREATE TABLE t2(a INT, b INT);
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
DROP TABLE t2;
CREATE TABLE t2(a INT, b INT);
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't2' ORDER BY constraint_name;
DROP TABLE t2;
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 't12345678901234567890123456789012345678901234567890123456'
  ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 't12345678901234567890123456789012345678901234567890123456'
  ORDER BY constraint_name;
CREATE TABLE t2(a INT);
DROP TABLE t2;
INSERT INTO t1 VALUES(1);
SELECT * FROM t1;
SELECT * FROM t1;
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
SELECT COUNT(*) = 1
    FROM information_schema.processlist
    WHERE id = @conA_id AND state LIKE 'user sleep';
UPDATE grandparent SET gpf2= 4;
UPDATE grandparent SET gpf2= 100 * gpf1;
ALTER TABLE child ADD COLUMN (i INT);
DROP TABLE child;
DROP TABLE parent;
DROP TABLE grandparent;
CREATE TABLE parent (pk INT PRIMARY KEY);
SELECT * FROM parent;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "CREATE TABLE child%";
SELECT * FROM parent;
CREATE TABLE IF NOT EXISTS child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE child;
SELECT * FROM parent;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
SELECT * FROM child;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "CREATE TABLE parent%";
SELECT * FROM child;
CREATE TABLE IF NOT EXISTS parent (pk INT PRIMARY KEY);
SELECT * FROM child;
DROP TABLE child;
SELECT * FROM parent;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE CASCADE);
LOCK TABLE parent WRITE;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "SELECT * FROM child";
UNLOCK TABLES;
DROP TABLES child, parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
LOCK TABLES parent WRITE;
UNLOCK TABLES;
CREATE TABLE parent_source (pk INT PRIMARY KEY);
SELECT * FROM child;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "CREATE TABLE parent%";
SELECT * FROM child;
CREATE TABLE IF NOT EXISTS parent LIKE parent_source;
SELECT * FROM child;
CREATE TABLE IF NOT EXISTS parent LIKE parent_source;
DROP TABLE child, parent_source;
CREATE TABLE source (fk INT);
INSERT INTO source VALUES (NULL);
SELECT * FROM source FOR UPDATE;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "System lock" AND
        info LIKE "CREATE TABLE child%";
INSERT INTO parent VALUES (1);
ALTER TABLE parent ADD COLUMN a INT;
SELECT * FROM parent;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "CREATE TABLE child%";
CREATE TABLE parent2 (pk INT PRIMARY KEY);
LOCK TABLE parent2 WRITE;
UNLOCK TABLES;
DROP TABLE parent2;
LOCK TABLE parent WRITE;
UNLOCK TABLES;
SELECT * FROM parent;
DROP TABLE parent;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "CREATE TABLE parent%";
CREATE TABLE IF NOT EXISTS parent (pk INT PRIMARY KEY) SELECT 1 AS pk;
DROP TABLE parent;
CREATE TABLE parent (pk INT PRIMARY KEY) SELECT 1 AS pk;
SELECT * FROM parent;
LOCK TABLE parent WRITE;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "SELECT * FROM child";
UNLOCK TABLES;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
SELECT * FROM parent;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "DROP TABLES child";
SELECT * FROM parent;
DROP TABLES child;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "DROP TABLES parent";
DROP TABLES parent;
UNLOCK TABLES;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
SELECT * FROM parent;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "RENAME TABLES child%";
SELECT * FROM parent;
SELECT * FROM child;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "RENAME TABLES parent%";
SELECT * FROM child;
DROP TABLE child;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "RENAME TABLES parent%";
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE CASCADE);
SELECT * FROM parent;
LOCK TABLE parent WRITE;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "SELECT * FROM child1";
UNLOCK TABLES;
SELECT * FROM parent;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE child%";
SELECT * FROM parent;
ALTER TABLE child RENAME TO child1;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE parent%";
ALTER TABLE parent RENAME TO parent1;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent1(pk));
SELECT * FROM child;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE parent%";
DROP TABLE child;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent1(pk));
SELECT * FROM child;
DROP TABLE child;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "SELECT * FROM child1";
UNLOCK TABLES;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT);
SELECT * FROM parent;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE child%";
LOCK TABLE parent WRITE;
UNLOCK TABLES;
SELECT * FROM parent;
SELECT * FROM parent;
LOCK TABLE parent WRITE;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "SELECT * FROM child";
UNLOCK TABLES;
SELECT * FROM parent;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE child%";
ALTER TABLE child ADD CONSTRAINT fk FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE CASCADE;
SELECT * FROM parent;
ALTER TABLE child DROP FOREIGN KEY fk, ALGORITHM=INPLACE;
SELECT * FROM parent;
LOCK TABLE parent WRITE;
UNLOCK TABLES;
DROP TABLES child, parent;
CREATE TABLE parent (pk INT NOT NULL, UNIQUE u(pk));
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
SELECT * FROM child;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE parent%";
SELECT * FROM child;
SELECT * FROM parent;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE child%";
SELECT * FROM parent;
SELECT * FROM child;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE parent%";
SELECT * FROM child;
DROP TABLE child;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent1(pk));
SELECT * FROM child;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE parent%";
DROP TABLE child;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent1(pk));
SELECT * FROM child;
DROP TABLE child;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE CASCADE);
SELECT * FROM parent;
LOCK TABLE parent WRITE;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "SELECT * FROM child1";
UNLOCK TABLES;
SELECT * FROM parent;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE child%";
LOCK TABLE parent WRITE;
UNLOCK TABLES;
DELETE FROM parent;
ALTER TABLE child ADD CONSTRAINT fk FOREIGN KEY (fk) REFERENCES parent(pk), ALGORITHM=COPY;
SELECT * FROM parent;
SELECT * FROM parent;
LOCK TABLE parent WRITE;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "SELECT * FROM child";
UNLOCK TABLES;
SELECT * FROM parent;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE child%";
SELECT * FROM parent;
ALTER TABLE child DROP FOREIGN KEY fk, ALGORITHM=COPY;
SELECT * FROM parent;
LOCK TABLE parent WRITE;
UNLOCK TABLES;
DROP TABLES child, parent;
CREATE TABLE parent (pk INT NOT NULL, UNIQUE u(pk));
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
SELECT * FROM child;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE parent%";
SELECT * FROM child;
SELECT * FROM parent;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE child%";
SELECT * FROM parent;
SELECT * FROM child;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE parent%";
SELECT * FROM child;
DROP TABLE child;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent1(pk));
SELECT * FROM child;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "ALTER TABLE parent%";
DROP TABLE child;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent1(pk));
SELECT * FROM child;
DROP TABLE child;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk) ON DELETE CASCADE);
SELECT * FROM parent;
LOCK TABLE parent WRITE;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "SELECT * FROM child1";
UNLOCK TABLES;
LOCK TABLE parent WRITE;
UNLOCK TABLE;
LOCK TABLE parent WRITE;
UNLOCK TABLE;
LOCK TABLES child WRITE, parent WRITE;
DROP TABLES child, parent;
UNLOCK TABLES;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT);
LOCK TABLES child WRITE;
UNLOCK TABLES;
LOCK TABLES child WRITE, parent READ;
ALTER TABLE child ADD CONSTRAINT fk FOREIGN KEY (fk) REFERENCES parent(pk);
UNLOCK TABLES;
LOCK TABLES child WRITE;
UNLOCK TABLES;
LOCK TABLES parent WRITE;
UNLOCK TABLES;
LOCK TABLES child1 WRITE, parent1 WRITE;
DELETE FROM parent1;
UNLOCK TABLES;
LOCK TABLES child WRITE, parent1 WRITE;
INSERT INTO child VALUES (NULL);
UNLOCK TABLES;
ALTER TABLE child DROP FOREIGN KEY fk;
LOCK TABLES child WRITE, parent WRITE;
DELETE FROM parent;
UNLOCK TABLES;
DROP TABLE child1;
LOCK TABLE parent WRITE;
UNLOCK TABLES;
LOCK TABLE parent WRITE, child READ;
UNLOCK TABLES;
LOCK TABLE parent WRITE, child WRITE;
INSERT INTO child VALUES (NULL);
UNLOCK TABLES;
DROP TABLES child, parent1;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t1'
  ORDER BY constraint_name;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t1'
  ORDER BY constraint_name;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t1'
  ORDER BY constraint_name;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t1'
  ORDER BY constraint_name;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t1'
  ORDER BY constraint_name;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t1'
  ORDER BY constraint_name;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t1'
  ORDER BY constraint_name;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t2'
  ORDER BY constraint_name;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t2'
  ORDER BY constraint_name;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t2'
  ORDER BY constraint_name;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t2'
  ORDER BY constraint_name;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t2'
  ORDER BY constraint_name;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t2'
  ORDER BY constraint_name;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t2'
  ORDER BY constraint_name;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t1'
  ORDER BY constraint_name;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t1'
  ORDER BY constraint_name;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t1'
  ORDER BY constraint_name;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t2'
  ORDER BY constraint_name;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t2'
  ORDER BY constraint_name;
SELECT constraint_name, table_name, column_name, referenced_column_name
  FROM information_schema.key_column_usage
  WHERE table_schema='test' AND table_name='t2'
  ORDER BY constraint_name;
ALTER TABLE t1 RENAME TO t4;
CREATE TABLE t1 (i INT PRIMARY KEY);
CREATE TABLE t2 (j INT, FOREIGN KEY (j) REFERENCES t1 (i) ON DELETE CASCADE);
CREATE TABLE t3 (k INT);
PREPARE stmt FROM 'INSERT INTO t3 VALUES (1)';
DROP TABLES t2, t1;
CREATE TABLE t1 (i INT PRIMARY KEY);
CREATE TABLE t2 (j INT, FOREIGN KEY (j) REFERENCES t1 (i) ON DELETE CASCADE);
DROP TABLES t2, t1;
CREATE VIEW t2 AS SELECT 1 AS j;
DEALLOCATE PREPARE stmt;
DROP TABLE t3;
DROP VIEW t2;
CREATE TABLE t0 (i INT);
CREATE TABLE t1 (pk INT PRIMARY KEY);
CREATE TABLE t2 (fk INT, FOREIGN KEY (fk) REFERENCES t1 (pk) ON UPDATE SET NULL);
LOCK TABLE t1 READ;
UNLOCK TABLES;
LOCK TABLES t0 WRITE;
UNLOCK TABLES;
DROP TABLES t2, t1, t0;
CREATE TABLE t1 (pk INT PRIMARY KEY);
CREATE TABLE t2 (fk1 INT, fk2 INT, fk3 INT,
                 CONSTRAINT a FOREIGN KEY (fk1) REFERENCES t1 (pk),
                 CONSTRAINT t2_ibfk_1 FOREIGN KEY (fk2) REFERENCES t1 (pk));
ALTER TABLE t2 ADD FOREIGN KEY (fk3) REFERENCES t1 (pk);
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='mysqltest';
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='mysqltest';
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='mysqltest';
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='mysqltest';
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='mysqltest';
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='mysqltest';
SELECT * FROM information_schema.referential_constraints WHERE constraint_schema='test';
CREATE TABLE t3 (pk INT PRIMARY KEY, fk INT, u INT);
INSERT INTO t3 VALUES (1, 1, 1), (2, 1, 1);
DROP SCHEMA mysqltest;
DROP TABLES t1, t2;
CREATE TABLE t1 (pk INT PRIMARY KEY, fk INT);
CREATE TABLE t2 (pk INT PRIMARY KEY, fk INT,
                 FOREIGN KEY(fk) REFERENCES t1 (pk));
ALTER TABLE t1 ADD FOREIGN KEY (fk) REFERENCES t2 (pk);
DROP TABLES t1, t2;
CREATE SCHEMA mysqltest;
CREATE TABLE mysqltest.t1 (pk INT PRIMARY KEY);
DROP SCHEMA mysqltest;
CREATE SCHEMA mysqltest;
CREATE TABLE t1 (pk INT PRIMARY KEY, fk INT);
CREATE TABLE t2 (pk INT PRIMARY KEY, fk INT,
                 FOREIGN KEY(fk) REFERENCES t1 (pk));
ALTER TABLE t1 ADD FOREIGN KEY (fk) REFERENCES t2 (pk);
DROP SCHEMA mysqltest;
CREATE TABLE child (fk INT, fk2 INT);
CREATE TABLE self (pk INT PRIMARY KEY, a INT, fk INT);
DROP TABLE child, self, parent;
CREATE TABLE parent (pk INT PRIMARY KEY, u INT NOT NULL, UNIQUE(u));
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(u));
CREATE TABLE self (pk INT PRIMARY KEY, u INT NOT NULL, fk INT, UNIQUE(u),
                   FOREIGN KEY (fk) REFERENCES self(u));
ALTER TABLE parent DROP KEY u, ADD KEY nu(u);
ALTER TABLE self DROP KEY u, ADD KEY nu(u);
DROP TABLES self, child, parent;
CREATE TABLE parent (pk INT PRIMARY KEY, a INT);
CREATE TABLE parent1 (pk INT PRIMARY KEY, a INT);
CREATE TABLE grandparent (pk INT PRIMARY KEY);
SELECT referenced_table_name, unique_constraint_name FROM
  information_schema.referential_constraints WHERE table_name = 'child';
SELECT referenced_table_name, unique_constraint_name FROM
  information_schema.referential_constraints WHERE table_name = 'child';
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
SELECT referenced_table_name, unique_constraint_name FROM
  information_schema.referential_constraints WHERE table_name = 'child';
SELECT referenced_table_name, unique_constraint_name FROM
  information_schema.referential_constraints WHERE table_name = 'child';
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
CREATE TABLE child (fk INT, j INT);
CREATE TABLE self (pk INT PRIMARY KEY, fk INT);
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES parent(pk);
ALTER TABLE self ADD FOREIGN KEY (fk) REFERENCES self(pk);
DROP TABLE child;
DROP TABLE self;
CREATE TABLE child (fk INT);
CREATE TABLE self (pk INT PRIMARY KEY, fk INT);
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES parent(pk);
ALTER TABLE self ADD FOREIGN KEY (fk) REFERENCES self(pk);
DROP TABLES child, parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE parent0 (pk INT PRIMARY KEY);
CREATE TABLE child (base INT, fk INT GENERATED ALWAYS AS (base+1) VIRTUAL);
ALTER TABLE self ADD FOREIGN KEY (fk) REFERENCES self(pk);
DROP TABLE child, self;
CREATE TABLE child (base INT, fk INT GENERATED ALWAYS AS (base+1) STORED,
                    FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE self (pk INT PRIMARY KEY, base INT,
                   fk INT GENERATED ALWAYS AS (base+1) STORED,
                   FOREIGN KEY (fk) REFERENCES self(pk));
DROP TABLE child, parent, self;
CREATE TABLE parent (base INT, pk INT GENERATED ALWAYS AS (base+1) VIRTUAL, UNIQUE KEY(pk));
CREATE TABLE child (fk INT);
CREATE TABLE self (base INT, pk INT GENERATED ALWAYS AS (base+1) VIRTUAL, fk INT,
                   UNIQUE KEY(pk));
DROP TABLE child, parent, self;
CREATE TABLE parent (base INT, pk INT GENERATED ALWAYS AS (base+1) STORED, UNIQUE KEY(pk));
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
CREATE TABLE self (base INT, pk INT GENERATED ALWAYS AS (base+1) STORED, fk INT,
                   UNIQUE KEY(pk), FOREIGN KEY (fk) REFERENCES self(pk));
DROP TABLES child, parent, self;
CREATE TABLE parent (base INT, pk INT GENERATED ALWAYS AS (base+1) VIRTUAL, UNIQUE KEY(pk));
CREATE TABLE child (fk POINT SRID 0 NOT NULL);
CREATE TABLE self (pk POINT SRID 0 NOT NULL, fk POINT SRID 0 NOT NULL, KEY(pk));
DROP TABLES self, child, parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT, FOREIGN KEY(fk) REFERENCES parent(pk));
CREATE TABLE self (pk INT PRIMARY KEY, fk INT, FOREIGN KEY(fk) REFERENCES self(pk));
ALTER TABLE child ADD KEY fk_s(fk);
ALTER TABLE self ADD KEY fk_s(fk);
ALTER TABLE child DROP KEY fk_s, ADD COLUMN j INT, ADD KEY (fk, j);
ALTER TABLE self DROP KEY fk_s, ADD COLUMN j INT, ADD KEY(fk, j);
DROP TABLES self, child, parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (pk INT PRIMARY KEY, fk INT) PARTITION BY KEY (pk) PARTITIONS 20;
DROP TABLE child;
CREATE TABLE child (pk INT PRIMARY KEY, fk INT, FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLES child, parent;
CREATE TABLE parent (pk INT PRIMARY KEY) PARTITION BY KEY (pk) PARTITIONS 20;
CREATE TABLE child (fk INT);
DROP TABLES child, parent;
CREATE TABLE parent (pk INT PRIMARY KEY) PARTITION BY KEY (pk) PARTITIONS 20;
CREATE TABLE self (pk INT PRIMARY KEY, fk INT,
                   CONSTRAINT c FOREIGN KEY (fk) REFERENCES self(pk));
ALTER TABLE self DROP FOREIGN KEY c PARTITION BY KEY (pk) PARTITIONS 20;
ALTER TABLE self ADD FOREIGN KEY (fk) REFERENCES self(pk) REMOVE PARTITIONING;
DROP TABLES self;
CREATE TABLE child (fk INT NOT NULL);
DROP TABLE child;
CREATE TABLE child (fk INT);
DROP TABLE child;
CREATE TABLE child (fk CHAR(10));
CREATE TABLE self (pk INT PRIMARY KEY, fk CHAR(10));
DROP TABLES self, child;
ALTER TABLE parent MODIFY pk CHAR(10);
ALTER TABLE parent MODIFY pk CHAR(10);
CREATE TABLE self (pk INT PRIMARY KEY, fk INT, FOREIGN KEY (fk) REFERENCES self(pk));
CREATE TABLE child (fk1 INT, fk2 CHAR(10));
DROP TABLE child;
DROP TABLE self;
CREATE TABLE self (pk1 INT, pk2 INT, fk1 INT, fk2 INT, PRIMARY KEY (pk1, pk2),
                   FOREIGN KEY (fk1, fk2) REFERENCES self(pk1, pk2));
DROP TABLE self;
ALTER TABLE parent MODIFY pk INT UNSIGNED;
DROP TABLE parent;
CREATE TABLE parent (pk DOUBLE PRIMARY KEY);
CREATE TABLE child (fk DOUBLE, FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE child;
CREATE TABLE child (fk DOUBLE UNSIGNED, FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLES child, parent;
CREATE TABLE parent (pk FLOAT PRIMARY KEY);
DROP TABLE parent;
CREATE TABLE parent (pk DECIMAL(6,2) PRIMARY KEY);
CREATE TABLE child (fk DECIMAL(6,2), FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE child;
CREATE TABLE child (fk DECIMAL(6,2) UNSIGNED, FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE child;
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
DROP TABLE parent;
CREATE TABLE parent (pk VARBINARY(10) PRIMARY KEY);
CREATE TABLE child (fk BINARY(100), FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLES child, parent;
CREATE TABLE parent (pk CHAR(4) CHARACTER SET latin1 PRIMARY KEY);
ALTER TABLE parent MODIFY pk CHAR(1) CHARACTER SET latin1;
DROP TABLE parent;
CREATE TABLE parent (pk BINARY(4) PRIMARY KEY);
ALTER TABLE parent MODIFY pk BINARY(1);
DROP TABLE parent;
CREATE TABLE parent(pk DATE PRIMARY KEY);
CREATE TABLE child (fk DATE, FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE child;
DROP TABLE parent;
CREATE TABLE parent (pk TIMESTAMP PRIMARY KEY);
CREATE TABLE child (fk TIMESTAMP, FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE child;
DROP TABLE parent;
CREATE TABLE parent(pk ENUM('a') PRIMARY KEY);
CREATE TABLE child (fk ENUM('b','c'), FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE child;
DROP TABLE parent;
CREATE TABLE parent(pk SET('a') PRIMARY KEY);
CREATE TABLE child (fk SET('b','c'), FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE child;
DROP TABLE parent;
CREATE TABLE parent(pk BIT(32) PRIMARY KEY);
CREATE TABLE child (fk BIT(10), FOREIGN KEY (fk) REFERENCES parent(pk));
DROP TABLE child;
DROP TABLE parent;
CREATE TABLE parent (pk VARCHAR(10) CHARACTER SET latin1 PRIMARY KEY);
CREATE TABLE child (fk VARCHAR(20) CHARACTER SET latin1,
                    FOREIGN KEY (fk) REFERENCES parent(pk));
ALTER TABLE child MODIFY fk VARCHAR(20) CHARACTER SET latin1;
ALTER TABLE parent MODIFY pk VARCHAR(10) CHARACTER SET latin1;
DROP TABLE child;
CREATE TABLE child (fk VARCHAR(20) CHARACTER SET utf8mb4);
DROP TABLE child, parent;
CREATE TABLE parent (pk VARCHAR(10) CHARACTER SET utf8mb4 PRIMARY KEY);
ALTER TABLE parent MODIFY pk VARCHAR(10) CHARACTER SET utf8mb4;
CREATE DATABASE wl8910db;
CREATE PROCEDURE p1() SQL SECURITY INVOKER INSERT INTO t2 (fld1, fld2) VALUES (1, 2);
CREATE PROCEDURE p2() SQL SECURITY DEFINER INSERT INTO t2 (fld1, fld2) VALUES (1, 2);
CREATE SQL SECURITY INVOKER VIEW v1 AS SELECT * FROM t2;
CREATE SQL SECURITY DEFINER VIEW v2 AS SELECT * FROM t2;
DROP TABLE t2, t3, t1;
DROP PROCEDURE p1;
DROP PROCEDURE p2;
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
SELECT *  FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE
TABLE_NAME IN ('t1', 't2', 't3', 't4');
SELECT *  FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE
TABLE_NAME IN ('t1', 't2', 't3', 't4');
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
SELECT column_name, referenced_column_name FROM information_schema.key_column_usage
  WHERE referenced_table_schema='test' AND referenced_table_name='parent';
SELECT column_name, referenced_column_name FROM information_schema.key_column_usage
  WHERE referenced_table_schema='test' AND referenced_table_name='parent';
DROP TABLES child, parent;
SELECT column_name, referenced_column_name FROM information_schema.key_column_usage
  WHERE referenced_table_schema='test' AND referenced_table_name='parent';
CREATE TABLE child (Fk VARCHAR(10));
SELECT column_name, referenced_column_name FROM information_schema.key_column_usage
  WHERE referenced_table_schema='test' AND referenced_table_name='parent';
CREATE TABLE parent (pk VARCHAR(10) PRIMARY KEY);
SELECT column_name, referenced_column_name FROM information_schema.key_column_usage
  WHERE referenced_table_schema='test' AND referenced_table_name='parent';
DROP TABLES child, parent;
SELECT CONSTRAINT_NAME, TABLE_NAME
  FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
  WHERE TABLE_NAME IN ('t2', 't3') ORDER BY CONSTRAINT_NAME;
SELECT CONSTRAINT_NAME FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
  WHERE TABLE_NAME = 't4' ORDER BY CONSTRAINT_NAME;
CREATE TABLE parent (pk INT PRIMARY KEY);
INSERT INTO parent VALUES (1);
CREATE TABLE child (fk INT, b INT, FOREIGN KEY (fk) REFERENCES parent (pk));
INSERT INTO child VALUES (1, 1);
ALTER TABLE child MODIFY COLUMN b BIGINT, RENAME TO child_renamed, ALGORITHM=COPY;
DROP TABLE child_renamed;
CREATE TABLE child (fk INT, b INT, FOREIGN KEY (fk) REFERENCES parent (pk));
DROP TABLES child, parent;
CREATE TABLE parent (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, c CHAR(32));
CREATE TABLE uncle (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, c CHAR(32));
CREATE TABLE child (parent_id INT, c CHAR(32), FOREIGN KEY (parent_id) REFERENCES parent (id));
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
CREATE TABLE parent (pk INT PRIMARY KEY, a INT, UNIQUE ua(a));
SELECT constraint_name, unique_constraint_name FROM information_schema.referential_constraints
  WHERE constraint_schema='test' AND constraint_name='c';
DROP TABLE parent;
CREATE TABLE parent (a CHAR(10), b int, KEY(b), PRIMARY KEY (a(5)));
DROP TABLE parent;
CREATE TABLE parent (a INT, b CHAR(10), c int, KEY(c), PRIMARY KEY (a, b(5)));
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
DROP TABLES t3, t2, t1;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT, a INT);
PREPARE stmt1 FROM 'ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES parent (pk)';
ALTER TABLE child RENAME COLUMN fk TO fkold, RENAME COLUMN a TO fk;
DEALLOCATE PREPARE stmt1;
DROP TABLES child, parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk1 INT, b INT, CONSTRAINT c FOREIGN KEY (fk1) REFERENCES parent (pk));
CREATE TABLE unrelated (a INT);
DROP TABLES unrelated, child, parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk1 INT, fk2 INT, a INT, KEY(fk1), KEY(fk2));
INSERT INTO child VALUES (NULL, NULL, 1), (NULL, NULL, 1);
ALTER TABLE child ADD CONSTRAINT f FOREIGN KEY (fk1) REFERENCES parent (pk);
DROP TABLES child, parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT);
DROP TABLES child, parent;
CREATE DATABASE aux;
CREATE TABLE aux.parent (pk INT PRIMARY KEY);
DROP DATABASE aux;
CREATE TABLE parent (id INT PRIMARY KEY);
CREATE TABLE child (fk INT, CONSTRAINT c1 FOREIGN KEY (fk) REFERENCES parent (id) /*!40008 ON DELETE CASCADE ON UPDATE CASCADE */);
ALTER TABLE child DROP FOREIGN KEY c1;
ALTER TABLE child ADD CONSTRAINT c2 FOREIGN KEY (fk) REFERENCES parent /*! (id) */ /*!40008 ON DELETE SET NULL */;
DROP TABLES child, parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk INT);
DROP TABLES child, parent;
CREATE TABLE t (a INT KEY, b INT NOT NULL UNIQUE KEY,
                CONSTRAINT FOREIGN KEY (a) REFERENCES t(b));
DROP TABLE t;
SELECT constraint_name, unique_constraint_name FROM
       INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE table_name='t2';
SELECT constraint_name, unique_constraint_name FROM
       INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE table_name='t2';
SELECT constraint_name, unique_constraint_name FROM
       INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE table_name='t2';
SELECT constraint_name, unique_constraint_name FROM
       INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE table_name='t2';
CREATE DATABASE db1;
CREATE DATABASE db2;
DROP DATABASE db1;
DROP DATABASE db2;
