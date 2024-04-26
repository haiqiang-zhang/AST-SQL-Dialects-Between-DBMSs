CREATE TABLE t1 (
  a CHAR(2) NOT NULL,
  b CHAR(2) NOT NULL,
  c INT(10) UNSIGNED NOT NULL,
  d VARCHAR(255) DEFAULT NULL,
  e VARCHAR(1000) DEFAULT NULL,
  KEY (a) INVISIBLE,
  KEY (b)
) PARTITION BY KEY (a) PARTITIONS 20;

INSERT INTO t1 (a, b, c, d, e) VALUES
('07', '03', 343, '1', '07_03_343'),
('01', '04', 343, '2', '01_04_343'),
('01', '06', 343, '3', '01_06_343'),
('01', '07', 343, '4', '01_07_343'),
('01', '08', 343, '5', '01_08_343'),
('01', '09', 343, '6', '01_09_343'),
('03', '03', 343, '7', '03_03_343'),
('03', '06', 343, '8', '03_06_343'),
('03', '07', 343, '9', '03_07_343'),
('04', '03', 343, '10', '04_03_343'),
('04', '06', 343, '11', '04_06_343'),
('05', '03', 343, '12', '05_03_343'),
('11', '03', 343, '13', '11_03_343'),
('11', '04', 343, '14', '11_04_343');

ALTER TABLE t1 ALTER INDEX a VISIBLE;

ALTER TABLE t1 ALTER INDEX b INVISIBLE;

DROP TABLE t1;

CREATE TABLE t1 ( a INT GENERATED ALWAYS AS (1), KEY (a) INVISIBLE );
DROP TABLE t1;

CREATE TABLE t1p ( a INT KEY );
CREATE TABLE t1c ( t1p_a INT );
ALTER TABLE t1c ADD CONSTRAINT FOREIGN KEY ( t1p_a ) REFERENCES t1p( a );
ALTER TABLE t1c ALTER INDEX t1p_a INVISIBLE;
INSERT INTO t1c VALUES ( 1 );
SELECT * FROM t1c;

DROP TABLE t1c, t1p;

CREATE TABLE t1 ( a INT, KEY( a ) INVISIBLE );

INSERT INTO t1 VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
SELECT @@optimizer_switch;
SET @@optimizer_switch='use_invisible_indexes=on';
SELECT @@optimizer_switch;
SELECT @@optimizer_switch;
SET @@optimizer_switch='use_invisible_indexes=off';

DROP TABLE t1;

CREATE TABLE t1 (
 id INT NOT NULL PRIMARY KEY,
 b INT NOT NULL,
 INDEX (b) INVISIBLE
);
INSERT INTO t1 VALUES (1, 1), (2,2),(3,3),(4,4),(5,5);

SET optimizer_switch="use_invisible_indexes=on";
SET optimizer_switch="use_invisible_indexes=default";

DROP TABLE t1;
