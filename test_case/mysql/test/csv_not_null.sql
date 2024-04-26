--           Bug#31473 resulted in strict enforcement of non-nullable
--           columns in CSV engine.
-- NOTE:     Main functionality tested - NOT NULL restrictions on CSV tables
--           CREATE, INSERT, and UPDATE statements 
--           ALTER statements in separate file due to BUG#33696 
-- Author pcrews
-- Last modified:  2008-01-04
-------------------------------------------------------------------------------

--############################################################################
-- Testcase csv_not_null.1:  CREATE TABLE for CSV Engine requires explicit
--                           NOT NULL for each column
--############################################################################
-- echo -- ===== csv_not_null.1 =====
-- disable_warnings
DROP TABLE IF EXISTS t1, t2;
CREATE TABLE t1 (a int) ENGINE = CSV;
CREATE TABLE t1 (a int NOT NULL) ENGINE = CSV;
CREATE TABLE t2 (a int NOT NULL, b char(20)) ENGINE = CSV;


DROP TABLE t1;
--                           statements for CSV
--#############################################################################
-- echo -- ===== csv_not_null.2 =====
-- disable_warnings
DROP TABLE IF EXISTS t1;

SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
CREATE TABLE t1 (a int NOT NULL, b blob NOT NULL, c CHAR(20) NOT NULL, 
d VARCHAR(20) NOT NULL, e enum('foo','bar') NOT NULL,f DATE NOT NULL) 
ENGINE = CSV;
INSERT INTO t1 VALUES();
SELECT * FROM t1;

-- disable_warnings
-- Bug#33717 - INSERT...(default) fails for enum. 
INSERT INTO t1 VALUES(default,default,default,default,default,default);

SELECT * FROM t1;
INSERT INTO t1 VALUES(0,'abc','def','ghi','bar','1999-12-31');
SELECT * FROM t1;
INSERT INTO t1 VALUES(NULL,'ab','a','b','foo','2007-01-01');
INSERT INTO t1 VALUES(default(a),default(b), default(c), default(d),
                      default(e), default(f));


DROP TABLE t1;
--                           statements for CSV
--#############################################################################
-- echo -- ===== csv_not_null.3 =====
-- disable_warnings
DROP TABLE IF EXISTS t1;


CREATE TABLE t1 (a int NOT NULL, b char(10) NOT NULL) ENGINE = CSV;
INSERT INTO t1 VALUES();
SELECT * FROM t1;
UPDATE t1 set b = 'new_value' where a = 0;
SELECT * FROM t1;
UPDATE t1 set b = NULL where b = 'new_value';
SELECT * FROM t1;

DROP TABLE t1;
SET sql_mode = default;
