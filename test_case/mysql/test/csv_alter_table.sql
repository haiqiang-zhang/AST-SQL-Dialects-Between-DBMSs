--           Bug#31473 resulted in strict enforcement of non-nullable
--           columns in CSV engine.
--           Tests code for Bug#33696 - CSV engine allows NULLable
--           Columns via ALTER TABLE statements
--        
-- Author pcrews
-- Last modified:  2008-01-06
-------------------------------------------------------------------------------

--############################################################################
-- Testcase csv_alter_table.1: Positive test for ALTER table 
--                             
--############################################################################
-- echo -- ===== csv_alter_table.1 =====
-- disable_warnings
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (a int NOT NULL) ENGINE = CSV;
ALTER TABLE t1 ADD COLUMN b CHAR(5) NOT NULL;
ALTER TABLE t1 DROP COLUMN b;
ALTER TABLE t1 MODIFY a BIGINT NOT NULL;
ALTER TABLE t1 CHANGE a a INT NOT NULL;

DROP TABLE t1;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (a int NOT NULL) ENGINE = CSV;
ALTER TABLE t1 ADD COLUMN b CHAR(5);
ALTER TABLE t1 MODIFY a BIGINT;
ALTER TABLE t1 CHANGE a a INT;

DROP TABLE t1;
