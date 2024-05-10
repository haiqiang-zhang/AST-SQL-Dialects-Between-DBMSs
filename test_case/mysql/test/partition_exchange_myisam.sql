CREATE TABLE t (a INT,
  b VARCHAR(55),
  PRIMARY KEY (a)) engine=InnoDB;
CREATE TABLE tp (a INT,
  b VARCHAR(55),
  PRIMARY KEY (a)) engine=InnoDB
PARTITION BY RANGE (a)
(PARTITION p0 VALUES LESS THAN (100),
 PARTITION p1 VALUES LESS THAN MAXVALUE);
INSERT INTO t VALUES (1, "First value"), (3, "Three"), (5, "Five"), (99, "End of values");
INSERT INTO tp VALUES (2, "First value"), (10, "Ten"), (50, "Fifty"), (200, "Two hundred, end of values"), (61, "Sixty one"), (62, "Sixty two"), (63, "Sixty three"), (64, "Sixty four"), (161, "161"), (162, "162"), (163, "163"), (164, "164");
ALTER TABLE t ENGINE = MyISAM;
ALTER TABLE tp ENGINE = InnoDB;
ALTER TABLE t ENGINE = InnoDB;
DROP TABLE t,tp;
