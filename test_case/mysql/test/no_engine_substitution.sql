SELECT @@disabled_storage_engines;
SET DEFAULT_STORAGE_ENGINE= MyISAM;
SELECT @@default_storage_engine;
SET SQL_MODE= 'NO_ENGINE_SUBSTITUTION';

CREATE TABLE t1(c1 INT) ENGINE= MyISAM;
INSERT INTO t1 VALUES(1);
CREATE TABLE t2(c1 INT) ENGINE= InnoDB;
CREATE TEMPORARY TABLE t2(c1 INT) ENGINE= InnoDB;
ALTER TABLE t1 ENGINE= InnoDB;
CREATE TABLE t2 (c1 INT) ENGINE=MYISAM;

SELECT @@disabled_storage_engines;
SET @old_default_engine= @@default_storage_engine;
SET DEFAULT_STORAGE_ENGINE= InnoDB;
SELECT @@default_storage_engine;
CREATE TABLE t2(c1 INT) ENGINE= MyISAM;

SELECT * FROM t1;
ALTER TABLE t2 ENGINE=example;

SET SQL_MODE='';
ALTER TABLE t2 ENGINE=example;
SET SQL_MODE= 'NO_ENGINE_SUBSTITUTION';
ALTER TABLE t2 ENGINE=example;

SET SQL_MODE='';

ALTER TABLE t2 ENGINE=example;
DROP TABLE t2;
SET SQL_MODE= 'NO_ENGINE_SUBSTITUTION';
CREATE TABLE t1(a int) ENGINE=EXAMPLE;
SET SQL_MODE='';

-- Engine for the table substituted to InnoDB
CREATE TABLE t2(c1 INT) ENGINE= MyISAM;

CREATE TABLE t3 LIKE t1;

CREATE TEMPORARY TABLE t4(c1 INT) ENGINE= MyISAM;

CREATE TABLE t5 (c1 INT) ENGINE= ARCHIVE;
ALTER TABLE t5 ENGINE= MyISAM;
CREATE PROCEDURE p1()
BEGIN
  CREATE TABLE t6(c1 INT) ENGINE= MyISAM;
END /

DELIMITER ;

CREATE TABLE t7 (c1 INT) ENGINE= EXAMPLE;

-- If disabled engine and the default engine are the same.
SET DEFAULT_STORAGE_ENGINE= MyISAM;
CREATE TABLE t8 (c1 INT) ENGINE= MyISAM;

-- If disabled engine and default engine both are in the disabled SE list.
--error ER_DISABLED_STORAGE_ENGINE
CREATE TABLE t8 (c1 INT) ENGINE= EXAMPLE;
SET sql_mode = "";
SET DEFAULT_STORAGE_ENGINE= InnoDB;
CREATE TABLE parent_table (i INT PRIMARY KEY);

CREATE TABLE child_table (
i INT,

CONSTRAINT fk_parent_table
FOREIGN KEY (i)
REFERENCES parent_table (i) ON DELETE CASCADE
) ENGINE=MyISAM;

DROP TABLE child_table;
DROP TABLE parent_table;
CREATE TEMPORARY TABLE tt1 LIKE performance_schema.setup_consumers;
DROP TABLE tt1;

SET default_tmp_storage_engine=MYISAM;
CREATE TEMPORARY TABLE tt1(c1 INT);
CREATE TEMPORARY TABLE tt1 LIKE performance_schema.setup_consumers;


-- Cleanup
UNINSTALL PLUGIN EXAMPLE;
DROP PROCEDURE p1;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
DROP TABLE t5;
DROP TABLE t6;
DROP TABLE t7;

SET @@default_storage_engine=@old_default_engine;
SET sql_mode= DEFAULT;

SET @old_default_engine= @@default_storage_engine;
SET DEFAULT_STORAGE_ENGINE= MyISAM;
SET DEFAULT_TMP_STORAGE_ENGINE= MyISAM;
SET SQL_MODE='NO_ENGINE_SUBSTITUTION';
CREATE TABLE t1 (c1 INT) ENGINE= ARCHIVE;
CREATE TEMPORARY TABLE t1 (c1 INT) ENGINE= ARCHIVE;

CREATE TABLE t1 (c1 INT) ENGINE=MyISAM;
ALTER TABLE t1 ENGINE= ARCHIVE;
SET SQL_MODE='';

CREATE TABLE t2 (c1 INT) ENGINE=ARCHIVE;

CREATE TEMPORARY TABLE t3 (c1 INT) ENGINE= ARCHIVE;
ALTER TABLE t1 ENGINE= ARCHIVE;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;

SET @@default_storage_engine= @old_default_engine;
SET sql_mode = DEFAULT;