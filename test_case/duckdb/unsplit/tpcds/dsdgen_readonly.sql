CREATE TABLE tbl (i INTEGER);;
CALL dsdgen(sf=0);;
ATTACH '__TEST_DIR__/test_dsdgen_ro.db' AS dsdgentest (READ_ONLY);
CALL dsdgen(sf=0, catalog='dsdgentest');;
CALL dsdgen(sf=0);;
