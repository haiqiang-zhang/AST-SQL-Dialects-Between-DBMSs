--

--disable_warnings
DROP DATABASE IF EXISTS mysqldump_test_db;

CREATE DATABASE mysqldump_test_db;
CREATE TABLE mysqldump_test_db.t1 (a INT);

CREATE EVENT mysqldump_test_db.replica_event ON SCHEDULE EVERY 3 SECOND DISABLE ON REPLICA DO SELECT 1;

SET @@GLOBAL.terminology_use_previous = BEFORE_8_0_26;

DROP DATABASE mysqldump_test_db;
