
-- This test calls flush privileges. Restart to clean up
-- source include/force_restart.inc

FLUSH PRIVILEGES;

--
-- Bug #21847825: NOT POSSIBLE TO USE ALTER USER WHEN RUNNING UNDER --SKIP-GRANT-TABLES
--

SELECT USER(),CURRENT_USER();

CREATE USER u1@localhost;
ALTER USER u1@localhost IDENTIFIED BY 'pass1';
SET PASSWORD FOR u1@localhost = 'pass2';
SET PASSWORD = 'cant have';

DROP USER u1@localhost;
