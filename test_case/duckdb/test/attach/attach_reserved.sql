PRAGMA enable_verification;
ATTACH DATABASE '__TEST_DIR__/temp.db';;
CREATE TABLE temp_db.integers(i INTEGER);;
DETACH temp_db;;
ATTACH DATABASE ':memory:' AS temp;;
ATTACH DATABASE ':memory:' AS main;;
