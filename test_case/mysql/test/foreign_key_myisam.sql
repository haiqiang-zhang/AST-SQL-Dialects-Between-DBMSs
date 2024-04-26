
-- Use MyISAM for this table since we are only interested in checking syntax.
--error ER_WRONG_FK_DEF
create table t1 (
        a int not null references t2,
        b int not null references t2 (c),
        primary key (a,b),
        foreign key (a) references t3 match full,
        foreign key (a) references t3 match partial,
        foreign key (a,b) references t3 (c,d) on delete no action
          on update no action,
        foreign key (a,b) references t3 (c,d) on update cascade,
        foreign key (a,b) references t3 (c,d) on delete set default,
        foreign key (a,b) references t3 (c,d) on update set null) engine=myisam;

-- Remove the problematic FKs and try again.
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
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES bad_parent(pk)) ENGINE=InnoDB;

CREATE TABLE child (fk INT) ENGINE=InnoDB;
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES bad_parent(pk);
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE child ADD FOREIGN KEY (fk) REFERENCES bad_parent(pk);
DROP TABLE child;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES bad_parent(pk));
SET FOREIGN_KEY_CHECKS = 1;
DROP TABLE bad_parent;
DROP TABLE child;
CREATE TABLE parent (pk INT PRIMARY KEY) ENGINE=InnoDB;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES parent(pk)) ENGINE=InnoDB;
ALTER TABLE child ENGINE=MyISAM;
ALTER TABLE parent ENGINE=MyISAM;
DROP TABLES child, parent;
SET FOREIGN_KEY_CHECKS = 0;
CREATE TABLE child (fk INT, FOREIGN KEY (fk) REFERENCES bad_parent(pk));
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE bad_parent (pk INT PRIMARY KEY) ENGINE=MyISAM;
ALTER TABLE bad_parent DROP COLUMN pk, ADD COLUMN i INT;
DROP TABLE bad_parent;
DROP TABLE child;
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE child (fk CHAR(10), FOREIGN KEY (fk) REFERENCES parent(pk)) ENGINE=InnoDB;
CREATE TABLE parent (pk INT PRIMARY KEY) ENGINE=InnoDB;
CREATE TABLE parent0 (pk INT PRIMARY KEY) ENGINE=InnoDB;
ALTER TABLE parent0 RENAME TO parent;
ALTER TABLE parent0 RENAME TO parent, ADD COLUMN j INT;
CREATE TABLE parent (pk INT PRIMARY KEY) ENGINE=MyISAM;
ALTER TABLE parent ENGINE=InnoDB;
DROP TABLES child, parent0;
SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE child (fk INT, FOREIGN KEY(fk) REFERENCES parent (pk)) ENGINE=InnoDB;
CREATE TABLE parent (pk INT) ENGINE=MyISAM;
ALTER TABLE parent ENGINE=InnoDB;
DROP TABLE parent;
CREATE TABLE parent (a INT) ENGINE=MyISAM;
ALTER TABLE parent ENGINE=InnoDB;
DROP TABLE parent;
CREATE TABLE parent (pk BIGINT PRIMARY KEY) ENGINE=MyISAM;
ALTER TABLE parent ENGINE=InnoDB;
DROP TABLE parent;
CREATE TABLE parent0 (pk INT) ENGINE=MyISAM;
ALTER TABLE parent0 ENGINE=InnoDB, RENAME TO parent;
DROP TABLE parent0;
CREATE TABLE parent (pk INT) ENGINE=MyISAM;
ALTER TABLE parent ENGINE=InnoDB, RENAME TO parent0;
DROP TABLE parent;
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
ALTER TABLE parent ENGINE=InnoDB, RENAME TO parent0;
SELECT referenced_table_name, unique_constraint_name FROM
  information_schema.referential_constraints WHERE table_name = 'child';
DROP TABLES parent;
CREATE TABLE parent (pk INT PRIMARY KEY) ENGINE=MyISAM;
ALTER TABLE parent ENGINE=InnoDB;
ALTER TABLE parent ENGINE=InnoDB;
ALTER TABLE parent ENGINE=InnoDB;
DROP TABLES child, parent;
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE parent (pk INT PRIMARY KEY);
CREATE TABLE child (fk1 INT, b INT, CONSTRAINT c FOREIGN KEY (fk1) REFERENCES parent (pk));
CREATE TABLE myisam_table (fk INT) ENGINE=MyISAM;
ALTER TABLE myisam_table DROP FOREIGN KEY no_such_fk;
ALTER TABLE myisam_table DROP FOREIGN KEY c;
DROP TABLES myisam_table, child, parent;
