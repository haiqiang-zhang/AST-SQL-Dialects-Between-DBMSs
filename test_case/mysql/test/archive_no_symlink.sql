
let $data_directory = DATA DIRECTORY = '$MYSQL_TMP_DIR/archive';
let $index_directory = INDEX DIRECTORY = '$MYSQL_TMP_DIR/archive';
  c1 int(10) unsigned NOT NULL AUTO_INCREMENT,
  c2 varchar(30) NOT NULL,
  c3 smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (c1))
ENGINE = archive
$data_directory $index_directory;

INSERT INTO t1 VALUES (NULL, "first", 1);
INSERT INTO t1 VALUES (NULL, "second", 2);
INSERT INTO t1 VALUES (NULL, "third", 3);
DROP TABLE t1;
