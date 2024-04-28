CREATE TABLE tbl (i INTEGER);;
CALL dbgen(sf=0);;
ATTACH '__TEST_DIR__/test_dbgen_ro.db' AS dbgentest (READ_ONLY);
CALL dbgen(sf=0, catalog='dbgentest');;
CALL dbgen(sf=0);;
