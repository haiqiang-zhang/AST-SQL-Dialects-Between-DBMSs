--

-- we do the windows specific relative directory testing

--source include/windows.inc

CREATE TABLE t1 (c1 longtext);
INSERT INTO t1 values ('a');

LET $MYSQL_TMP_DIR_UCASE= `SELECT upper('$MYSQL_TMP_DIR')`;
LET $MYSQL_TMP_DIR_LCASE= `SELECT lower('$MYSQL_TMP_DIR')`;
DROP TABLE t1;
