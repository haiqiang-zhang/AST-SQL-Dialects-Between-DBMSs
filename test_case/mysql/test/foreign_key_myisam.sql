SELECT referenced_table_name, unique_constraint_name FROM
  information_schema.referential_constraints WHERE table_name = 'child';
ALTER TABLE parent ENGINE=InnoDB;
SELECT referenced_table_name, unique_constraint_name FROM
  information_schema.referential_constraints WHERE table_name = 'child';
DROP TABLE parent;
CREATE TABLE parent (pk INT PRIMARY KEY) ENGINE=MyISAM;
SELECT referenced_table_name, unique_constraint_name FROM
  information_schema.referential_constraints WHERE table_name = 'child';
SELECT referenced_table_name, unique_constraint_name FROM
  information_schema.referential_constraints WHERE table_name = 'child';
DROP TABLES parent;
CREATE TABLE parent (pk INT PRIMARY KEY) ENGINE=MyISAM;
LOCK TABLES parent WRITE;
ALTER TABLE parent ENGINE=InnoDB;
UNLOCK TABLES;
LOCK TABLES child READ, parent WRITE;
ALTER TABLE parent ENGINE=InnoDB;
UNLOCK TABLES;
LOCK TABLES child WRITE, parent WRITE;
ALTER TABLE parent ENGINE=InnoDB;
UNLOCK TABLES;
DROP TABLES child, parent;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk1 INT, b INT, CONSTRAINT c FOREIGN KEY (fk1) REFERENCES parent (pk));
CREATE TABLE myisam_table (fk INT) ENGINE=MyISAM;
ALTER TABLE myisam_table DROP FOREIGN KEY no_such_fk;
ALTER TABLE myisam_table DROP FOREIGN KEY c;
DROP TABLES myisam_table, child, parent;
