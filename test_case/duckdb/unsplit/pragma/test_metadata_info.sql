PRAGMA enable_verification;
CREATE TABLE integers(i INTEGER, j INTEGER);
CHECKPOINT;
PRAGMA metadata_info;
FROM pragma_metadata_info();
ATTACH '__TEST_DIR__/test_metadata_info_attach.db' AS db1;
CHECKPOINT db1;
FROM pragma_metadata_info('db1');
