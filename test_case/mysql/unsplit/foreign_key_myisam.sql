create table t1 (
        a int not null,
        b int not null references t2 (c),
        primary key (a,b),
        foreign key (a,b) references t3 (c,d) on delete no action
          on update no action,
        foreign key (a,b) references t3 (c,d) on update cascade,
        foreign key (a,b) references t3 (c,d) on delete set default,
        foreign key (a,b) references t3 (c,d) on update set null) engine=myisam;
create index a on t1 (a);
create unique index b on t1 (a,b);
drop table t1;
CREATE TABLE bad_parent (pk INT PRIMARY KEY) ENGINE=MyISAM;
CREATE TABLE child (fk INT) ENGINE=InnoDB;
DROP TABLE child;
DROP TABLE bad_parent;
CREATE TABLE parent (pk INT PRIMARY KEY) ENGINE=InnoDB;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk)) ENGINE=InnoDB;
DROP TABLES child, parent;
CREATE TABLE bad_parent (pk INT PRIMARY KEY) ENGINE=MyISAM;
ALTER TABLE bad_parent DROP COLUMN pk, ADD COLUMN i INT;
DROP TABLE bad_parent;
CREATE TABLE parent (pk INT PRIMARY KEY) ENGINE=InnoDB;
CREATE TABLE parent0 (pk INT PRIMARY KEY) ENGINE=InnoDB;
ALTER TABLE parent ENGINE=InnoDB;
CREATE TABLE child (fk INT, FOREIGN KEY(fk) REFERENCES parent (pk)) ENGINE=InnoDB;
ALTER TABLE parent ENGINE=InnoDB;
ALTER TABLE parent ENGINE=InnoDB;
ALTER TABLE parent ENGINE=InnoDB;
DROP TABLE parent0;
ALTER TABLE parent ENGINE=InnoDB, RENAME TO parent0;
CREATE TABLE parent (pk INT, UNIQUE u(pk)) ENGINE=MyISAM;
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
