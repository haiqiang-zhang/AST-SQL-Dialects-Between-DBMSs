CREATE TABLE t_file_per_table_on
(a int not null auto_increment primary key,
 b varchar(128))
ENGINE = InnoDB;
CREATE TABLE t_file_per_table_off
(a int not null auto_increment primary key,
 b varchar(128))
ENGINE = InnoDB;
DROP TABLE t_file_per_table_on;
DROP TABLE t_file_per_table_off;
