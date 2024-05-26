CREATE DATABASE db1_basic;
CREATE TABLE t1 (a INT);
CREATE TABLE t2 (a INT, b VARCHAR(10), primary key(a));
CREATE TABLE t3 (`a"b"` char(2));
CREATE TABLE t4 (
  name VARCHAR(64) NOT NULL,
  value FLOAT DEFAULT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  comment VARCHAR(1024) DEFAULT NULL,
  PRIMARY KEY (name)
);
CREATE TABLE t5 (
  id int(11) NOT NULL,
  id2 tinyint(3) NOT NULL,
  PRIMARY KEY (id),
  KEY index2 (id2)
);
CREATE TABLE t6 (`x"z"` INT, xyz VARCHAR(20), notes TEXT);
ALTER TABLE t6 ADD INDEX t6_index (`x"z"`, xyz, notes(3));
CREATE TABLE t7 (
  PS_PARTKEY int(11) NOT NULL,
  PS_SUPPKEY int(11) NOT NULL,
  PS_AVAILQTY int(11) NOT NULL,
  PS_SUPPLYCOST float NOT NULL,
  PS_COMMENT varchar(199) NOT NULL
);
ALTER TABLE t7 ADD PRIMARY KEY (PS_PARTKEY,PS_SUPPKEY);
CREATE TABLE t8 (
  c_id INT(11) NOT NULL AUTO_INCREMENT,
  c_name VARCHAR(255) NOT NULL,
  c_description text,
  PRIMARY KEY (c_id)
);
CREATE TABLE t9 (
  v_id INT(11) NOT NULL AUTO_INCREMENT,
  v_name VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (v_id)
);
CREATE TABLE t10 (
  p_id INT(11) NOT NULL AUTO_INCREMENT,
  p_name VARCHAR(355) NOT NULL,
  p_price decimal(10,0) DEFAULT NULL,
  c_id INT(11) NOT NULL,
  PRIMARY KEY (p_id),
  KEY fk_t8 (c_id),
  CONSTRAINT t10_ibfk_1 FOREIGN KEY (c_id) REFERENCES t8 (c_id) ON UPDATE CASCADE
);
CREATE TABLE t11 (
   num int PRIMARY KEY,
   FOREIGN KEY (num) REFERENCES t9 (v_id)
);
ALTER TABLE t10 ADD COLUMN v_id INT NOT NULL AFTER c_id;
ALTER TABLE t10 ADD FOREIGN KEY fk_t9(v_id) REFERENCES
      t9(v_id) ON DELETE NO ACTION ON UPDATE CASCADE;
CREATE TABLE t12 (
  ID bigint NOT NULL DEFAULT '0',
  v bigint NOT NULL,
  PRIMARY KEY (ID,v)
);
CREATE TABLE t13 (
  ID bigint NOT NULL DEFAULT '0',
  k varchar(30) NOT NULL DEFAULT '',
  v bigint NOT NULL,
  PRIMARY KEY (ID, v, k),
  CONSTRAINT relation_tags_ibfk_1 FOREIGN KEY (ID, v) REFERENCES t12 (ID,v)
);
INSERT INTO t4  (name) VALUES ('disk_temptable_create_cost');
INSERT INTO t4  (name) VALUES ('disk_temptable_row_cost');
INSERT INTO t4  (name) VALUES ('key_compare_cost');
INSERT INTO t4  (name) VALUES ('memory_temptable_create_cost');
INSERT INTO t4  (name) VALUES ('memory_temptable_row_cost');
INSERT INTO t4  (name) VALUES ('row_evaluate_cost');
