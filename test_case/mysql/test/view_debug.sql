
CREATE TABLE test.t1(fld1 INT);
CREATE VIEW test.v1 AS SELECT * FROM test.t1;

SET SESSION debug= "+d, inject_error_ha_write_row";
ALTER VIEW test.v1 AS SELECT * FROM test.t1;
SET SESSION debug= "-d, inject_error_ha_write_row";
ALTER VIEW test.v1 AS SELECT * FROM test.t1;
DROP VIEW test.v1;
DROP TABLE test.t1;

CREATE VIEW v1 AS SELECT 1 FROM DUAL;
CREATE TABLE t1(c INT,d INT,KEY(c));
ALTER DEFINER=s@1 VIEW v1 AS SELECT * FROM t1;
SET SESSION DEBUG= "+d,enable_stack_overrun_simulation";
ALTER TABLE t1 KEY_BLOCK_SIZE=8;
SET SESSION DEBUG= "-d,enable_stack_overrun_simulation";
DROP TABLE t1;
DROP VIEW v1;
